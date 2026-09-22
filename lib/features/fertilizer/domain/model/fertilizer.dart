class Fertilizer {
  const Fertilizer({
    required this.id,
    required this.name,
    required this.purpose,
    required this.nutrient,
    required this.imageUrl,
    required this.ingredients,
    required this.preparation,
    required this.application,
    required this.benefits,
  });

  final String id, name, purpose, nutrient, imageUrl, application;
  final List<String> ingredients, preparation, benefits;

  bool matches(String query) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return true;
    return name.toLowerCase().contains(q) ||
        purpose.toLowerCase().contains(q) ||
        nutrient.toLowerCase().contains(q) ||
        ingredients.any((i) => i.toLowerCase().contains(q));
  }
}

class FertilizerCatalog {
  const FertilizerCatalog({required this.items, required this.safetyTips});
  final List<Fertilizer> items;
  final List<String> safetyTips;
}