part of 'patient_photo_cubit.dart';

@freezed
class PatientPhotoState with _$PatientPhotoState {
  const factory PatientPhotoState.initial() = Initial;
  const factory PatientPhotoState.loading() = Loading;
  const factory PatientPhotoState.uploading() = Uploading;
  const factory PatientPhotoState.loaded({
    required List<String> urls,
  }) = Loaded;
  const factory PatientPhotoState.error({
    required String message,
  }) = Error;
}

