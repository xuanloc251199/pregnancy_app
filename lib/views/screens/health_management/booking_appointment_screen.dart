import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/appointment_controller.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/views/layouts/custom_header.dart';
import 'package:pregnancy_app/views/widgets/custom_text_field_widget.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import '../../../models/doctor_model.dart';

class BookingAppointmentScreen extends StatelessWidget {
  final AppointmentController controller = Get.put(AppointmentController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SafeArea(
                      child: CustomHeader(
                        headerTitle: 'Đặt lịch khám',
                        isPreFixIcon: true,
                        prefixOnTap: () => Get.back(),
                        isSuFixIcon: false,
                        prefixIconImage: AppIcons.ic_back,
                      ),
                    ),
                    SizedBox(height: AppSpace.spaceMain),
                    CustomTextFieldWidget(
                      hintText: 'Họ và tên',
                      controller: nameController,
                    ),
                    SizedBox(height: AppSpace.spaceSmall),
                    CustomTextFieldWidget(
                      hintText: 'Số điện thoại',
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: AppSpace.spaceSmall),
                    CustomTextFieldWidget(
                      hintText: 'Địa chỉ',
                      controller: addressController,
                    ),
                    SizedBox(height: AppSpace.spaceSmall),

                    /// Dropdown chọn bác sĩ
                    Obx(() => DropdownButtonFormField<Doctor>(
                          decoration:
                              const InputDecoration(labelText: 'Chọn bác sĩ'),
                          value: controller.selectedDoctor.value,
                          items: controller.doctors
                              .map((doctor) => DropdownMenuItem<Doctor>(
                                    value: doctor,
                                    child: Text(doctor.name),
                                  ))
                              .toList(),
                          onChanged: (Doctor? val) =>
                              controller.selectedDoctor.value = val,
                        )),
                    SizedBox(height: AppSpace.spaceSmall),

                    /// Ngày khám
                    Obx(() => ListTile(
                          title: Text(controller.selectedDate.value == null
                              ? 'Chọn ngày khám'
                              : '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
                            );
                            if (picked != null) {
                              controller.selectedDate.value = picked;
                            }
                          },
                        )),

                    /// Giờ khám
                    Obx(() => ListTile(
                          title: Text(controller.selectedTime.value == null
                              ? 'Chọn thời gian'
                              : controller.selectedTime.value!),
                          trailing: const Icon(Icons.access_time),
                          onTap: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              final formatted =
                                  '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                              controller.selectedTime.value = formatted;
                            }
                          },
                        )),

                    /// Ghi chú
                    CustomTextFieldWidget(
                      hintText: 'Ghi chú thêm',
                      controller: noteController,
                    ),
                    SizedBox(height: AppSpace.spaceSmall),

                    /// Loại khám
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => RadioListTile(
                                title: const Text('Khám trực tiếp'),
                                value: 'offline',
                                groupValue: controller.type.value,
                                onChanged: (val) =>
                                    controller.type.value = val.toString(),
                              )),
                        ),
                        Expanded(
                          child: Obx(() => RadioListTile(
                                title: const Text('Khám online'),
                                value: 'online',
                                groupValue: controller.type.value,
                                onChanged: (val) =>
                                    controller.type.value = val.toString(),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSpace.spaceMain),

                    /// Nút đặt lịch
                    CustomButton(
                      text: 'Đặt lịch',
                      onPressed: () {
                        controller.bookAppointment(
                          name: nameController.text,
                          phone: phoneController.text,
                          address: addressController.text,
                          note: noteController.text,
                        );
                      },
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
