import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_widgets.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _emailLogin() async {
    final email = _email.text.trim();
    final password = _password.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter your email and password.')));
      return;
    }
    final auth = context.read<AuthController>();
    final ok = await auth.loginWithEmail(email: email, password: password);
    if (!mounted) return;
    if (ok) {
      context.go('/home');
    } else if (auth.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final busy = context.watch<AuthController>().busy;
    return AuthScaffold(
      title: l10n.loginWelcomeBack,
      subtitle: l10n.loginSubtitle,
      children: [
        AppTextField(controller: _email, hint: l10n.emailLabel, icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress),
        const SizedBox(height: 14),
        AppTextField(
          controller: _password,
          hint: l10n.passwordLabel,
          icon: Icons.lock_outline,
          obscure: _hide,
          suffix: IconButton(
            icon: Icon(_hide ? Icons.visibility_off_outlined : Icons.visibility_outlined),
            onPressed: () => setState(() => _hide = !_hide),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, child: AppButton(label: l10n.loginButton, onPressed: busy ? null : _emailLogin)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Row(children: [
            const Expanded(child: Divider()),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(l10n.orDivider)),
            const Expanded(child: Divider()),
          ]),
        ),
        const GoogleSignInButton(),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(l10n.noAccountPrompt, style: AppTextStyles.inter(14)),
          TextButton(
            onPressed: () => context.push('/register'),
            child: Text(l10n.registerLink, style: AppTextStyles.inter(14, w: FontWeight.w700, c: AppColors.greenPrimary)),
          ),
        ]),
      ],
    );
  }
}