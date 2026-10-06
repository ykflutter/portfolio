/// Screen-width breakpoints. One source of truth — never hardcode a width
/// comparison anywhere else.
enum ScreenSize { mobile, tablet, desktop, wide }

class Breakpoints {
  Breakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;

  static ScreenSize of(double width) {
    if (width < mobile) return ScreenSize.mobile;
    if (width < tablet) return ScreenSize.tablet;
    if (width < desktop) return ScreenSize.desktop;
    return ScreenSize.wide;
  }
}
