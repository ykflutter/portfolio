/// The spacing scale. Every gap, margin and padding comes from here.
///
/// Values are a 4pt base with a doubling rhythm — predictable vertical
/// rhythm is most of what makes a layout feel designed rather than assembled.
class AppSpacing {
  AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;
  static const double xxl = 64;
  static const double xxxl = 96;

  /// Gap between major page sections.
  static const double sectionMobile = 72;
  static const double sectionDesktop = 128;

  /// Page gutters.
  static const double gutterMobile = 24;
  static const double gutterTablet = 48;
  static const double gutterDesktop = 80;

  /// Content never stretches wider than this, however wide the window.
  static const double maxContentWidth = 1200;
}
