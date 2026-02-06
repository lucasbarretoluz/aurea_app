import 'dart:io';
import 'package:dio/dio.dart';
import '../api/api.dart';
import '../models/exceptions/exceptions.dart';

class PatientPhotoProvider {
  final Api _api = Api.instance;

  Future<Response<dynamic>> uploadPatientPhoto({
    required int patientId,
    required File imageFile,
  }) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        'patient_id': patientId,
      });

      var response = await _api.dio.post(
        '/patients/$patientId/photos',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> uploadMultiplePatientPhotos({
    required int clinicId,
    required String namePatient,
    required List<File> imageFiles,
  }) async {
    try {
      final formData = FormData();
      
      for (var i = 0; i < imageFiles.length; i++) {
        final file = imageFiles[i];
        final fileName = file.path.split('/').last;
        formData.files.add(
          MapEntry(
            'photos',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
            ),
          ),
        );
      }

      formData.fields.add(MapEntry('namePatient', namePatient));
      formData.fields.add(MapEntry('clinicId', clinicId.toString()));
      
      var response = await _api.dio.post(
        '/patients/photos/multiple',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } on DioException catch (_) {
      rethrow;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> getPatientPhotos({
    required int patientId,
  }) async {
    try {
      var response = await _api.dio.get('/patients/$patientId/photos');
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}

