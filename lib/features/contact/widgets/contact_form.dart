import 'package:flutter/material.dart';

import '../../../core/extensions/context_ext.dart';
import '../../../core/extensions/widget_ext.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/inputs/app_text_area.dart';
import '../../../shared/inputs/app_text_field.dart';
import '../contact_controller.dart';

class ContactForm extends StatelessWidget {
  final ContactController controller;

  const ContactForm({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final nameField = AppTextField(
      controller: controller.nameController,
      label: 'Name',
      hint: 'Your name',
      enabled: !controller.isSending,
      validator: ContactController.validateName,
      textInputAction: TextInputAction.next,
    );

    final emailField = AppTextField(
      controller: controller.emailController,
      label: 'Email',
      hint: 'you@example.com',
      keyboardType: TextInputType.emailAddress,
      enabled: !controller.isSending,
      validator: ContactController.validateEmail,
      textInputAction: TextInputAction.next,
    );

    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (context.isMobile) ...[
            nameField,
            const Gap(AppSpacing.md),
            emailField,
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: nameField),
                const Gap.h(AppSpacing.lg),
                Expanded(child: emailField),
              ],
            ),
          const Gap(AppSpacing.md),
          AppTextArea(
            controller: controller.messageController,
            label: 'Message',
            hint: 'What are you building?',
            enabled: !controller.isSending,
            validator: ContactController.validateMessage,
          ),
          const Gap(AppSpacing.lg),
          PrimaryButton(
            label: 'Send message',
            icon: Icons.send_rounded,
            busy: controller.isSending,
            onTap: controller.submit,
          ),
        ],
      ),
    );
  }
}
