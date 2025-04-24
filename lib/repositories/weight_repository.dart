import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weight_model.dart';
import '../services/api_service.dart';

class WeightRepository {
  Future<List<WeightEntry>> getAllWeights() async {
    final response = await ApiService.get('/weight-trackers', useToken: true);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((item) => WeightEntry.fromJson(item)).toList();
    } else {
      print('Lỗi getAllWeights: ${response.statusCode} - ${response.body}');
      throw Exception('Lỗi khi lấy danh sách cân nặng');
    }
  }

  Future<WeightEntry?> addWeight(String date, double weight) async {
    final response = await ApiService.post(
      '/weight-trackers',
      useToken: true,
      body: {
        'date': date,
        'weight': weight.toString(),
      },
    );

    if (response.statusCode == 201) {
      return WeightEntry.fromJson(jsonDecode(response.body));
    } else {
      print('Lỗi addWeight: ${response.statusCode} - ${response.body}');
      return null;
    }
  }
}
