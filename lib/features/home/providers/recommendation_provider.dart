import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_shop/models/order_history_manager.dart';
import 'package:coffee_shop/models/store_product_model.dart';
import 'package:coffee_shop/services/coffee_service.dart';

final recommendationProvider = FutureProvider<StoreProductModel>((ref) async {
  final orderHistory = ref.watch(orderHistoryProvider);
  final coffees = await CoffeeService().getCoffees();

  if (coffees.isEmpty) {
    throw Exception('No coffees available for recommendation');
  }

  // If no order history, return a default premium blend (e.g. first one)
  final defaultProduct = coffees.first;

  if (orderHistory.isEmpty) {
    return defaultProduct;
  }

  // Count frequencies of purchased beans
  final Map<String, int> productCounts = {};
  for (final order in orderHistory) {
    for (final item in order.items) {
      if (item.product.categoryid == 0 || item.product.categoryid == 1) { // Beans
        productCounts[item.product.id] =
            (productCounts[item.product.id] ?? 0) + item.quantity;
      }
    }
  }

  if (productCounts.isEmpty) {
    return defaultProduct;
  }

  // Find the product ID with the highest count
  String topProductId = '';
  int maxCount = 0;
  productCounts.forEach((id, count) {
    if (count > maxCount) {
      maxCount = count;
      topProductId = id;
    }
  });

  // Return the corresponding StoreProductModel
  return coffees.firstWhere(
    (p) => p.id == topProductId,
    orElse: () => defaultProduct,
  );
});
