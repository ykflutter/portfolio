import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_text_field.dart';

class AppTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int lines;
  final bool enabled;
  final String? Function(String?)? validator;

  const AppTextArea({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.lines = 4,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      maxLines: lines,
      enabled: enabled,
      validator: validator,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
