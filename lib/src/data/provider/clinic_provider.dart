import 'package:dio/dio.dart';
import '../api/api.dart';
import '../models/exceptions/exceptions.dart';

class ClinicProvider {
  final Api _api = Api.instance;
  final String _path = '/clinics';

  Future<Response<dynamic>> getClinics() async {
    try {
      var response = await _api.dio.get(_path);
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> getClinicById(int clinicId) async {
    try {
      var response = await _api.dio.get('$_path/$clinicId');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}

