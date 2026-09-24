import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/locale_provider.dart';
import '../../../../core/theme/app_colors.dart';

Future<void> pickLanguage(BuildContext context, WidgetRef ref) =>
    showDialog<void>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Choose Language'),
        children: [
          for (final locale in supportedLocales)
            SimpleDialogOption(
              onPressed: () {
                ref.read(appLocaleProvider.notifier).set(locale);
                Navigator.pop(ctx);
              },
              child: Row(
                children: [
                  Expanded(child: Text(localeDisplayName(locale))),
                  if (ref.read(appLocaleProvider) == locale)
                     Icon(
                      Icons.check_circle,
                      size: 20,
                      color: AppColors.green,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
