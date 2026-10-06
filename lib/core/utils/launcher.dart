import 'package:url_launcher/url_launcher.dart';

import '../constants/app_links.dart';
import 'app_messenger.dart';

/// Opens external links. Never fails silently — an empty or broken URL
/// surfaces a readable message instead of doing nothing, which is the most
/// common way a portfolio looks broken.
class Launcher {
  Launcher._();

  static Future<void> open(String url, {String? unavailableMessage}) async {
    if (url.trim().isEmpty) {
      AppMessenger.show(unavailableMessage ?? 'This link is not available yet.');
      return;
    }

    final uri = Uri.tryParse(url);

    if (uri == null) {
      AppMessenger.show('Could not open this link.');
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (!launched) AppMessenger.show('Could not open this link.');
    } catch (_) {
      AppMessenger.show('Could not open this link.');
    }
  }

  /// Opens the user's mail client, optionally pre-filling a subject.
  static Future<void> email({String? subject}) {
    return open(
      subject == null
          ? AppLinks.mailto
          : AppLinks.mailtoWithSubject(subject),
      unavailableMessage: 'Email address is not set.',
    );
  }

    /// Opens a file hosted alongside the site — the resume, for instance.
  ///
  /// Accepts either a full URL or a root-relative path like
  /// `/Yash_Khade_Resume.pdf`, which is resolved against the current origin
  /// so it behaves identically on localhost and in production.
  ///
  /// Opens in the same tab on purpose: the server sends the PDF as an
  /// attachment, so the browser downloads it without navigating away. A new
  /// tab would flash open and close.
  static Future<void> document(String path, {String? unavailableMessage}) async {
    if (path.trim().isEmpty) {
      AppMessenger.show(unavailableMessage ?? 'This file is not available yet.');
      return;
    }

    final uri = path.startsWith('http')
        ? Uri.tryParse(path)
        : Uri.base.resolve(path);

    if (uri == null) {
      AppMessenger.show('Could not open this file.');
      return;
    }

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.platformDefault,
        webOnlyWindowName: '_self',
      );

      if (!launched) AppMessenger.show('Could not open this file.');
    } catch (_) {
      AppMessenger.show('Could not open this file.');
    }
  }
}
