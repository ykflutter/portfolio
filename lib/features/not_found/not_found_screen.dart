import 'package:flutter/material.dart';

import '../../app/router/route_paths.dart';
import '../../core/extensions/animate_ext.dart';
import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../shared/buttons/outline_button.dart';
import '../../shared/buttons/primary_button.dart';
import '../../shared/layout/page_scaffold.dart';
import 'widgets/glitch_code.dart';

/// Any unknown URL, and any unknown project slug.
///
///  · Back to home  → /
///  · See my work   → /work
class NotFoundScreen extends StatelessWidget {
  final ValueChanged<String> onNavigate;
  final String message;

  const NotFoundScreen({
    super.key,
    required this.onNavigate,
    this.message = 'This page does not exist, or it has moved.',
  });

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      currentPath: '',
      onNavigate: onNavigate,
      showFooter: false,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.gutter,
                  vertical: AppSpacing.xl,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const GlitchCode('404'),
                    const Gap(AppSpacing.md),
                    Text(
                      'Level not found',
                      textAlign: TextAlign.center,
                      style: AppTypography.displaySm.copyWith(
                        color: context.cs.onSurface,
                      ),
                    ).entrance(context, delay: const Duration(milliseconds: 150)),
                    const Gap(AppSpacing.sm),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyLg.copyWith(
                          color: context.ink(AppColors.emphasisMuted),
                        ),
                      ),
                    ).entrance(context, delay: const Duration(milliseconds: 250)),
                    const Gap(AppSpacing.xl),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: [
                        PrimaryButton(
                          label: 'Back to home',
                          icon: Icons.arrow_forward_rounded,
                          onTap: () => onNavigate(RoutePaths.home),
                        ),
                        OutlineActionButton(
                          label: 'See my work',
                          icon: Icons.grid_view_rounded,
                          onTap: () => onNavigate(RoutePaths.work),
                        ),
                      ],
                    ).entrance(context, delay: const Duration(milliseconds: 350)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
