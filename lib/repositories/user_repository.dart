import 'dart:convert';
import 'dart:io';
import '../services/api_service.dart';

class UserRepository {
  /// Lấy thông tin user hiện tại
  Future<Map<String, dynamic>?> getProfile() async {
    final response = await ApiService.get('/user/me', useToken: true);
    if (response.statusCode == 200) {
      // Đáp ứng API: {user: {...}}
      final data = jsonDecode(response.body);
      return data['user'];
    }
    return null;
  }

  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? address,
    String? phone,
    File? avatar,
  }) async {
    Map<String, String> fields = {};
    if (name != null) fields['name'] = name;
    if (address != null) fields['address'] = address;
    if (phone != null) fields['phone'] = phone;

    // Nếu có ảnh thì gửi multipart, không thì gửi POST thường
    if (avatar != null) {
      final res = await ApiService.postMultipart(
        '/user/update',
        fields: fields,
        fileField: 'avatar',
        filePath: avatar.path,
        useToken: true,
      );
      final body = await res.stream.bytesToString();
      return {
        'statusCode': res.statusCode,
        'body': jsonDecode(body),
      };
    } else {
      final response = await ApiService.post(
        '/user/update',
        body: fields,
        useToken: true,
      );
      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String oldPassword, String password, String passwordConfirmation) async {
    final response = await ApiService.post('/user/change-password',
        body: {
          'old_password': oldPassword,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        useToken: true);
    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body)
    };
  }
}
