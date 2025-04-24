import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  // Đặt baseUrl cho đúng với server của bạn
  static const String baseUrl = 'http://10.0.5.122:8000/api';
  static final box = GetStorage();

  /// Lấy token lưu trong local
  static String? getToken() {
    return box.read('token');
  }

  /// Gửi POST request, có thể truyền thêm token
  static Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool useToken = false,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (useToken && getToken() != null) {
      headers['Authorization'] = 'Bearer ${getToken()}';
    }

    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );
  }

  /// Gửi GET request
  static Future<http.Response> get(
    String endpoint, {
    bool useToken = false,
  }) async {
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (useToken && getToken() != null) {
      headers['Authorization'] = 'Bearer ${getToken()}';
    }
    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
  }

  /// Gửi PUT request
  static Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool useToken = false,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (useToken && getToken() != null) {
      headers['Authorization'] = 'Bearer ${getToken()}';
    }
    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(body ?? {}),
    );
  }

  /// Gửi multipart/form-data (dùng cho upload ảnh)
  static Future<http.StreamedResponse> putMultipart(
    String endpoint, {
    Map<String, String>? fields,
    String? fileField,
    String? filePath,
    bool useToken = false,
  }) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    var request = http.MultipartRequest('PUT', uri);

    if (fields != null) {
      request.fields.addAll(fields);
    }
    if (fileField != null && filePath != null) {
      request.files.add(await http.MultipartFile.fromPath(fileField, filePath));
    }
    if (useToken && getToken() != null) {
      request.headers['Authorization'] = 'Bearer ${getToken()}';
    }
    return await request.send();
  }
}
