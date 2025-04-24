import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {
  // Đặt baseUrl cho đúng với server của bạn
  static const String baseUrl = 'http://192.168.1.6:8000/api';
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
  static Future<http.StreamedResponse> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    String? fileField,
    String? filePath,
    bool useToken = false,
  }) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    var request = http.MultipartRequest('POST', uri);

    if (fields != null) request.fields.addAll(fields);
    if (fileField != null && filePath != null) {
      request.files.add(await http.MultipartFile.fromPath(fileField, filePath));
    }
    if (useToken && getToken() != null) {
      request.headers['Authorization'] = 'Bearer ${getToken()}';
    }
    return await request.send();
  }

  static const String _uploadImageUrl =
      'https://xuanlocportfolio.io.vn/upload.php';
  static const String _babyGeneratorUrl =
      'https://api.maxstudio.ai/baby-generator';
  static const String _apiKey = 'sk_xadstcou55e35qcbxyn1rh';

  // Upload 1 ảnh lên server của bạn -> trả về url
  static Future<String?> uploadImage(File file) async {
    var request = http.MultipartRequest('POST', Uri.parse(_uploadImageUrl));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));
    var resp = await request.send();
    final response = await http.Response.fromStream(resp);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['url'];
    }
    return null;
  }

  // Gọi API Baby Generator MaxStudio
  static Future<String?> createBabyImage({
    required String fatherUrl,
    required String motherUrl,
    required String gender, // babyBoy | babyGirl
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      'x-api-key': _apiKey,
    };
    final body = jsonEncode({
      "fatherImage": fatherUrl,
      "motherImage": motherUrl,
      "gender": gender,
    });

    final resp = await http.post(
      Uri.parse(_babyGeneratorUrl),
      headers: headers,
      body: body,
    );

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      // Trả về jobId, phải GET trạng thái tiếp (theo docs mới nhất)
      if (data['jobId'] != null) {
        return data['jobId'];
      } else if (data['result'] != null && data['result'].isNotEmpty) {
        return data['result'][0];
      }
    }
    throw Exception(resp.body);
  }

  // Kiểm tra trạng thái tạo ảnh (polling lấy kết quả)
  static Future<String?> getBabyImageResult(String jobId) async {
    final headers = {'x-api-key': _apiKey};
    final url = '$_babyGeneratorUrl/$jobId';

    final resp = await http.get(Uri.parse(url), headers: headers);

    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body);
      if (data['status'] == 'completed' &&
          data['result'] != null &&
          data['result'].isNotEmpty) {
        return data['result'][0];
      }
    }
    return null;
  }
}
