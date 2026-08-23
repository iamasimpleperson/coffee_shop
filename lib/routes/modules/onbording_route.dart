import 'package:coffee_shop/features/onboarding/screens/connect_machin.dart';
import 'package:coffee_shop/routes/route_name.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/screens/home_screen.dart';

final List<RouteBase> onbordingRoutes = [
  GoRoute(
    path: AppRoutes.connectMachine,
    builder: (context, state) => const ConnectMachin(),
    routes: [
      GoRoute(
        path: 'products',
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
    ],
  ),
];
