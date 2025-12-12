import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/patient/patient_model.dart';
import '../../../data/repository/patient_repository.dart';
import 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepository _repository = PatientRepository();

  PatientCubit() : super(const PatientState.initial());

  Future<void> loadPatients({
    int page = 1,
    int limit = 10,
    bool loadMore = false,
  }) async {
    try {
      if (!loadMore) {
        emit(const PatientState.loading());
      }

      final response = await _repository.getPatients(page: page, limit: limit);

      if (loadMore && state.toString().startsWith('PatientState.loaded')) {
        try {
          final currentState = state as dynamic;
          final currentPatients = (currentState.patients as List).cast<PatientModel>();
          final updatedPatients = <PatientModel>[
            ...currentPatients,
            ...response.patients,
          ];
          emit(PatientState.loaded(
            patients: updatedPatients,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ));
        } catch (_) {
          emit(PatientState.loaded(
            patients: response.patients,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ));
        }
      } else {
        emit(PatientState.loaded(
          patients: response.patients,
          total: response.total,
          page: response.page,
          limit: response.limit,
          hasMore: response.page < response.totalPages,
        ));
      }
    } catch (e) {
      emit(PatientState.error(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (state.toString().startsWith('PatientState.loaded')) {
      try {
        final currentState = state as dynamic;
        final hasMore = currentState.hasMore as bool;
        final page = currentState.page as int;
        final limit = currentState.limit as int;
        
        if (hasMore) {
          await loadPatients(
            page: page + 1,
            limit: limit,
            loadMore: true,
          );
        }
      } catch (_) {
        // Ignora erro ao carregar mais
      }
    }
  }
}
