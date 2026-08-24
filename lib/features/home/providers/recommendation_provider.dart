import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coffee_shop/models/order_history_manager.dart';
import 'package:coffee_shop/features/store/models/store_product.dart';

final recommendationProvider = Provider<StoreProduct>((ref) {
  final orderHistory = ref.watch(orderHistoryProvider);

  // If no order history, return a default premium blend (e.g. Sunshine blend - b3)
  final defaultProduct = mockStoreProducts.firstWhere(
    (p) => p.id == 'b3',
    orElse: () => mockStoreProducts.first,
  );

  if (orderHistory.isEmpty) {
    return defaultProduct;
  }

  // Count frequencies of purchased beans
  final Map<String, int> productCounts = {};
  for (final order in orderHistory) {
    for (final item in order.items) {
      if (item.product.category == 'Beans') {
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

  // Return the corresponding StoreProduct
  return mockStoreProducts.firstWhere(
    (p) => p.id == topProductId,
    orElse: () => defaultProduct,
  );
});
