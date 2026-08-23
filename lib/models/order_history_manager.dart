import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cart_manager.dart';
import '../features/store/models/store_product.dart';

class OrderModel {
  final String id;
  final DateTime date;
  final double total;
  final List<CartItem> items;

  OrderModel({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'total': total,
      'items': items.map((item) => {
        'productId': item.product.id,
        'size': item.size,
        'quantity': item.quantity,
      }).toList(),
    };
  }
}

class OrderHistoryManager {
  static final ValueNotifier<List<OrderModel>> ordersNotifier = ValueNotifier<List<OrderModel>>([]);

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? ordersJson = prefs.getString('order_history');
    
    if (ordersJson != null) {
      try {
        final List<dynamic> decoded = jsonDecode(ordersJson);
        final List<OrderModel> loadedOrders = [];
        
        for (var orderJson in decoded) {
          final List<CartItem> loadedItems = [];
          for (var item in orderJson['items']) {
            try {
              final product = mockStoreProducts.firstWhere((p) => p.id == item['productId']);
              loadedItems.add(CartItem(product: product, size: item['size'], quantity: item['quantity']));
            } catch (e) {
              // Ignore missing products
            }
          }
          
          loadedOrders.add(OrderModel(
            id: orderJson['id'],
            date: DateTime.parse(orderJson['date']),
            total: orderJson['total'],
            items: loadedItems,
          ));
        }
        
        ordersNotifier.value = loadedOrders;
      } catch (e) {
        // Corrupted JSON
      }
    }
  }

  static Future<void> addOrder(double total, List<CartItem> items) async {
    final current = List<OrderModel>.from(ordersNotifier.value);
    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      total: total,
      items: List.from(items),
    );
    
    current.insert(0, order);
    ordersNotifier.value = current;
    
    final prefs = await SharedPreferences.getInstance();
    final data = current.map((e) => e.toJson()).toList();
    await prefs.setString('order_history', jsonEncode(data));
  }
}
