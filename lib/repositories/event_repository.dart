// import 'package:dio/dio.dart';
// import 'package:pregnancy_app/models/event.dart';
// import 'package:pregnancy_app/services/api_service.dart';

// class EventRepository {
//   final ApiService apiService;

//   EventRepository(this.apiService);

//   Future<List<Event>> fetchEvents() async {
//     final response = await apiService.get('/events');

//     if (response.statusCode == 200) {
//       final jsonData = response.data['data'];

//       // Nếu JSON là danh sách sự kiện
//       if (jsonData is List) {
//         return jsonData
//             .map((e) => Event.fromJson(e as Map<String, dynamic>))
//             .toList();
//       }

//       // Nếu JSON là một sự kiện đơn lẻ (không phải danh sách)
//       if (jsonData is Map<String, dynamic>) {
//         return [Event.fromJson(jsonData)];
//       }

//       throw Exception("Unexpected data format");
//     } else {
//       throw Exception("Failed to fetch events");
//     }
//   }

//   Future<List<Event>> fetchUpcomingEvents() async {
//     final response = await apiService.get('/events/upcoming');

//     if (response.statusCode == 200) {
//       final jsonData = response.data['data'];

//       // Nếu JSON là danh sách sự kiện
//       if (jsonData is List) {
//         return jsonData
//             .map((e) => Event.fromJson(e as Map<String, dynamic>))
//             .toList();
//       }

//       // Nếu JSON là một sự kiện đơn lẻ (không phải danh sách)
//       if (jsonData is Map<String, dynamic>) {
//         return [Event.fromJson(jsonData)];
//       }

//       throw Exception("Unexpected data format");
//     } else {
//       throw Exception("Failed to fetch events");
//     }
//   }

//   Future<List<Event>> fetchRecommendations(String token) async {
//     try {
//       final response = await apiService.get(
//         '/events/recommendations',
//         headers: {'Authorization': 'Bearer $token'},
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = response.data['data'];

//         // Chuyển đổi JSON thành danh sách Event
//         List<Event> events = jsonData.map((e) => Event.fromJson(e)).toList();

//         return events;
//       } else {
//         throw Exception("Failed to fetch recommendations");
//       }
//     } catch (e) {
//       throw Exception('Error fetching recommendations: $e');
//     }
//   }

//   Future<Event> fetchEventById(String eventId) async {
//     try {
//       final response = await apiService.get('/events/$eventId');
//       if (response.statusCode == 200) {
//         final jsonData = response.data['data'];
//         return Event.fromJson(jsonData);
//       } else {
//         throw Exception(
//             'Failed to fetch event by ID. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching event by ID: $e');
//     }
//   }

//   // Phương thức đăng ký sự kiện
//   Future<Response> register(String eventId, String token) async {
//     try {
//       final response = await apiService.post(
//         '/events/$eventId/register',
//         {},
//         headers: {'Authorization': 'Bearer $token'}, // Thêm token vào header
//       );
//       return response;
//     } catch (e) {
//       print('Error during registration: $e');
//       rethrow;
//     }
//   }

//   // Phương thức check-in sự kiện
//   Future<Response> checkIn(String eventId, String token) async {
//     try {
//       final response = await apiService.post(
//         '/events/$eventId/check-in',
//         {},
//         headers: {'Authorization': 'Bearer $token'}, // Thêm token vào header
//       );
//       return response;
//     } catch (e) {
//       print('Error during check-in: $e');
//       rethrow;
//     }
//   }
// }
