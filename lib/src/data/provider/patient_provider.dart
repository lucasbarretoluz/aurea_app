import 'package:dio/dio.dart';
import '../api/api.dart';
import '../models/exceptions/exceptions.dart';

class PatientProvider {
  final Api _api = Api.instance;
  final String _path = '/patients';

  Future<Response<dynamic>> getPatients({
    int page = 1,
    int limit = 10,
    int? clinicId,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (clinicId != null) 'clinicId': clinicId,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      };

      var response = await _api.dio.get(
        _path,
        queryParameters: queryParams,
      );
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}

