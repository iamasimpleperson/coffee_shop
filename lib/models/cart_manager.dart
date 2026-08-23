import 'package:flutter/foundation.dart';
import '../features/store/models/store_product.dart';

class CartItem {
  final StoreProduct product;
  final String size;
  int quantity;

  CartItem({
    required this.product,
    required this.size,
    required this.quantity,
  });

  double get totalPrice => product.price * quantity;
}

class CartManager {
  static final ValueNotifier<List<CartItem>> cartItemsNotifier = ValueNotifier<List<CartItem>>([]);
  
  // Total quantity of all items in cart (for the badge)
  static final ValueNotifier<int> cartCountNotifier = ValueNotifier<int>(0);

  static void _updateTotalCount() {
    int total = 0;
    for (var item in cartItemsNotifier.value) {
      total += item.quantity;
    }
    cartCountNotifier.value = total;
  }

  static void addToCart(StoreProduct product, String size, int quantity) {
    final currentList = List<CartItem>.from(cartItemsNotifier.value);
    
    // Check if the item already exists in the cart
    final index = currentList.indexWhere((item) => item.product.id == product.id && item.size == size);
    
    if (index != -1) {
      currentList[index].quantity += quantity;
    } else {
      currentList.add(CartItem(product: product, size: size, quantity: quantity));
    }
    
    cartItemsNotifier.value = currentList;
    _updateTotalCount();
  }

  static void updateQuantity(CartItem cartItem, int delta) {
    final currentList = List<CartItem>.from(cartItemsNotifier.value);
    final index = currentList.indexWhere((item) => item.product.id == cartItem.product.id && item.size == cartItem.size);
    
    if (index != -1) {
      currentList[index].quantity += delta;
      if (currentList[index].quantity <= 0) {
        currentList.removeAt(index);
      }
      cartItemsNotifier.value = currentList;
      _updateTotalCount();
    }
  }

  static void removeItem(CartItem cartItem) {
    final currentList = List<CartItem>.from(cartItemsNotifier.value);
    currentList.removeWhere((item) => item.product.id == cartItem.product.id && item.size == cartItem.size);
    cartItemsNotifier.value = currentList;
    _updateTotalCount();
  }

  static void clearCart() {
    cartItemsNotifier.value = [];
    _updateTotalCount();
  }

  static double getTotalPrice() {
    double total = 0.0;
    for (var item in cartItemsNotifier.value) {
      total += item.totalPrice;
    }
    return total;
  }
}
