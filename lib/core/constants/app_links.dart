/// Every external URL, in one place.
///
/// Anything still empty is a deliberate TODO — [Launcher] shows a friendly
/// message instead of failing silently, so an unfinished link never looks
/// like a broken site.
class AppLinks {
  AppLinks._();

  static const String email = 'yashkhade1598@gmail.com';
  static const String github = 'https://github.com/yk-otcdesk';
  static const String linkedin = 'https://linkedin.com/in/yash-khade';

  /// Put the PDF at web/Yash_Khade_Resume.pdf — it is then served from the
  /// site root. A full https:// URL also works here.
  static const String resume = '/Yash_Khade_Resume.pdf';

  static const String location = 'Pune, India';

  /// const form, so it can be used inside const data lists.
  static const String mailtoConst = 'mailto:$email';

  static String get mailto => mailtoConst;

  static String mailtoWithSubject(String subject, {String? body}) {
    final query = <String>[
      'subject=${Uri.encodeComponent(subject)}',
      if (body != null) 'body=${Uri.encodeComponent(body)}',
    ].join('&');

    return 'mailto:$email?$query';
  }
}
