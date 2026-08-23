import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/auth_notifier.dart';
import 'models/schedule_manager.dart';
import 'models/favorites_manager.dart';
import 'models/cart_manager.dart';
import 'models/order_history_manager.dart';
import 'core/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await authNotifier.init();
  await FavoritesManager.init();
  await CartManager.init();
  await OrderHistoryManager.init();
  await themeNotifier.init();
  ScheduleManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeNotifier,
      builder: (context, _) {
        return MaterialApp.router(
          title: 'Coffee Shop',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
