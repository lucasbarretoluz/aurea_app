import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/clinic/clinic_model.dart';
import '../../../data/models/patient/patient_model.dart';
import '../../../data/models/exceptions/exceptions.dart';
import '../../../data/repository/clinic_repository.dart';

part 'clinic_state.dart';
part 'clinic_cubit.freezed.dart';

class ClinicCubit extends Cubit<ClinicState> {
  final ClinicRepository _repository = ClinicRepository();

  ClinicCubit() : super(const ClinicState.initial());

  Future<void> loadClinics() async {
    emit(const ClinicState.loading());
    try {
      final clinics = await _repository.getClinics();
      emit(ClinicState.loaded(clinics: clinics));
    } on RepositoryException catch (e) {
      emit(ClinicState.error(message: e.message));
    } catch (e) {
      emit(ClinicState.error(message: 'Erro ao carregar clínicas'));
    }
  }

  Future<void> createClinic(String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      emit(const ClinicState.error(message: 'Informe o nome da clínica'));
      return;
    }

    emit(const ClinicState.loading());
    try {
      await _repository.createClinic(name: trimmed);
      await loadClinics();
    } on RepositoryException catch (e) {
      emit(ClinicState.error(message: e.message));
    } catch (e) {
      emit(const ClinicState.error(message: 'Erro ao criar clínica'));
    }
  }

  Future<void> loadClinicById(int clinicId) async {
    emit(const ClinicState.loading());
    try {
      final clinic = await _repository.getClinicById(clinicId);
      emit(ClinicState.clinicLoaded(clinic: clinic));
    } on RepositoryException catch (e) {
      emit(ClinicState.error(message: e.message));
    } catch (e) {
      emit(ClinicState.error(message: 'Erro ao carregar clínica'));
    }
  }

  void addPatientToClinic({
    required int clinicId,
    required PatientModel patient,
  }) {
    final currentState = state;
    if (currentState is! _Loaded) {
      throw RepositoryException('Erro ao adicionar paciente à clínica');
    }

    final updatedClinics =
        currentState.clinics.map((clinic) {
          if (clinic.clinicId == clinicId) {
            return clinic.copyWith(patients: [patient, ...clinic.patients]);
          }
          return clinic;
        }).toList();

    emit(ClinicState.loaded(clinics: updatedClinics));
  }

  void removePatientFromClinic({
    required int clinicId,
    required int patientId,
  }) {
    final currentState = state;
    if (currentState is! _Loaded) return;

    final updatedClinics =
        currentState.clinics.map((clinic) {
          if (clinic.clinicId == clinicId) {
            final updatedPatients =
                clinic.patients
                    .where((patient) => patient.patientId != patientId)
                    .toList();
            return clinic.copyWith(patients: updatedPatients);
          }
          return clinic;
        }).toList();

    emit(ClinicState.loaded(clinics: updatedClinics));
  }
}

extension ClinicStateX on ClinicState {
  bool get isInitialOrLoading => this is _Initial || this is _Loading;

  bool get shouldReload =>
      this is _Initial || this is _Error;

  String? get errorMessage {
    final state = this;
    if (state is _Error) return state.message;
    return null;
  }

  List<ClinicModel>? get clinicsOrNull {
    final state = this;
    if (state is _Loaded) return state.clinics;
    if (state is _ClinicLoaded) return [state.clinic];
    return null;
  }
}
