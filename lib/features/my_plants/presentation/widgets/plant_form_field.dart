import 'package:flutter/material.dart';

/// Describes one label + text field row on the add-plant form.
class PlantFormField {
  const PlantFormField(
    this.label,
    this.controller,
    this.hint, {
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
}
