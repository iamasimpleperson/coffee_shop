import 'package:coffee_shop/services/coffee_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../routes/route_name.dart';
import '../../cart/models/cart_manager.dart';
import '../../../models/store_product_model.dart';
import 'cart_screen.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          AppLocalizations.of(context)?.ourCoffee ?? 'Store',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              final count = ref.watch(cartCountProvider);
              return Container(
                margin: const EdgeInsets.only(right: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 24),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useRootNavigator: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => const CartScreen(),
                        );
                      },
                    ),
                    if (count > 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black, size: 24),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<StoreProductModel>>(
        future: CoffeeService().getCoffees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(AppLocalizations.of(context)?.error(snapshot.error.toString()) ?? 'Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)?.noProductsAvailable ?? 'No products available.'));
          }

          final products = snapshot.data!;
          // Using category_id to distinguish between Beans and Care. Let's assume categoryid == 1 is Beans
          final beans = products.where((p) => p.categoryid == 0 || p.categoryid == 1).toList();
          final care = products.where((p) => p.categoryid == 2).toList(); 

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(context, 'Beans', beans),
                const SizedBox(height: 32),
                if (care.isNotEmpty) ...[
                  _buildSection(context, 'Care', care),
                  const SizedBox(height: 32),
                ]
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<StoreProductModel> products) {
    if (products.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(context, products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, StoreProductModel product) {
    final isBeans = product.categoryid == 0 || product.categoryid == 1;
    final placeholderColor = isBeans ? const Color(0xFFFFECCC) : const Color(0xFFF0F2F5);
    final icon = isBeans ? Icons.coffee_maker : Icons.sanitizer;
    final sizeText = product.sizes.isNotEmpty ? product.sizes.first : '';

    return GestureDetector(
      onTap: () {
        context.push('${AppRoutes.storeProductDetail}?id=${product.id}');
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'store_product_${product.id}',
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: placeholderColor,
                  borderRadius: BorderRadius.circular(24),
                  image: product.image.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(product.image),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: product.image.isEmpty
                    ? Center(
                        child: Icon(icon, size: 64, color: Colors.black26),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name + (sizeText.isNotEmpty ? ',\n$sizeText' : ''),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, size: 18, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
