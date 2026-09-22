import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Name/phone/address fields for the checkout screen.
class ShippingForm extends StatelessWidget {
  const ShippingForm({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
  });

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          controller: name,
          hint: 'Full Name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: phone,
          hint: 'Phone Number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: address,
          hint: 'Shipping Address',
          icon: Icons.location_on_outlined,
          maxLines: 3,
        ),
      ],
    );
  }
}
