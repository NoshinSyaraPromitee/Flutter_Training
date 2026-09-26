import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../app/riverpod_providers.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key, required this.title, this.subtitle, required this.children});
  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: GradientBackground(
          child: SafeArea(
            child: Stack(children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
                child: Column(children: [
                  Image.asset('assets/images/login.gif', width: 130, height: 130, fit: BoxFit.contain),
                  const SizedBox(height: 8),
                  Text(title, style: AppTextStyles.screenTitle),
                  if (subtitle != null) Text(subtitle!, style: AppTextStyles.inter(15, c: AppColors.textMuted)),
                  const SizedBox(height: 28),
                  ...children,
                ]),
              ),
              Positioned(
                top: 4,
                left: 8,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.greenPrimary),
                  onPressed: () => context.canPop() ? context.pop() : context.go('/landing'),
                ),
              ),
            ]),
          ),
        ),
      );
}

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final l10n = AppLocalizations.of(context);
    return Column(children: [
      SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            elevation: 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: auth.busy
              ? null
              : () async {
                  final ok = await auth.loginWithGoogle();
                  if (!context.mounted) return;
                  if (ok) {
                    context.go('/home');
                  } else if (auth.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(auth.error!)));
                  }
                },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('G', style: TextStyle(color: Color(0xFFDB4437), fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(width: 10),
            Text(
              auth.busy ? l10n.signingInLabel : l10n.continueWithGoogleButton,
              style: AppTextStyles.inter(16, w: FontWeight.w600),
            ),
          ]),
        ),
      ),
      if (kDebugMode)
        TextButton(
          onPressed: () {
            auth.continueAsGuest();
            context.go('/home');
          },
          child: Text(l10n.continueAsGuestButton),
        ),
    ]);
  }
}