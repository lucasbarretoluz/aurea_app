import 'dart:io';
import 'package:dio/dio.dart';
import '../models/exceptions/exceptions.dart';
import '../models/patient/patient_photo_model.dart';
import '../provider/patient_photo_provider.dart';

class PatientPhotoRepository {
  final PatientPhotoProvider _provider = PatientPhotoProvider();

  Future<Map<String, dynamic>> uploadPatientPhoto({
    required int patientId,
    required File imageFile,
  }) async {
    try {
      final response = await _provider.uploadPatientPhoto(
        patientId: patientId,
        imageFile: imageFile,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : {'success': true, 'data': response.data};
      }

      throw RepositoryException('Erro ao fazer upload da foto');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao fazer upload da foto',
      );
    } catch (e) {
      throw RepositoryException('Erro ao fazer upload da foto: $e');
    }
  }

  Future<Map<String, dynamic>> uploadMultiplePatientPhotos({
    required int clinicId,
    required String namePatient,
    required List<File> imageFiles,
    int? coverImageIndex,
  }) async {
   try {
      final response = await _provider.uploadMultiplePatientPhotos(
        clinicId: clinicId,
        namePatient: namePatient,
        imageFiles: imageFiles,
        coverImageIndex: coverImageIndex,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : {'success': true, 'data': response.data};
      }

      throw RepositoryException('Erro ao fazer upload das fotos');
    } on DioException catch (e) {
      
      String errorMessage = 'Erro ao fazer upload das fotos';
      
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
          errorMessage = data['message'] ?? 
                        data['error'] ?? 
                        data['msg'] ?? 
                        errorMessage;
        } else if (data is String) {
          errorMessage = data;
        }
      } else if (e.response?.statusMessage != null) {
        errorMessage = e.response!.statusMessage!;
      }
      
      throw RepositoryException(errorMessage);
    } catch (e) {
      throw RepositoryException('Erro ao fazer upload das fotos: $e');
    }
  }

  Future<PatientPhotoList> getPatientPhotos({
    required int patientId,
  }) async {
    try {
      final response = await _provider.getPatientPhotos(patientId: patientId);

      if (response.statusCode == 200 && response.data != null) {
        return PatientPhotoList.fromJson(response.data);
      }

      throw RepositoryException('Erro ao buscar fotos do paciente');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao buscar fotos do paciente',
      );
    } catch (e) {
      throw RepositoryException('Erro ao buscar fotos do paciente: $e');
    }
  }

  Future<void> deletePatientPhoto({
    required int patientId,
    required String path,
    required String url,
  }) async {
    try {
      final response = await _provider.deletePatientPhoto(
        patientId: patientId,
        path: path,
        url: url,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }

      throw RepositoryException('Erro ao excluir foto');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao excluir foto',
      );
    } catch (e) {
      throw RepositoryException('Erro ao excluir foto: $e');
    }
  }
}

