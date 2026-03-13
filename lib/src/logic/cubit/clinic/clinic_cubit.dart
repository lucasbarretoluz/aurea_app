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
    final stateString = currentState.toString();
    if (stateString.contains('loaded') && stateString.contains('clinics')) {
      try {
        final loadedState = currentState as dynamic;
        final clinics = loadedState.clinics as List<ClinicModel>;
        
        final updatedClinics = clinics.map((clinic) {
          if (clinic.clinicId == clinicId) {
            final updatedPatients = [patient, ...clinic.patients];
            return clinic.copyWith(patients: updatedPatients);
          }
          return clinic;
        }).toList();
        
        emit(ClinicState.loaded(clinics: updatedClinics));
      } catch (e) {
        rethrow;
      }
    }
    throw RepositoryException('Erro ao adicionar paciente à clínica');
  }
}
