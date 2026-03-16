import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/patient/patient_model.dart';
import '../../../data/repository/patient_repository.dart';
import 'patient_state.dart';

class PatientCubit extends Cubit<PatientState> {
  final PatientRepository _repository = PatientRepository();
  int? _currentClinicId;
  String? _currentSearch;

  PatientCubit() : super(const PatientState.initial());

  List<PatientModel> filteredPatients = [];
  List<PatientModel> patients = [];

  Future<void> loadPatients({
    int page = 1,
    int limit = 10,
    bool loadMore = false,
    int? clinicId,
  }) async {
    try {
      if (!loadMore) {
        emit(const PatientState.loading());
      }

      _currentClinicId = clinicId;

      final response = await _repository.getPatients(
        page: page,
        limit: limit,
        clinicId: clinicId,
      );

      if (loadMore && state is Loaded) {
        final currentState = state as Loaded;
        final updatedPatients = <PatientModel>[
          ...currentState.patients,
          ...response.patients,
        ];
        
        patients = updatedPatients;
        
        emit(
          PatientState.loaded(
            patients: updatedPatients,
            filteredPatients: currentState.filteredPatients,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ),
        );
      } else {
        patients = response.patients;
        
        emit(
          PatientState.loaded(
            patients: response.patients,
            filteredPatients: null,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ),
        );
      }
    } catch (e) {
      emit(PatientState.error(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      
      if (currentState.hasMore) {
        if (currentState.filteredPatients != null &&
            currentState.filteredPatients!.isNotEmpty) {
          await searchPatients(_currentSearch ?? '', currentState.page + 1);
        } else {
          await loadPatients(
            page: currentState.page + 1,
            limit: currentState.limit,
            loadMore: true,
            clinicId: _currentClinicId,
          );
        }
      }
    }
  }

  Future<void> searchPatients(String search, [int? page]) async {
    try {
      if (state is! Loaded) return;
      
      final currentState = state as Loaded;
      final isLoadMore = page != null;
      _currentSearch = search;
      
      final response = await _repository.getPatients(
        page: page ?? 1,
        limit: currentState.limit,
        clinicId: _currentClinicId,
        search: search,
      );

      if (isLoadMore && currentState.filteredPatients != null) {
        final updatedFilteredPatients = <PatientModel>[
          ...currentState.filteredPatients!,
          ...response.patients,
        ];
        filteredPatients = updatedFilteredPatients;
        
        emit(
          PatientState.loaded(
            patients: currentState.patients,
            filteredPatients: updatedFilteredPatients,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ),
        );
      } else {
        filteredPatients = response.patients;
        
        emit(
          PatientState.loaded(
            patients: currentState.patients,
            filteredPatients: response.patients,
            total: response.total,
            page: response.page,
            limit: response.limit,
            hasMore: response.page < response.totalPages,
          ),
        );
      }
    } catch (e) {
      emit(PatientState.error(e.toString()));
    }
  }

  Future<void> clearFilteredPatients() async {
    if (state is Loaded) {
      final currentState = state as Loaded;
      filteredPatients.clear();
      _currentSearch = null;
      
      emit(
        PatientState.loaded(
          patients: currentState.patients,
          filteredPatients: null,
          total: currentState.total,
          page: currentState.page,
          limit: currentState.limit,
          hasMore: currentState.hasMore,
        ),
      );
    }
  }
}
