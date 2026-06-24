import 'package:aurea_app/src/smile_planning/models/smile_plan.dart';
import 'package:aurea_app/src/smile_planning/repository/smile_plan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient_smile_plans_state.dart';
part 'patient_smile_plans_cubit.freezed.dart';

class PatientSmilePlansCubit extends Cubit<PatientSmilePlansState> {
  PatientSmilePlansCubit({SmilePlanRepository? repository})
    : _repository = repository ?? SmilePlanLocalRepository(),
      super(const PatientSmilePlansState.initial());

  final SmilePlanRepository _repository;

  Future<void> load(int patientId) async {
    emit(const PatientSmilePlansState.loading());
    try {
      final plans = await _repository.listByPatient(patientId);
      emit(PatientSmilePlansState.loaded(plans: plans));
    } catch (_) {
      emit(
        const PatientSmilePlansState.error(
          message: 'Erro ao carregar planejamentos',
        ),
      );
    }
  }

  SmilePlan? planForPhoto(String photoUrl) {
    final current = state;
    if (current is! PatientSmilePlansLoaded) return null;

    for (final plan in current.plans) {
      if (plan.photoUrl == photoUrl) return plan;
    }
    return null;
  }

  bool hasPlanForPhoto(String photoUrl) => planForPhoto(photoUrl) != null;

  Future<void> deletePlanForPhoto(int patientId, String photoUrl) async {
    await _repository.deleteForPhoto(patientId, photoUrl);
    await load(patientId);
  }

  Future<void> deleteAllForPatient(int patientId) async {
    await _repository.deleteByPatient(patientId);
    emit(const PatientSmilePlansState.loaded(plans: []));
  }
}
