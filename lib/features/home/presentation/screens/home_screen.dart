import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../widgets/menu_action_card.dart';

/// Main menu / dashboard screen shown after the splash screen.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: AppButton(
                    label: "Upload your Plant's Photo",
                    trailingIcon: Icons.add_circle_outline,
                    onPressed: () => context.go('/ai-doctor'),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuActionCard(
                      imageAsset: 'assets/images/maintenance_cactus.png',
                      label: 'Maintainance',
                      onTap: () {},
                    ),
                    MenuActionCard(
                      imageAsset: 'assets/images/disease_plant.png',
                      label: 'Disease Detection',
                      onTap: () => context.go('/ai-doctor'),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuActionCard(
                      imageAsset: 'assets/images/fertilizer_bag.png',
                      label: 'Fertilizer Making\nRecipe',
                      onTap: () => context.go('/fertilizer'),
                    ),
                    MenuActionCard(
                      imageAsset: 'assets/images/shop_image.png',
                      label: 'Shop',
                      variant: AppButtonVariant.orange,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () {},
                          child: Image.asset(
                            'assets/images/chat_bot_icon.png',
                            width: 64,
                            height: 64,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Chat with expert',
                          style: AppTextStyles.chatLabel,
                        ),
                      ],
                    ),
                    const AppButton(label: 'MainMenu'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
