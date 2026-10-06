
class AppAssets {
  AppAssets._();

  static const String _img = 'assets/images';
  static const String _logo = 'assets/logo';
  static const String _logoLight = 'assets/logo_w';

  static const String portrait = '$_img/portrait.jpg';

  static const String backdrop = '$_img/backdrop.jpg';

  static const List<String> logoDark = [
    '$_logoLight/1.png',
    '$_logoLight/2.png',
    '$_logoLight/3.png',
    '$_logoLight/4.png',
  ];

  static const List<String> logoLight = [
    '$_logo/1.png',
    '$_logo/2.png',
    '$_logo/3.png',
    '$_logo/4.png',
  ];

  /// Project screenshots live under assets/images/projects/<slug>/
  static String projectShot(String slug, int index) =>
      '$_img/projects/$slug/$index.png';
}
