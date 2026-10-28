import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../data/models/project.dart';
import '../motion/hover_builder.dart';
import '../motion/hud_corners.dart';
import 'browser_mockup.dart';
import 'phone_mockup.dart';
import 'screenshot_viewer.dart';
import 'shot_placeholder.dart';

/// A horizontal strip of a project's screenshots in phone or browser frames.
/// Tap one to open it full-screen. Draggable with a mouse, with arrow
/// buttons on desktop.
///
/// With no screenshots yet, it shows three placeholder frames that are not
/// tappable — nothing on the page pretends to be a button.
class ScreenshotStrip extends StatefulWidget {
  final Project project;

  const ScreenshotStrip({super.key, required this.project});

  @override
  State<ScreenshotStrip> createState() => _ScreenshotStripState();
}

class _ScreenshotStripState extends State<ScreenshotStrip> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _step(double direction, double itemWidth) {
    if (!_scroll.hasClients) return;

    final target = (_scroll.offset + direction * (itemWidth + AppSpacing.md) * 2)
        .clamp(0.0, _scroll.position.maxScrollExtent)
        .toDouble();

    _scroll.animateTo(
      target,
      duration: AppDurations.medium,
      curve: AppDurations.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final shots = project.screenshots;
    final hasShots = shots.isNotEmpty;
    final count = hasShots ? shots.length : 3;

    final itemWidth = project.isWeb
        ? (context.isMobile ? context.screen.width * 0.78 : 520.0)
        : (context.isMobile ? 168.0 : 216.0);

    final itemHeight = project.isWeb
        ? BrowserMockup.heightFor(itemWidth)
        : PhoneMockup.heightFor(itemWidth);

    // Room above and below for the hover lift, HUD corners and shadow.
    const pad = AppSpacing.lg;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: itemHeight + pad * 2,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
              dragDevices: const {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.stylus,
              },
            ),
            child: ListView.separated(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                vertical: pad,
                horizontal: AppSpacing.sm,
              ),
              itemCount: count,
              separatorBuilder: (_, _) => const Gap.h(AppSpacing.md),
              itemBuilder: (context, i) {
                final frame = _frame(
                  context,
                  path: hasShots ? shots[i] : null,
                  width: itemWidth,
                );

                if (!hasShots) return frame;

                return _ShotTile(
                  label: 'Open screenshot ${i + 1} of ${shots.length}',
                  onTap: () => ScreenshotViewer.open(
                    context,
                    paths: shots,
                    initialIndex: i,
                  ),
                  child: frame,
                );
              },
            ),
          ),
        ),
        const Gap(AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                hasShots
                    ? '${shots.length} screens  ·  tap any screen to enlarge'
                    : 'Screens coming soon',
                style: AppTypography.micro.copyWith(
                  color: context.ink(AppColors.emphasisFaint),
                ),
              ),
            ),
            if (hasShots && !context.isMobile) ...[
              _ArrowButton(
                icon: Icons.arrow_back_rounded,
                tooltip: 'Scroll left',
                onTap: () => _step(-1, itemWidth),
              ),
              const Gap.h(AppSpacing.xs),
              _ArrowButton(
                icon: Icons.arrow_forward_rounded,
                tooltip: 'Scroll right',
                onTap: () => _step(1, itemWidth),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _frame(BuildContext context, {String? path, required double width}) {
    final project = widget.project;
    final placeholder = ShotPlaceholder(
      initials: project.initials,
      label: 'Screen coming soon',
      initialsSize: width * 0.16,
    );

    if (project.isWeb) {
      return BrowserMockup(
        imagePath: path,
        width: width,
        placeholder: placeholder,
      );
    }

    return PhoneMockup(imagePath: path, width: width, placeholder: placeholder);
  }
}

/// One tappable screenshot: lifts and shows HUD corners on hover.
class _ShotTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final String label;

  const _ShotTile({
    required this.child,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: HoverBuilder(
        builder: (context, hovered) => GestureDetector(
          onTap: onTap,
          child: AnimatedSlide(
            offset: hovered ? const Offset(0, -0.02) : Offset.zero,
            duration: AppDurations.fast,
            curve: AppDurations.ease,
            child: HudCorners(visible: hovered, child: child),
          ),
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _ArrowButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: HoverBuilder(
        builder: (context, hovered) => GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hovered ? context.ink(AppColors.emphasisWash) : null,
              border: Border.all(
                color: context.ink(
                  hovered ? AppColors.emphasisFaint : AppColors.emphasisHairline,
                ),
              ),
            ),
            child: Icon(icon, size: 16, color: context.cs.onSurface),
          ),
        ),
      ),
    );
  }
}
