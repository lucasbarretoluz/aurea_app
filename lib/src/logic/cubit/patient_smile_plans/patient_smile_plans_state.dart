part of 'patient_smile_plans_cubit.dart';

@freezed
class PatientSmilePlansState with _$PatientSmilePlansState {
  const factory PatientSmilePlansState.initial() = PatientSmilePlansInitial;

  const factory PatientSmilePlansState.loading() = PatientSmilePlansLoading;

  const factory PatientSmilePlansState.loaded({
    required List<SmilePlan> plans,
  }) = PatientSmilePlansLoaded;

  const factory PatientSmilePlansState.error({required String message}) =
      PatientSmilePlansError;
}
