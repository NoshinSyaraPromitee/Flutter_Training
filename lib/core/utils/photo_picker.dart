import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../theme/app_colors.dart';

/// Shows a camera/gallery sheet (unless [source] is given) and returns the
/// picked image's file path, or null if the user cancelled or picking
/// failed.
Future<String?> pickPhoto(BuildContext context, {ImageSource? source}) async {
  source ??= await showModalBottomSheet<ImageSource>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera_outlined, color: AppColors.green),
            title: const Text('Take Photo'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library_outlined, color: AppColors.green),
            title: const Text('Choose from Gallery'),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ],
      ),
    ),
  );
  if (source == null) return null;
  try {
    final file = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1600,
    );
    return file?.path;
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not open the camera/gallery. Check app permissions.',
          ),
        ),
      );
    }
    return null;
  }
}
