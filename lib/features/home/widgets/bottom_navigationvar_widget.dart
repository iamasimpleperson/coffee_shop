import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:coffee_shop/features/coffee/screens/choose_coffee.dart';

class BottomNavigationvarWidget extends StatelessWidget {
  const BottomNavigationvarWidget({super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    // We don't check for chooseCoffee anymore since it's a modal, not a route
    if (location.startsWith(AppRoutes.store)) {
      return 2;
    }
    return 0; // Default to home
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const ChooseCoffee(),
        );
        break;
      case 2:
        context.go('/store');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (int index) => _onItemTapped(index, context),
      selectedItemColor: const Color(0xFF6AC79E),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
        BottomNavigationBarItem(
          icon: Icon(Icons.coffee, ),
          label: '',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
      ],
    );
  }
}
