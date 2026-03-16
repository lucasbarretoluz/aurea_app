import 'package:dio/dio.dart';
import '../models/patient/patient_paginated_response.dart';
import '../models/exceptions/exceptions.dart';
import '../provider/patient_provider.dart';

class PatientRepository {
  final PatientProvider _provider = PatientProvider();

  Future<PatientPaginatedResponse> getPatients({
    int page = 1,
    int limit = 10,
    int? clinicId,
    String? search,
  }) async {
    try {
      final response = await _provider.getPatients(
        page: page,
        limit: limit,
        clinicId: clinicId,
        search: search,
      );
      
      if (response.statusCode == 200 && response.data != null) {
        return PatientPaginatedResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      
      throw RepositoryException('Erro ao buscar pacientes');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao buscar pacientes',
      );
    } catch (e) {
      throw RepositoryException('Erro ao buscar pacientes: $e');
    }
  }
}

