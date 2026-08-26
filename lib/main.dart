import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/auth_notifier.dart';
import 'models/schedule_manager.dart';
import 'features/home/models/favorites_manager.dart';
import 'features/cart/models/cart_manager.dart';
import 'models/order_history_manager.dart';
import 'core/theme/theme_notifier.dart';
import 'core/localization/locale_provider.dart';
import 'package:coffee_shop/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(authProvider.notifier).init();
  await container.read(favoritesProvider.notifier).init();
  await container.read(cartProvider.notifier).init();
  await container.read(orderHistoryProvider.notifier).init();
  await container.read(themeProvider.notifier).init();
  await container.read(localeProvider.notifier).init();
  container.read(scheduleProvider.notifier).init();

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final router = ref.watch(routerProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Coffee Shop',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
