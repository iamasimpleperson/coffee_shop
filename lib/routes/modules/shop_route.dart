import 'package:coffee_shop/features/coffee/screens/choose_coffee.dart';
import 'package:coffee_shop/features/home/screens/home_screen.dart';
import 'package:coffee_shop/features/home/screens/main_layout.dart';
import 'package:coffee_shop/features/store/screens/store_screen.dart';
import 'package:coffee_shop/features/store/screens/store_product_detail_screen.dart';
import 'package:coffee_shop/features/cart/screens/checkout_screen.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> shopRoutes = [
  ShellRoute(
    builder: (context, state, child) {
      return MainLayout(child: child);
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.chooseCoffee,
        builder: (context, state) => const ChooseCoffee(),
      ),
      GoRoute(
        path: AppRoutes.store,
        builder: (context, state) => const StoreScreen(),
      ),
    ],
  ),
  GoRoute(
    path: AppRoutes.storeProductDetail,
    builder: (context, state) {
      final productId = state.uri.queryParameters['id'] ?? 'b1';
      return StoreProductDetailScreen(productId: productId);
    },
  ),
  GoRoute(
    path: AppRoutes.checkout,
    builder: (context, state) => const CheckoutScreen(),
  ),
];
