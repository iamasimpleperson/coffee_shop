import 'package:flutter/material.dart';
import 'coffee_detail.dart';

// Mock model for API data
class CoffeeOption {
  final String id;
  final String name;
  // We use IconData for now as a placeholder for an image URL from an API.
  final IconData icon;

  CoffeeOption({required this.id, required this.name, required this.icon});
}

// Mock API response
final List<CoffeeOption> mockCoffeeOptions = [
  CoffeeOption(id: '1', name: 'Cappuccino', icon: Icons.coffee),
  CoffeeOption(id: '2', name: 'Latte', icon: Icons.local_cafe),
  CoffeeOption(id: '3', name: 'Latte\nMacchiato', icon: Icons.coffee_maker),
  CoffeeOption(id: '4', name: 'Espresso', icon: Icons.local_cafe_outlined),
  CoffeeOption(
    id: '5',
    name: 'Double\nEspresso',
    icon: Icons.emoji_food_beverage,
  ),
  CoffeeOption(
    id: '6',
    name: 'Americano',
    icon: Icons.emoji_food_beverage_outlined,
  ),
];

class ChooseCoffee extends StatelessWidget {
  const ChooseCoffee({super.key});

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
          const Text(
            'Choose your coffee',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.95,
            ),
            itemCount: mockCoffeeOptions.length,
            itemBuilder: (context, index) {
              final option = mockCoffeeOptions[index];
              return _buildCoffeeCard(context, option);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCoffeeCard(BuildContext context, CoffeeOption option) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          backgroundColor: Colors.transparent,
          builder: (context) => CoffeeDetail(coffee: option),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(option.icon, size: 48, color: Colors.brown[400]),
            const SizedBox(height: 16),
            Text(
              option.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
