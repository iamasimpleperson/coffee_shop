import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/cart_manager.dart';
import '../models/store_product.dart';
import 'package:coffee_shop/routes/auth_notifier.dart';

class StoreProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const StoreProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<StoreProductDetailScreen> createState() => _StoreProductDetailScreenState();
}

class _StoreProductDetailScreenState extends ConsumerState<StoreProductDetailScreen> {
  int _quantity = 1;
  String _selectedSize = '';

  @override
  void initState() {
    super.initState();
    final product = mockStoreProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => mockStoreProducts.first,
    );
    if (product.sizes.isNotEmpty) {
      _selectedSize = product.sizes.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = mockStoreProducts.firstWhere(
      (p) => p.id == widget.productId,
      orElse: () => mockStoreProducts.first,
    );

    final isBeans = product.category == 'Beans';
    final placeholderColor = isBeans ? const Color(0xFFFFECCC) : const Color(0xFFF0F2F5);
    final icon = isBeans ? Icons.coffee_maker : Icons.sanitizer;
    final totalPrice = product.price * _quantity;

    return Scaffold(
      backgroundColor: placeholderColor,
      body: Stack(
        children: [
          // Background Placeholder Image
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Hero(
              tag: 'store_product_${product.id}',
              child: Icon(icon, size: 200, color: Colors.black12),
            ),
          ),
          
          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, size: 20, color: Colors.black),
              ),
            ),
          ),

          // Bottom Sheet Content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.subtitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  if (product.sizes.isNotEmpty) ...[
                    const Text(
                      'Size',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: product.sizes.map((size) {
                        final isSelected = size == _selectedSize;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSize = size;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : const Color(0xFFF6F7F9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  size,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                  ],

                  const Text(
                    'About',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  if (product.taste != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Taste', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        Text(product.taste!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                    const Divider(height: 24),
                  ],
                  
                  if (product.sweetness != null) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Sweetness', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                        Text(product.sweetness!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                    const Divider(height: 24),
                  ],

                  const Spacer(),
                  
                  // Bottom Add to Cart row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6F7F9),
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                              child: const Icon(Icons.remove, size: 20, color: Colors.black54),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '$_quantity',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 16),
                            GestureDetector(
                              onTap: () {
                                setState(() => _quantity++);
                              },
                              child: const Icon(Icons.add, size: 20, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              if (!ref.read(authProvider).isAuthenticated) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Login Required'),
                                    content: const Text('Please log in to add to cart.'),
                                    actions: [
                                      TextButton(onPressed: () => context.pop(), child: const Text('Back')),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.pop();
                                          context.push('/login');
                                        },
                                        child: const Text('Log In'),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              ref.read(cartProvider.notifier).addToCart(product, _selectedSize, _quantity);
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Added $_quantity item(s) to cart!')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                            ),
                            child: Text(
                              'Add £${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
