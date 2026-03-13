import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/exceptions/exceptions.dart';
import '../../../data/repository/patient_photo_repository.dart';

part 'patient_photo_state.dart';
part 'patient_photo_cubit.freezed.dart';

class PatientPhotoCubit extends Cubit<PatientPhotoState> {
  final PatientPhotoRepository _repository = PatientPhotoRepository();

  PatientPhotoCubit() : super(const PatientPhotoState.initial());

  Future<void> loadPhotos(int patientId) async {
    emit(const PatientPhotoState.loading());
    try {
      final photoList = await _repository.getPatientPhotos(patientId: patientId);
      emit(PatientPhotoState.loaded(urls: photoList.urls));
    } on RepositoryException catch (e) {
      emit(PatientPhotoState.error(message: e.message));
    } catch (e) {
      emit(PatientPhotoState.error(message: 'Erro ao carregar fotos'));
    }
  }

  Future<void> uploadPhoto({
    required int patientId,
    required File imageFile,
  }) async {
    emit(const PatientPhotoState.uploading());
    try {
      await _repository.uploadPatientPhoto(
        patientId: patientId,
        imageFile: imageFile,
      );
      await loadPhotos(patientId);
    } on RepositoryException catch (e) {
      emit(PatientPhotoState.error(message: e.message));
    } catch (e) {
      emit(PatientPhotoState.error(message: 'Erro ao enviar foto'));
    }
  }

  Future<void> uploadMultiplePhotos({
    required int clinicId,
    required String namePatient,
    required List<File> imageFiles,
    int? coverImageIndex,
  }) async {
    emit(const PatientPhotoState.uploading());
    try {
      final result = await _repository.uploadMultiplePatientPhotos(
        clinicId: clinicId,
        namePatient: namePatient,
        imageFiles: imageFiles,
        coverImageIndex: coverImageIndex,
      );
      
      if (result.containsKey('patientId') && result['patientId'] != null) {
        final patientId = result['patientId'] as int;
        final patientName = result['name'] as String? ?? namePatient;
        final photos = result['photos'] as List<dynamic>? ?? [];
        
        final photoUrls = photos
            .map((photo) => (photo as Map<String, dynamic>)['url'] as String)
            .whereType<String>()
            .toList();
        
        emit(PatientPhotoState.uploadSuccess(
          patientId: patientId,
          clinicId: clinicId,
          patientName: patientName,
          photoUrls: photoUrls,
        ));
      } else {
        emit(const PatientPhotoState.loaded(urls: []));
      }
    } on RepositoryException catch (e) {
      emit(PatientPhotoState.error(message: e.message));
    } catch (e) {
      emit(PatientPhotoState.error(message: 'Erro ao enviar fotos'));
    }
  }
}

