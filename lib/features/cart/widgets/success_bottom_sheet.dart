import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/cart_manager.dart';
import '../../../models/checkout_manager.dart';
import '../../../routes/route_name.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 40,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFF0F0FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 48, color: Color(0xFF9080F0)),
          ),
          const SizedBox(height: 24),
          const Text(
            "We've got your order!",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Thank you for shopping with us.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                CartManager.clearCart();
                CheckoutManager.reset();
                // Pop the bottom sheet
                Navigator.pop(context);
                // Pop the checkout screen, and Cart Screen, returning to Store
                context.go(AppRoutes.store);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
