import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class PhotoPicker {
  final ImagePicker imagePicker;
  const PhotoPicker({required this.imagePicker});

  Future<Uint8List> takePhoto() async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.camera);

      if (image == null) {
        throw Exception("No image selected");
      }

      final bytes = await image.readAsBytes();

      return bytes;
    } on Exception {
      throw Exception("Failed to take photo");
    }
  }
}
