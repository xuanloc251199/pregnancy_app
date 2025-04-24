import 'dart:convert';
import '../services/api_service.dart';

class PregnancyInfoRepository {
  Future<Map<String, dynamic>> savePregnancyDate(
      {required String pregnantDate}) async {
    final response = await ApiService.post('/pregnancy-info',
        body: {
          'pregnant_date': pregnantDate,
        },
        useToken: true);

    return {
      'statusCode': response.statusCode,
      'body': jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>?> getPregnancyInfo() async {
    final response = await ApiService.get('/pregnancy-info', useToken: true);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }
}
