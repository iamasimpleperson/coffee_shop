import 'package:flutter/material.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';
import 'package:coffee_shop/services/coffee_service.dart';
import 'package:coffee_shop/models/store_product_model.dart';
import 'coffee_detail.dart';

// Mock model for API data
class CoffeeOption {
  final String id;
  final String name;
  // We use IconData for now as a placeholder for an image URL from an API.
  final IconData icon;
  final String? size;
  final String? flavor;

  CoffeeOption({
    required this.id,
    required this.name,
    required this.icon,
    this.size,
    this.flavor,
  });
}

class ChooseCoffee extends StatefulWidget {
  const ChooseCoffee({super.key});

  @override
  State<ChooseCoffee> createState() => _ChooseCoffeeState();
}

class _ChooseCoffeeState extends State<ChooseCoffee> {
  String? _selectedCoffeeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Close button
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.black87),
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)?.chooseCoffee ?? 'Choose your coffee',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          FutureBuilder<List<StoreProductModel>>(
            future: CoffeeService().getCoffees(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(
                            context,
                          )?.error(snapshot.error.toString()) ??
                          'Error: ${snapshot.error}',
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: Text('No coffees available')),
                );
              }

              final coffees = snapshot.data!;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: coffees.length,
                itemBuilder: (context, index) {
                  final coffee = coffees[index];

                  // Determine icon based on name (if API doesn't provide it)
                  IconData iconData = Icons.coffee;
                  if (coffee.name.contains('Latte'))
                    iconData = Icons.local_cafe;
                  if (coffee.name.contains('Espresso'))
                    iconData = Icons.local_cafe_outlined;

                  return _buildCoffeeOption(coffee.id, coffee.name, iconData);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeOption(String id, String label, IconData icon) {
    final isSelected = _selectedCoffeeId == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCoffeeId = id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC67C4E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFC67C4E) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFC67C4E).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.white : const Color(0xFF2F2D2C),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isSelected ? Colors.white : const Color(0xFF2F2D2C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
