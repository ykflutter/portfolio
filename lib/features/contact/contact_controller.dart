import 'package:flutter/material.dart';

import '../../core/utils/app_messenger.dart';
import '../../core/utils/launcher.dart';

enum ContactStatus { idle, sending, sent, failed }

/// Form state and submission.
///
/// ─────────────────────────────────────────────────────────────────────────
/// HOW SUBMIT WORKS RIGHT NOW
///
/// There is no backend wired up, so the form composes a pre-filled email and
/// hands it to the visitor's mail client. That is honest and it always works
/// — no silent failures, no "message sent!" that went nowhere.
///
/// TO SEND SERVER-SIDE INSTEAD:
///   1. add `cloud_firestore` to pubspec
///   2. replace the body of [_deliver] with a Firestore write:
///
///      await FirebaseFirestore.instance.collection('messages').add({
///        'name': name, 'email': email, 'message': message,
///        'createdAt': FieldValue.serverTimestamp(),
///      });
///
///   3. lock the collection down to create-only in your rules
/// ─────────────────────────────────────────────────────────────────────────
class ContactController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ContactStatus status = ContactStatus.idle;

  bool get isSending => status == ContactStatus.sending;

  Future<void> submit() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    status = ContactStatus.sending;
    notifyListeners();

    try {
      await _deliver(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        message: messageController.text.trim(),
      );

      status = ContactStatus.sent;
      AppMessenger.show('Opening your mail app…');
    } catch (_) {
      status = ContactStatus.failed;
      AppMessenger.show('Could not send that. Email me directly instead.');
    }

    notifyListeners();
  }

  Future<void> _deliver({
    required String name,
    required String email,
    required String message,
  }) {
    final body = 'From: $name\nEmail: $email\n\n$message';

    return Launcher.open(
      'mailto:yk.flutter@gmail.com'
      '?subject=${Uri.encodeComponent('Portfolio enquiry from $name')}'
      '&body=${Uri.encodeComponent(body)}',
    );
  }

  static String? validateName(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Your name, please' : null;

  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return 'An email so I can reply';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'That does not look like an email';
    }
    return null;
  }

  static String? validateMessage(String? value) =>
      (value == null || value.trim().length < 10)
          ? 'A sentence or two is plenty'
          : null;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
