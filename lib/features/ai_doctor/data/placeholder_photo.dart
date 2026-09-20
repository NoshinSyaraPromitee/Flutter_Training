import 'dart:convert';
import 'dart:typed_data';

/// A 1x1 transparent PNG, used as a stand-in photo until a real
/// camera/gallery picker is wired up. Lets the "Upload"/"Open Camera"
/// buttons exercise the real /api/v1/diagnoses endpoint today.
Uint8List placeholderPlantPhotoBytes() {
  const base64Png =
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk+A8AAQUBAScY'
      '42YAAAAASUVORK5CYII=';
  return base64Decode(base64Png);
}
