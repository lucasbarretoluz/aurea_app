import 'package:dio/dio.dart';
import '../api/api.dart';
import '../models/exceptions/exceptions.dart';


class AuthProvider {
  final Api _api = Api.instance;
  final String _path = '/identity/user/';

  Future<Response<dynamic>> healthCheck() async {
    try {
      var response = await _api.dio.get('/healthz');
      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> signIn({
    required String identifier,
    required password,
  }) async {
    try {
      var response = await _api.dio.post(
        '$_path/login',
        data: {
          'identifier': identifier,
          'password': password,
        },
      );

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> singUp({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      var response = await _api.dio.post(
        '$_path/createUser',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> firebaseAuthValid({required String token}) async {
    try {
      var response = await _api.dio.get(
        '$_path/firebaseAuth',
        queryParameters: {
          'idToken': token,
        },
      );

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> deleteAccount() async {
    try {
      var response = await _api.dio.delete('$_path/deleteUser');

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> clearAccount() async {
    try {
      var response = await _api.dio.post('$_path/clearAccount');

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> updateIsPremium({required bool isPremium}) async {
    try {
      var response = await _api.dio.put(
        '$_path/updateIsPremium',
        data: {
          'isPremium': isPremium,
        },
      );

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> refreshToken({required String refreshToken}) async {
    try {
      var response = await _api.dio.post(
        '$_path/refreshToken',
        data: {
          'refreshToken': refreshToken,
        },
      );

      return response;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}
