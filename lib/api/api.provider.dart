import 'dart:convert';
import 'package:food_xyz_project/repositories.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.defaultContentType = 'application/x-www-form-urlencoded';
    httpClient.addRequestModifier<dynamic>((request) {
      const username = ApiConfig.username;
      const password = ApiConfig.password;

      final token =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      request.headers['Authorization'] = token;

      return request;
    });
  }



  Future<String> addAccount({
    required String namaLengkap,
    required String username,
    required String alamat,
    required String noTelepon,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final data = {
        'nama-lengkap': namaLengkap,
        'username': username,
        'alamat': alamat,
        'no-telepon': noTelepon,
        'password': password,
        'password-confirm': passwordConfirm
      };

      //ubah data dalam map agar diterima oleh x-www-form-encoded
      final encodedData = data.entries.map(
        (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      );
      final body = encodedData.join('&');

      final response = await request(
        ApiEndPoint.daftar,
        'POST',
        body: body,
      );

      if (response.hasError) {
        return Future.error(response.statusText ??
            'Terjadi kesalahan dalam proses pendaftaran');
      }

      return 'Akun Berhasil Dibuat';
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<String, dynamic>> login({
    required username,
    required password,
  }) async {
    try {
      final data = {
        'grant_type': 'password',
        'username': username,
        'password': password,
      };

      final encodedData = data.entries.map(
        (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      );
      final body = encodedData.join('&');

      final response = await request(
        ApiEndPoint.login,
        'POST',
        body: body,
      );

      if (response.hasError) {
        return Future.error(
            response.statusText ?? 'Terjadi Kesalahan saat login');
      } else {
        var result = {
          'accessToken': response.body['access_token'],
          'refreshToken': response.body['refresh_token'],
        };
        return Future.value(result);
      }
    } catch (e) {
      return Future.error('Error: $e');
    }
  }
}
