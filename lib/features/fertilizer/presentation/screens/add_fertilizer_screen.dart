import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:plantpal/core/widgets/app_button.dart";
import "package:plantpal/core/widgets/app_screen.dart";
import "package:plantpal/features/fertilizer/domain/model/fertilizer.dart";
import "package:plantpal/features/fertilizer/presentation/providers/fertilizer_providers.dart";
import "package:plantpal/features/fertilizer/presentation/widgets/fertilizer_form_fields.dart";

class AddFertilizerScreen extends ConsumerStatefulWidget {
  const AddFertilizerScreen({super.key});
  @override
  ConsumerState<AddFertilizerScreen> createState() => _AddFertilizerScreenState();
}

class _AddFertilizerScreenState extends ConsumerState<AddFertilizerScreen> {
  final _name = TextEditingController();
  final _purpose = TextEditingController();
  final _nutrient = TextEditingController();
  final _imageUrl = TextEditingController();
  final _ingredients = TextEditingController();
  final _preparation = TextEditingController();
  final _application = TextEditingController();
  final _benefits = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_name, _purpose, _nutrient, _imageUrl, _ingredients, _preparation, _application, _benefits]) {
      c.dispose();
    }
    super.dispose();
  }

  List<String> _lines(String raw) =>
      raw.split("\n").map((l) => l.trim()).where((l) => l.isNotEmpty).toList();

  Future<void> _save() async {
    if (_name.text.trim().isEmpty || _ingredients.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Recipe name and ingredients are required.")),
      );
      return;
    }
    setState(() => _saving = true);
    final recipe = Fertilizer(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _name.text.trim(),
      purpose: _purpose.text.trim().isEmpty ? "Custom Recipe" : _purpose.text.trim(),
      nutrient: _nutrient.text.trim().isEmpty ? "Not specified" : _nutrient.text.trim(),
      imageUrl: _imageUrl.text.trim().isEmpty
          ? "https://www.littlepassports.com/wp-content/uploads/2021/04/7a3de644-banana-peel-fertilizer.jpg"
          : _imageUrl.text.trim(),
      ingredients: _lines(_ingredients.text),
      preparation: _lines(_preparation.text),
      application: _application.text.trim(),
      benefits: _lines(_benefits.text),
    );
    await ref.read(fertilizerRecipesProvider.notifier).addRecipe(recipe);
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${recipe.name} added \u{1F331}")));
    context.pop();
  }

  @override
  Widget build(BuildContext context) => AppScreen(
        title: "Add Fertilizer Recipe",
        child: ListView(padding: const EdgeInsets.only(bottom: 32), children: [
          FertilizerFormSection(label: "Recipe Name", controller: _name, hint: "Coffee Ground Fertilizer"),
          FertilizerFormSection(label: "Purpose", controller: _purpose, hint: "Leafy Growth"),
          FertilizerFormSection(label: "Main Nutrient", controller: _nutrient, hint: "Nitrogen"),
          FertilizerFormSection(label: "Image URL (optional)", controller: _imageUrl, hint: "https://..."),
          FertilizerFormSection(label: "Ingredients (one per line)", controller: _ingredients, hint: "Used coffee grounds\nWater", maxLines: 3),
          FertilizerFormSection(label: "Preparation Steps (one per line)", controller: _preparation, hint: "Dry the grounds\nMix into soil", maxLines: 3),
          FertilizerFormSection(label: "Application", controller: _application, hint: "Apply once every 2 weeks."),
          FertilizerFormSection(label: "Benefits (one per line)", controller: _benefits, hint: "Adds nitrogen\nImproves drainage", maxLines: 3),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              label: _saving ? "Saving..." : "Save Recipe",
              trailingIcon: Icons.eco,
              onPressed: _saving ? null : _save,
            ),
          ),
        ]),
      );
}
