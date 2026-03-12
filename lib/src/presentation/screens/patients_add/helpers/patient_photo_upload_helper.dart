import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class PatientPhotoUploadHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImage(BuildContext context) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile == null) {
        return null;
      }

      return File(pickedFile.path);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }

  static Future<File?> cropImage(BuildContext context, File imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cortar imagem',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Cortar imagem',
            aspectRatioLockEnabled: true,
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }

      return null;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao cortar imagem: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }

  static Future<File?> pickAndCropImage(BuildContext context) async {
    final pickedFile = await pickImage(context);
    if (pickedFile == null) {
      return null;
    }

    return await cropImage(context, pickedFile);
  }
}

class UploadResult {
  final bool success;
  final bool validationFailed;
  final bool notImplemented;
  final bool empty;
  final bool invalidPatient;

  UploadResult({
    this.success = false,
    this.validationFailed = false,
    this.notImplemented = false,
    this.empty = false,
    this.invalidPatient = false,
  });

  factory UploadResult.success() => UploadResult(success: true);
  factory UploadResult.validationFailed() => UploadResult(validationFailed: true);
  factory UploadResult.notImplemented() => UploadResult(notImplemented: true);
  factory UploadResult.empty() => UploadResult(empty: true);
  factory UploadResult.invalidPatient() => UploadResult(invalidPatient: true);

  bool shouldClearPendingImages() {
    return success;
  }
}

