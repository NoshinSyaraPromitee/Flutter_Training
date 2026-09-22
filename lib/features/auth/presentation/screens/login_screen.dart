import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_providers.dart';
import '../widgets/auth_scaffold.dart';

/// Sign-in screen. There's no auth backend yet, so any email/password
/// signs in locally — see [AuthController.signIn].
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    await ref.read(authControllerProvider.notifier).signIn(email: _email.text);
    if (mounted) context.go('/home');
  }

  void _continueAsGuest() {
    ref.read(authControllerProvider.notifier).continueAsGuest();
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome Back!',
      subtitle: 'Missing your buddies?',
      children: [
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
        AppButton(label: 'Login', expand: true, onPressed: _login),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          label: 'Continue as Guest',
          variant: AppButtonVariant.outline,
          expand: true,
          onPressed: _continueAsGuest,
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?", style: AppTextStyles.bodyText),
            TextButton(
              onPressed: () => context.push('/register'),
              child: Text(
                'Register',
                style: AppTextStyles.bodyText.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.green,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
