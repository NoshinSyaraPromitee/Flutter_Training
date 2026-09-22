import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:plantpal/core/theme/app_colors.dart';
import 'package:plantpal/core/theme/app_text_styles.dart';
import 'package:plantpal/core/widgets/app_button.dart';
import 'package:plantpal/core/widgets/app_screen.dart';
import 'package:plantpal/core/widgets/app_text_field.dart';
import 'package:plantpal/core/widgets/photo_picker_sheet.dart';
import 'package:plantpal/features/plants/domain/entities/plant.dart';
import 'package:plantpal/features/plants/presentation/controllers/plants_controller.dart';
import 'package:provider/provider.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});
  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _nickname = TextEditingController();
  final _species = TextEditingController();
  final _location = TextEditingController();
  final _sunlight = TextEditingController();
  final _days = TextEditingController(text: '7');
  String? _image;
  bool _wateredToday = true;
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_nickname, _species, _location, _sunlight, _days]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final plant = NewPlant(
      nickname: _nickname.text,
      species: _species.text,
      location: _location.text,
      sunlight: _sunlight.text,
      wateringFrequencyDays: int.tryParse(_days.text.trim()) ?? 7,
      lastWatered: _wateredToday ? DateTime.now() : null,
      imagePath: _image,
    );
    setState(() => _saving = true);
    final err = await context.read<PlantsController>().add(plant);
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err ?? '${plant.nickname.trim()} has been added 🌱')));
    if (err == null) context.pop();
  }

  Widget _label(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 6, top: 14),
        child: Text(t, style: AppTextStyles.inter(15, w: FontWeight.w700, c: AppColors.greenPrimary)),
      );

  @override
  Widget build(BuildContext context) => AppScreen(
        title: 'Add Plant',
        child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
          GestureDetector(
            onTap: () async {
              final p = await pickPhoto(context);
              if (p != null) setState(() => _image = p);
            },
            child: Container(
              height: 180,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
              clipBehavior: Clip.antiAlias,
              child: _image != null
                  ? Image.file(File(_image!), fit: BoxFit.cover, width: double.infinity)
                  : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.add_a_photo, size: 56, color: AppColors.greenPrimary),
                      const SizedBox(height: 10),
                      Text('Add Plant Photo', style: AppTextStyles.inter(16, w: FontWeight.w700, c: AppColors.greenPrimary)),
                    ]),
            ),
          ),
          _label('Nickname'),
          AppTextField(controller: _nickname, hint: 'Bella'),
          _label('Plant Species'),
          AppTextField(controller: _species, hint: 'Monstera Deliciosa'),
          _label('Location'),
          AppTextField(controller: _location, hint: 'Living Room'),
          _label('Sunlight'),
          AppTextField(controller: _sunlight, hint: 'Medium'),
          _label('Water every (days)'),
          AppTextField(controller: _days, hint: '3', keyboardType: TextInputType.number),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeThumbColor: AppColors.greenPrimary,
            title: Text('I watered it today', style: AppTextStyles.inter(14, w: FontWeight.w600)),
            value: _wateredToday,
            onChanged: (v) => setState(() => _wateredToday = v),
          ),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: AppButton(label: 'Auto Fill Using AI Scan', variant: AppButtonVariant.orange, trailingIcon: Icons.smart_toy, onPressed: () => context.go('/scan'))),
          const SizedBox(height: 12),
          SizedBox(width: double.infinity, child: AppButton(label: _saving ? 'Saving...' : 'Save Plant', trailingIcon: Icons.save, onPressed: _saving ? null : _save)),
        ]),
      );
}