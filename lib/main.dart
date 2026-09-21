import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/di/service_locator.dart';

void main() {
  setupLocator();
  runApp(const ProviderScope(child: MyPlantPalApp()));
}
