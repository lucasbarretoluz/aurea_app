import 'package:dio/dio.dart';
import '../models/clinic/clinic_model.dart';
import '../models/exceptions/exceptions.dart';
import '../provider/clinic_provider.dart';

class ClinicRepository {
  final ClinicProvider _provider = ClinicProvider();

  Future<List<ClinicModel>> getClinics() async {
    try {
      final response = await _provider.getClinics();
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data is List
            ? response.data
            : [response.data];
        
        return data
            .map((json) => ClinicModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      throw RepositoryException('Erro ao buscar clínicas');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao buscar clínicas',
      );
    } catch (e) {
      throw RepositoryException('Erro ao buscar clínicas: $e');
    }
  }

  Future<ClinicModel> getClinicById(int clinicId) async {
    try {
      final response = await _provider.getClinicById(clinicId);
      
      if (response.statusCode == 200 && response.data != null) {
        return ClinicModel.fromJson(response.data as Map<String, dynamic>);
      }
      
      throw RepositoryException('Erro ao buscar clínica');
    } on DioException catch (e) {
      throw RepositoryException(
        e.response?.data?['message'] ?? 'Erro ao buscar clínica',
      );
    } catch (e) {
      throw RepositoryException('Erro ao buscar clínica: $e');
    }
  }
}

