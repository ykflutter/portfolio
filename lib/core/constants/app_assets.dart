/// Every asset path in the app, in one place.
class AppAssets {
  AppAssets._();

  static const String _img = 'assets/images';
  static const String _profile = '$_img/profile';
  static const String _projects = '$_img/projects';

  /// Stand-in for the logo frames until the real files are added.
  static const String _logoPlaceholder = '$_profile/logo.png';

  /// The animated logo, played in this order: frame 1 → 4.
  ///
  /// To switch to the real frames, replace the four entries with:
  ///   'assets/logo/1.png', 'assets/logo/2.png',
  ///   'assets/logo/3.png', 'assets/logo/4.png',
  /// and add `- assets/logo/` under `assets:` in pubspec.yaml.
  /// No other file needs to change.
  static const List<String> logoFrames = [
    _logoPlaceholder,
    _logoPlaceholder,
    _logoPlaceholder,
    _logoPlaceholder,
  ];

  /// The same four frames for dark mode — for example a white version of
  /// the logo. Leave it pointing at [logoFrames] if one set works on both.
  static const List<String> logoFramesDark = logoFrames;

  /// Profile photo, used on the About page.
  static const String portrait = '$_profile/logo.png';

  /// assets/images/projects/<folder>/<file>
  static String projectShot(String folder, String file) =>
      '$_projects/$folder/$file';
}
