part of 'patient_photo_cubit.dart';

@freezed
class PatientPhotoState with _$PatientPhotoState {
  const factory PatientPhotoState.initial() = Initial;
  const factory PatientPhotoState.loading() = Loading;
  const factory PatientPhotoState.uploading() = Uploading;
  const factory PatientPhotoState.loaded({
    required List<PatientPhotoItem> photos,
  }) = Loaded;
  const factory PatientPhotoState.deleting() = Deleting;
  const factory PatientPhotoState.uploadSuccess({
    required int patientId,
    required int clinicId,
    required String patientName,
    required List<String> photoUrls,
  }) = UploadSuccess;
  const factory PatientPhotoState.error({
    required String message,
  }) = Error;
}

