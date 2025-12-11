part of 'clinic_cubit.dart';

@freezed
class ClinicState with _$ClinicState {
  const factory ClinicState.initial() = _Initial;
  const factory ClinicState.loading() = _Loading;
  const factory ClinicState.loaded({
    required List<ClinicModel> clinics,
  }) = _Loaded;
  const factory ClinicState.clinicLoaded({
    required ClinicModel clinic,
  }) = _ClinicLoaded;
  const factory ClinicState.error({
    required String message,
  }) = _Error;
}

