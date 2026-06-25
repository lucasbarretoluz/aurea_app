import 'dart:io';

import 'package:dio/dio.dart';

import '../api/api.dart';
import '../models/exceptions/exceptions.dart';

class ProfilePhotoProvider {
  final Api _api = Api.instance;
  final String _path = '/identity/user/';

  Future<Response<dynamic>> uploadProfilePhoto({required File imageFile}) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _api.dio.post(
        '${_path}profilePhoto',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }

  Future<Response<dynamic>> getProfile() async {
    try {
      final response = await _api.dio.get('${_path}profile');
      return response;
    } on DioException {
      rethrow;
    } catch (e) {
      throw ProviderException(e.toString());
    }
  }
}
