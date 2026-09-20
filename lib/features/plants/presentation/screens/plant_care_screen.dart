import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../domain/care_roadmap.dart';

/// Plant registration form ("Maintainance") that, on submit, shows the
/// generated care roadmap in place — mirroring the Figma flow from the
/// "maintenance" frame to the "Maintenance_2" frame.
class PlantCareScreen extends StatefulWidget {
  const PlantCareScreen({super.key});

  @override
  State<PlantCareScreen> createState() => _PlantCareScreenState();
}

class _PlantCareScreenState extends State<PlantCareScreen> {
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _ageController = TextEditingController();

  String? _plantName;
  CareRoadmap? _roadmap;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _createRoadmap() {
    if (_nameController.text.trim().isEmpty) return;
    setState(() {
      _plantName = _nameController.text.trim();
      _roadmap = buildCareRoadmap(
        plantType: _typeController.text,
        ageStage: _ageController.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final roadmap = _roadmap;
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Maintainance',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heroTitle,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/images/maintenance_cactus.png',
                    width: roadmap == null ? 170 : 120,
                  ),
                ),
                const SizedBox(height: 20),
                if (roadmap == null)
                  _PlantCareForm(
                    nameController: _nameController,
                    typeController: _typeController,
                    ageController: _ageController,
                    onSubmit: _createRoadmap,
                  )
                else
                  _CareRoadmapView(plantName: _plantName!, roadmap: roadmap),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    label: 'Back',
                    onPressed: () => context.go('/home'),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantCareForm extends StatelessWidget {
  const _PlantCareForm({
    required this.nameController,
    required this.typeController,
    required this.ageController,
    required this.onSubmit,
  });

  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController ageController;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.formCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _FieldLabel('Name of the Plant'),
          _FormTextField(controller: nameController, hint: 'Value'),
          const SizedBox(height: 16),
          _FieldLabel('Types of Plant'),
          _FormTextField(
            controller: typeController,
            hint: 'Water based, Maniplant etc',
          ),
          const SizedBox(height: 16),
          _FieldLabel("How are the plant's age ?"),
          _FormTextField(
            controller: ageController,
            hint: 'Seed, Seedlings...',
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'Create My Roadmap',
            variant: AppButtonVariant.orange,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}

class _FormTextField extends StatelessWidget {
  const _FormTextField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _CareRoadmapView extends StatelessWidget {
  const _CareRoadmapView({required this.plantName, required this.roadmap});

  final String plantName;
  final CareRoadmap roadmap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF6E5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "Your plant '$plantName' needs around ${roadmap.waterAmountMl} ml "
            'water daily. Here is the time table you can water your plants',
            style: AppTextStyles.bodyText.copyWith(fontSize: 15),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final time in roadmap.wateringTimes) _TimeChip(label: time),
          ],
        ),
        const SizedBox(height: 16),
        AppButton(label: 'Set Alarm', onPressed: () {}),
        const SizedBox(height: 20),
        _InfoBox(text: 'Tips: ${roadmap.tips}'),
        const SizedBox(height: 12),
        _InfoBox(text: roadmap.fertilizerRecommendation),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  const _TimeChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.buttonOrange,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.greenCardFill.withValues(alpha: 0.5),
        border: Border.all(color: AppColors.cureBoxGreen),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: AppTextStyles.bodyText),
    );
  }
}
