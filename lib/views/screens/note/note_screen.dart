import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/note_controller.dart';
import 'note_detail_screen.dart';

class NoteScreen extends StatelessWidget {
  final NoteController controller = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "To-Do List",
                        style: AppTextStyle.textTitle1Style,
                      ),
                    ],
                  ),
                  Image.asset(
                    AppIcons.ic_todo, // Đổi thành asset của bạn
                    height: 10.h,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => ListView.separated(
                    itemCount: controller.todoGroups.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (context, index) {
                      final group = controller.todoGroups[index];
                      return ListTile(
                        title: Text(group.title,
                            style: AppTextStyle.textMainStyle),
                        trailing: Icon(
                          controller.expandedIndex.value == index
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                        ),
                        onTap: () {
                          controller.setExpanded(
                            controller.expandedIndex.value == index
                                ? null
                                : index,
                          );
                          // Chuyển sang màn NoteDetailScreen
                          Get.to(() => NoteDetailScreen(groupIndex: index));
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
