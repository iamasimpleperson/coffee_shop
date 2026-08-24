import 'package:coffee_shop/features/machine/screens/machine_screen.dart';
import 'package:coffee_shop/features/onboarding/screens/onboarding_screen.dart';
import 'package:coffee_shop/routes/modules/auth_route.dart';
import 'package:coffee_shop/routes/modules/shop_route.dart';
import 'package:coffee_shop/routes/modules/onbording_route.dart';
import 'package:coffee_shop/routes/route_name.dart';
import '../features/cart/screens/cart_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_notifier.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

// Publicly accessible paths
const List<String> publicRoutes = [
  AppRoutes.root,
  AppRoutes.login,
  AppRoutes.register,
  AppRoutes.home,
  AppRoutes.onboarding,
  AppRoutes.products,
  AppRoutes.store,
  AppRoutes.storeProductDetail,
  AppRoutes.profile,
  '/order-history',
];

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authProvider, (_, __) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.root,
    refreshListenable: notifier,
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.uri.toString()}')),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = ref.read(authProvider).isAuthenticated;
      final String location = state.matchedLocation;

      final bool isPublicRoute = publicRoutes.any(
        (route) => route == '/' ? location == '/' : location.startsWith(route),
      );
      final bool isAuthScreen =
          location == AppRoutes.login || location == AppRoutes.register;

      // 1. Block unauthenticated access to private pages
      if (!loggedIn && !isPublicRoute) {
        return AppRoutes.login;
      }

      // 2. Redirect logged-in users away from login/register screens and root
      if (loggedIn && (isAuthScreen || location == AppRoutes.root)) {
        return AppRoutes.home;
      }

      // 3. Allow access
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.machine,
        builder: (context, state) => const MachineScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/order-history',
        builder: (context, state) => const OrderHistoryScreen(),
      ),

      // Merge module route lists
      ...authRoutes,
      ...shopRoutes,
      ...onbordingRoutes,
    ],
  );
});
