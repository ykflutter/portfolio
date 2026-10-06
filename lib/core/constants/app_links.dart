/// Every external URL, in one place.
///
/// Anything still empty is a deliberate TODO — [Launcher] shows a friendly
/// message instead of failing silently, so an unfinished link never looks
/// like a broken site.
class AppLinks {
  AppLinks._();

  static const String email = 'yk.flutter@gmail.com';
  static const String github = 'https://github.com/yk-otcdesk';
  static const String linkedin = 'https://linkedin.com/in/yash-khade';

  /// TODO: host the PDF and paste the URL here.
  static const String resume = '/Yash_Khade_Resume.pdf';

  /// TODO: fill in if/when the Medium profile is live.
  static const String medium = '';

  /// TODO: public app listings, if any.
  static const String playStore = '';
  static const String appStore = '';

  static const String location = 'Pune, Maharashtra, India';

  /// const form, so it can be used inside const data lists.
  static const String mailtoConst = 'mailto:$email';

  static String get mailto => mailtoConst;

  static String mailtoWithSubject(String subject) =>
      'mailto:$email?subject=${Uri.encodeComponent(subject)}';
}
