import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_scaffold.dart';

/// Registration screen. There's no auth backend yet, so any name/email/
/// password creates a local session — see [AuthController.signIn].
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    await ref
        .read(authControllerProvider.notifier)
        .signIn(email: _email.text, name: _name.text);
    if (mounted) context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create Account',
      children: [
        AppTextField(
          controller: _name,
          hint: 'Full Name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _email,
          hint: 'Email',
          icon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _password,
          hint: 'Password',
          icon: Icons.lock_outline,
          obscure: _hidePassword,
          suffix: IconButton(
            icon: Icon(
              _hidePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: () => setState(() => _hidePassword = !_hidePassword),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Create Account',
          expand: true,
          onPressed: _createAccount,
        ),
      ],
    );
  }
}
