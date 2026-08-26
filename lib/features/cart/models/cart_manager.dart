import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/store_product_model.dart';
import 'package:coffee_shop/services/coffee_service.dart';

class CartItem {
  final StoreProductModel product;
  final String size;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString('cart_items');
    
    if (cartJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cartJson);
        final List<CartItem> loadedItems = [];
        final apiCoffees = await CoffeeService().getCoffees();

        for (var item in decoded) {
          final productId = item['productId'];
          final size = item['size'];
          final quantity = item['quantity'];
          
          try {
            final product = apiCoffees.firstWhere((p) => p.id == productId);
            loadedItems.add(CartItem(product: product, size: size, quantity: quantity));
          } catch (e) {
            // Product not found
          }
        }
        state = loadedItems;
      } catch (e) {
        // Corrupted JSON
      }
    }
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data = state.map((item) {
      return {
        'productId': item.product.id,
        'size': item.size,
        'quantity': item.quantity,
      };
    }).toList();
    
    await prefs.setString('cart_items', jsonEncode(data));
  }

  void addToCart(StoreProductModel product, String size, int quantity) {
    final currentList = List<CartItem>.from(state);
    
    final index = currentList.indexWhere((item) => item.product.id == product.id && item.size == size);
    
    if (index != -1) {
      currentList[index].quantity += quantity;
    } else {
      currentList.add(CartItem(product: product, size: size, quantity: quantity));
    }
    
    state = currentList;
    _saveCart();
  }

  void updateQuantity(CartItem cartItem, int delta) {
    final currentList = List<CartItem>.from(state);
    final index = currentList.indexWhere((item) => item.product.id == cartItem.product.id && item.size == cartItem.size);
    
    if (index != -1) {
      currentList[index].quantity += delta;
      if (currentList[index].quantity <= 0) {
        currentList.removeAt(index);
      }
      state = currentList;
      _saveCart();
    }
  }

  void removeItem(CartItem cartItem) {
    final currentList = List<CartItem>.from(state);
    currentList.removeWhere((item) => item.product.id == cartItem.product.id && item.size == cartItem.size);
    state = currentList;
    _saveCart();
  }

  void clearCart() {
    state = [];
    _saveCart();
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});

final cartCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.quantity);
});

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0.0, (sum, item) => sum + item.totalPrice);
});
