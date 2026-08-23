import 'package:coffee_shop/features/auth/screens/login_screen.dart';
import 'package:coffee_shop/features/auth/screens/register_screen.dart';
import 'package:coffee_shop/features/profile/screens/profile_screen.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> authRoutes = [
  GoRoute(
    path: AppRoutes.login,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: AppRoutes.register,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: AppRoutes.profile,
    builder: (context, state) => const ProfileScreen(),
  ),
];