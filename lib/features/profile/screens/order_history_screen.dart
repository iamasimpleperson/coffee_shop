import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import '../../../models/order_history_manager.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ValueListenableBuilder<List<OrderModel>>(
        valueListenable: OrderHistoryManager.ordersNotifier,
        builder: (context, orders, child) {
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No orders yet', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order.id.substring(order.id.length - 6)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '£${order.total.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF6AC79E)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMMM d, yyyy - h:mm a').format(order.date),
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const Divider(height: 24),
                      ...order.items.map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Text('${item.quantity}x', style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(child: Text('${item.product.name} (${item.size})')),
                            Text('£${item.totalPrice.toStringAsFixed(2)}', style: TextStyle(color: Colors.grey[600])),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
