import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProfileImageService {
  LocalProfileImageService._();

  static final LocalProfileImageService instance =
  LocalProfileImageService._();

  static const String _profileImageKey = 'profile_image_path';

  Future<String> saveProfileImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final prefs = await SharedPreferences.getInstance();

    // Get the old image path
    final oldImagePath = prefs.getString(_profileImageKey);

    // Create a new unique file name
    final fileName =
        'profile_image_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final newImage = File(
      '${directory.path}/$fileName',
    );

    // Save the new image
    await image.copy(newImage.path);

    // Delete the old image
    if (oldImagePath != null && oldImagePath != newImage.path) {
      final oldImage = File(oldImagePath);

      if (await oldImage.exists()) {
        await oldImage.delete();
      }
    }

    // Save the new image path
    await prefs.setString(
      _profileImageKey,
      newImage.path,
    );

    return newImage.path;
  }

  Future<File?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath = prefs.getString(_profileImageKey);

    if (imagePath == null) {
      return null;
    }

    final image = File(imagePath);

    if (await image.exists()) {
      return image;
    }

    // Image no longer exists
    await prefs.remove(_profileImageKey);

    return null;
  }

  Future<void> deleteProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    final imagePath = prefs.getString(_profileImageKey);

    if (imagePath != null) {
      final image = File(imagePath);

      if (await image.exists()) {
        await image.delete();
      }

      await prefs.remove(_profileImageKey);
    }
  }
}