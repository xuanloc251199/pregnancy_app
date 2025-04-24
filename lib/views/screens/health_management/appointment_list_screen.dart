import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/colors.dart';

import '../../../controllers/appointment_controller.dart';
import '../../../models/appointment_model.dart';

class AppointmentListScreen extends StatelessWidget {
  final AppointmentController appointmentController =
      Get.find<AppointmentController>();

  AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Khi màn hình mở lên sẽ load danh sách lịch
    appointmentController.fetchUserAppointments();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch khám của bạn'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (appointmentController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final appointments = appointmentController.appointments;
        if (appointments.isEmpty) {
          return const Center(child: Text('Bạn chưa có lịch khám nào.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: appointments.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final ap = appointments[index];
            return _AppointmentItem(ap: ap);
          },
        );
      }),
    );
  }
}

class _AppointmentItem extends StatelessWidget {
  final Appointment ap;
  const _AppointmentItem({required this.ap});

  @override
  Widget build(BuildContext context) {
    final doctorName = ap.doctor?.name ?? 'Chưa chọn';
    final doctorAvatar = ap.doctor?.avatar;
    final statusColor = _getStatusColor(ap.status);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: doctorAvatar != null && doctorAvatar.isNotEmpty
                  ? NetworkImage(doctorAvatar)
                  : null,
              child: doctorAvatar == null || doctorAvatar.isEmpty
                  ? const Icon(Icons.person, size: 28)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bác sĩ: $doctorName',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(
                    'Thời gian: ${_formatDate(ap.date)}  ${ap.time}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                      'Loại khám: ${ap.type == 'online' ? 'Online' : 'Tại bệnh viện'}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  if (ap.note != null && ap.note!.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text('Ghi chú: ${ap.note}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                    ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _statusText(ap.status),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final d = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(d);
    } catch (e) {
      return dateStr;
    }
  }

  String _statusText(String status) {
    switch (status) {
      case 'pending':
        return 'Chờ xác nhận';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'cancelled':
        return 'Đã hủy';
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
