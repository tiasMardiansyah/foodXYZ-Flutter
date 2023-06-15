import 'dart:convert';
import 'package:food_xyz_project/repositories.dart';

class ApiProvider extends GetConnect {
  final tokenStorage = const FlutterSecureStorage();
  static const authUsername = ApiConfig.username;
  static const authPassword = ApiConfig.password;

  @override
  void onInit() {
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.defaultContentType = 'application/x-www-form-urlencoded';
  }

  Future<Map<String, dynamic>> addAccount({
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
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
          'messages': response.body['messages'],
        };

        throw error;
      }

      var result = {
        'statusCode': response.statusCode,
        'statusText': response.statusText,
      };

      return Future.value(result);
    } catch (e) {
      return Future.error(e);
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
        headers: {
          'Authorization': 'Basic ${base64.encode(
            utf8.encode('$authUsername:$authPassword'),
          )}',
        },
      );

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
        };
        throw error;
      } else {
        var result = {
          'statusCode': response.statusCode,
          'statusText': response.statusText,
          'accessToken': response.body['access_token'],
          'refreshToken': response.body['refresh_token'],
        };
        return Future.value(result);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await request(
        ApiEndPoint.profile,
        'GET',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
          'error': response.body['error_description'],
        };

        throw error;
      }
      return Future.value(response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getProduk(String token) async {
    try {
      final response = await request(
        ApiEndPoint.produk,
        'GET',
        headers: {
          'Authorization': 'bearer $token',
        },
      );

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
          'body' : response.body
        };

        throw error;
      }
      return Future.value(response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> getLogTransaksi(String token) async {
    try {
      final response = await request(ApiEndPoint.logTransaksi, 'Get',
          headers: {'Authorization': 'bearer $token'});

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
        };
        throw error;
      }
      return Future.value(response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> createLogTransaksi(
      List<CartModel> cart, int totalBayar, String token) async {
    try {
      //ubah menjadi json
      final jsonString = jsonEncode(cart);

      final data = {
        "invoice-detail": jsonString,
        "total-bayar": totalBayar.toString(),
      };

      final encodedData = data.entries.map(
        (e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      );
      final body = encodedData.join('&');

      final response = await request(
        ApiEndPoint.logTransaksi,
        "POST",
        body: body,
        headers: {'Authorization': 'bearer $token'},
      );

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data',
        };
        throw error;
      }
      return Future.value(response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<Map<String, dynamic>> deleteLogTransaksi(
      String token, String id) async {
    try {
      final response = await request(
        ApiEndPoint.getLogTransaksi(id: id),
        "DELETE",
        headers: {"Authorization": "bearer $token"},
      );

      if (response.hasError) {
        var error = {
          'statusCode': response.statusCode ?? '500',
          'statusText': response.statusText ?? 'kesalahan dalam mengambil data'
        };

        throw error;
      }

      var result = {
        'statusCode': response.statusCode,
        'statusText': response.statusText,
      };

      return result;
      
    } catch (e) {
      return Future.error(e);
    }
  }
}
