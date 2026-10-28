import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_durations.dart';
import '../../core/theme/app_typography.dart';
import '../feedback/loading_dots.dart';
import '../motion/hover_builder.dart';

/// Full-screen, zoomable screenshot viewer.
///
/// Pinch or scroll to zoom, swipe or ← → to move, Esc or ✕ to close.
/// Always dark, whatever the site theme — screenshots read best on black.
class ScreenshotViewer extends StatefulWidget {
  final List<String> paths;
  final int initialIndex;

  const ScreenshotViewer({
    super.key,
    required this.paths,
    this.initialIndex = 0,
  });

  static Future<void> open(
    BuildContext context, {
    required List<String> paths,
    int initialIndex = 0,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close screenshots',
      barrierColor: AppColors.darkBackground.withValues(alpha: 0.94),
      transitionDuration: AppDurations.fast,
      pageBuilder: (_, _, _) =>
          ScreenshotViewer(paths: paths, initialIndex: initialIndex),
      transitionBuilder: (_, animation, _, child) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.97, end: 1).animate(animation),
          child: child,
        ),
      ),
    );
  }

  @override
  State<ScreenshotViewer> createState() => _ScreenshotViewerState();
}

class _ScreenshotViewerState extends State<ScreenshotViewer> {
  late final PageController _pages =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  int get _count => widget.paths.length;

  void _go(int index) {
    if (index < 0 || index >= _count) return;
    _pages.animateToPage(
      index,
      duration: AppDurations.medium,
      curve: AppDurations.easeInOut,
    );
  }

  void _close() => Navigator.of(context).maybePop();

  KeyEventResult _onKey(FocusNode _, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      _go(_index + 1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      _go(_index - 1);
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _close();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const ink = AppColors.darkInk;

    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: PhotoViewGallery.builder(
                  itemCount: _count,
                  pageController: _pages,
                  onPageChanged: (i) => setState(() => _index = i),
                  backgroundDecoration: const BoxDecoration(
                    color: AppColors.transparent,
                  ),
                  loadingBuilder: (_, _) =>
                      const Center(child: LoadingDots()),
                  builder: (context, i) => PhotoViewGalleryPageOptions(
                    imageProvider: AssetImage(widget.paths[i]),
                    minScale: PhotoViewComputedScale.contained,
                    initialScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 3,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: Text(
                  '${_index + 1} / $_count',
                  style: AppTypography.micro.copyWith(color: ink),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: _ViewerButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Close (Esc)',
                  onTap: _close,
                ),
              ),
              if (!context.isMobile && _count > 1) ...[
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _ViewerButton(
                      icon: Icons.chevron_left_rounded,
                      tooltip: 'Previous (←)',
                      onTap: _index > 0 ? () => _go(_index - 1) : null,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _ViewerButton(
                      icon: Icons.chevron_right_rounded,
                      tooltip: 'Next (→)',
                      onTap: _index < _count - 1 ? () => _go(_index + 1) : null,
                    ),
                  ),
                ),
              ],
              if (_count > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pages,
                      count: _count,
                      onDotClicked: _go,
                      effect: ExpandingDotsEffect(
                        dotWidth: 6,
                        dotHeight: 6,
                        spacing: 6,
                        expansionFactor: 3,
                        activeDotColor: ink,
                        dotColor: ink.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ViewerButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;

  const _ViewerButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const ink = AppColors.darkInk;
    final enabled = onTap != null;

    return Tooltip(
      message: tooltip,
      child: HoverBuilder(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        builder: (context, hovered) => GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ink.withValues(alpha: hovered && enabled ? 0.16 : 0.08),
            ),
            child: Icon(
              icon,
              color: ink.withValues(alpha: enabled ? 1 : 0.3),
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
