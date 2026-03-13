import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/patient/patient_model.dart';

part 'patient_state.freezed.dart';

@freezed
abstract class PatientState with _$PatientState {
  const factory PatientState.initial() = Initial;
  const factory PatientState.loading() = Loading;
  const factory PatientState.loaded({
    required List<PatientModel> patients,
    required int total,
    required int page,
    required int limit,
    required bool hasMore,
  }) = Loaded;
  const factory PatientState.error(String message) = Error;
}

