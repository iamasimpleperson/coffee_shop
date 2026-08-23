import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/cart_manager.dart';
import '../../../models/checkout_manager.dart';
import '../../../models/order_history_manager.dart';
import '../widgets/address_bottom_sheet.dart';
import '../widgets/payment_bottom_sheet.dart';
import '../widgets/success_bottom_sheet.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isLoading = false;

  void _onPayNow() async {
    setState(() => _isLoading = true);
    
    // Simulate network request
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      final subtotal = CartManager.getTotalPrice();
      final shipping = CheckoutManager.getShippingCost();
      await OrderHistoryManager.addOrder(subtotal + shipping, CartManager.cartItemsNotifier.value);
      CartManager.clearCart();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => const SuccessBottomSheet(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F7F9),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: ValueListenableBuilder<AddressData?>(
        valueListenable: CheckoutManager.addressNotifier,
        builder: (context, address, child) {
          return ValueListenableBuilder<String?>(
            valueListenable: CheckoutManager.paymentMethodNotifier,
            builder: (context, paymentMethod, child) {
              return ValueListenableBuilder<String>(
                valueListenable: CheckoutManager.deliveryMethodNotifier,
                builder: (context, deliveryMethod, child) {
                  final isReady = address != null && paymentMethod != null;
                  final subtotal = CartManager.getTotalPrice();
                  final shipping = CheckoutManager.getShippingCost();
                  final total = subtotal + shipping;

                  return Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Delivery Address
                            const Text('Delivery address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useRootNavigator: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const AddressBottomSheet(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, color: Colors.black54),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        address?.displayAddress ?? 'Select address',
                                        style: TextStyle(
                                          color: address != null ? Colors.black : Colors.grey[600],
                                          fontSize: 15,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Payment Method
                            const Text('Payment method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  useRootNavigator: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const PaymentBottomSheet(),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.payment_outlined, color: Colors.black54),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        paymentMethod ?? 'Select method',
                                        style: TextStyle(
                                          color: paymentMethod != null ? Colors.black : Colors.grey[600],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    const Icon(Icons.chevron_right, color: Colors.grey),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Delivery Method (Only show if address is selected)
                            if (address != null) ...[
                              const Text('Delivery method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 12),
                              _buildDeliveryOption('Standard', '3-5 business days', 0.0, deliveryMethod),
                              const SizedBox(height: 12),
                              _buildDeliveryOption('Express', 'Tomorrow', 4.50, deliveryMethod),
                              const SizedBox(height: 24),
                            ],

                            // Order Summary
                            const Text('Order summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Subtotal', style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                                Text('£${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Shipping', style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                                Text(shipping == 0 ? 'Free' : '£${shipping.toStringAsFixed(2)}', 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                Text('£${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Bottom Pay Button
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 16,
                            bottom: MediaQuery.of(context).padding.bottom + 16,
                          ),
                          decoration: const BoxDecoration(
                            color: const Color(0xFFF6F7F9),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: isReady && !_isLoading ? _onPayNow : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                disabledBackgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                              child: _isLoading 
                                ? const SizedBox(
                                    height: 24, 
                                    width: 24, 
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                  )
                                : Text(
                                    'Pay now £${total.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: isReady ? Colors.white : Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              );
            }
          );
        }
      ),
    );
  }

  Widget _buildDeliveryOption(String title, String subtitle, double cost, String currentMethod) {
    final isSelected = title == currentMethod;
    
    return GestureDetector(
      onTap: () => CheckoutManager.setDeliveryMethod(title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),
            ),
            Text(
              cost == 0 ? 'Free' : '£${cost.toStringAsFixed(2)}',
              style: TextStyle(
                color: cost == 0 ? const Color(0xFF6AC79E) : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
