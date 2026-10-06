import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../core/utils/app_messenger.dart';
import '../shared/motion/theme_reveal_host.dart';
import 'router/app_router.dart';
import 'theme_controller.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, mode, _) {
        return MaterialApp.router(
          title: 'Yash Khade — Flutter Developer',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: AppMessenger.key,
          routerConfig: AppRouter.router,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          // Keeps type legible if a visitor has a large system font set,
          // without letting it blow the layout apart.
          builder: (context, child) {
            final scale = MediaQuery.textScalerOf(context).scale(1).clamp(
                  1.0,
                  1.2,
                );

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(scale),
              ),
              // Hosts the circular theme-switch overlay above every page.
              child: ThemeRevealHost(
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
        );
      },
    );
  }
}
