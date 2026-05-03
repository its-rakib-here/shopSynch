import 'package:flutter/material.dart';

import 'core/config/api_router.dart';
import 'core/config/app_theme.dart';
import 'core/config/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shared/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: ShopSyncApp()));
}

class ShopSyncApp extends ConsumerWidget {
  const ShopSyncApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// Theme system
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      /// Initial route (instead of home)
      initialRoute: AppRoutes.onboarding,

      /// Central routing system
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}