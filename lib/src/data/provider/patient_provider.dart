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
  }) async {
    try {
      var response = await _api.dio.get(
        _path,
        queryParameters: {
          'page': page,
          'limit': limit,
          'clinicId': clinicId,
        },
      );
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}

