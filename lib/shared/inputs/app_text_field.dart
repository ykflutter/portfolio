import 'package:flutter/material.dart';

import '../../core/extensions/context_ext.dart';
import '../../core/extensions/widget_ext.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

/// Underlined input. Boxed fields add weight a monochrome page doesn't need;
/// a single rule focuses attention on what the visitor types.
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool enabled;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLines = 1,
    this.enabled = true,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTypography.eyebrow.copyWith(
            color: context.ink(AppColors.emphasisMuted),
          ),
        ),
        const Gap(AppSpacing.xxs),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          enabled: enabled,
          textInputAction: textInputAction,
          cursorColor: context.cs.onSurface,
          style: AppTypography.bodyMd.copyWith(color: context.cs.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMd.copyWith(
              color: context.ink(AppColors.emphasisFaint),
            ),
            errorStyle: AppTypography.micro.copyWith(color: context.cs.error),
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppSpacing.sm,
            ),
            isDense: true,
            enabledBorder: _border(context, AppColors.emphasisHairline),
            disabledBorder: _border(context, AppColors.emphasisHairline),
            focusedBorder: _border(context, 1, width: 1.5),
            errorBorder: _errorBorder(context),
            focusedErrorBorder: _errorBorder(context, width: 1.5),
          ),
        ),
      ],
    );
  }

  UnderlineInputBorder _border(
    BuildContext context,
    double alpha, {
    double width = 1,
  }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: context.ink(alpha), width: width),
    );
  }

  UnderlineInputBorder _errorBorder(BuildContext context, {double width = 1}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: context.cs.error, width: width),
    );
  }
}
