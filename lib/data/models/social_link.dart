import 'package:flutter/material.dart';

class SocialLink {
  final String label;
  final String value;
  final String url;
  final IconData icon;

  const SocialLink({
    required this.label,
    required this.value,
    required this.url,
    required this.icon,
  });

  bool get isLive => url.trim().isNotEmpty;
}
