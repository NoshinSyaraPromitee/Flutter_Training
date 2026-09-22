import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/photo_picker.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/curved_header.dart';
import '../../domain/plant.dart';
import '../providers/my_plants_providers.dart';
import '../widgets/field_label.dart';
import '../widgets/plant_form_field.dart';
import '../widgets/plant_photo_picker.dart';

class AddPlantScreen extends ConsumerStatefulWidget {
  const AddPlantScreen({super.key});

  @override
  ConsumerState<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends ConsumerState<AddPlantScreen> {
  final _nickname = TextEditingController();
  final _species = TextEditingController();
  final _location = TextEditingController();
  final _sunlight = TextEditingController();
  final _days = TextEditingController(text: '7');
  String? _imagePath;
  bool _wateredToday = true;
  String? _error;

  @override
  void dispose() {
    for (final c in [_nickname, _species, _location, _sunlight, _days]) {
      c.dispose();
    }
    super.dispose();
  }

  List<PlantFormField> get _fields => [
    PlantFormField('Nickname', _nickname, 'Bella'),
    PlantFormField('Plant Species', _species, 'Monstera Deliciosa'),
    PlantFormField('Location', _location, 'Living Room'),
    PlantFormField('Sunlight', _sunlight, 'Medium'),
    PlantFormField(
      'Water every (days)',
      _days,
      '3',
      keyboardType: TextInputType.number,
    ),
  ];

  Future<void> _pickPhoto() async {
    final path = await pickPhoto(context);
    if (path != null) setState(() => _imagePath = path);
  }

  void _save() {
    final input = NewPlant(
      nickname: _nickname.text,
      species: _species.text,
      location: _location.text,
      sunlight: _sunlight.text,
      wateringFrequencyDays: int.tryParse(_days.text.trim()) ?? 7,
      lastWatered: _wateredToday ? DateTime.now() : null,
      imagePath: _imagePath,
    );
    final error = ref.read(myPlantsProvider.notifier).add(input);
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurvedHeader(
            title: 'Add Plant',
            color: AppColors.green,
            onBack: () => context.pop(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                PlantPhotoPicker(imagePath: _imagePath, onTap: _pickPhoto),
                const SizedBox(height: AppSpacing.lg),
                for (final field in _fields) ...[
                  FieldLabel(field.label),
                  AppTextField(
                    controller: field.controller,
                    hint: field.hint,
                    keyboardType: field.keyboardType,
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeThumbColor: AppColors.green,
                  title: Text(
                    "I watered it today",
                    style: AppTextStyles.bodyText,
                  ),
                  value: _wateredToday,
                  onChanged: (v) => setState(() => _wateredToday = v),
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _error!,
                    style: const TextStyle(color: AppColors.danger),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Auto Fill Using AI Scan',
                  variant: AppButtonVariant.outline,
                  trailingIcon: Icons.smart_toy_outlined,
                  expand: true,
                  onPressed: () => context.push('/scan'),
                ),
                const SizedBox(height: AppSpacing.md),
                AppButton(
                  label: 'Save Plant',
                  trailingIcon: Icons.save_outlined,
                  expand: true,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
