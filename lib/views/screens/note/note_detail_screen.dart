import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/sizes.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/widgets/icon_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/note_controller.dart';
import '../../layouts/custom_header.dart';

class NoteDetailScreen extends StatelessWidget {
  final int groupIndex;
  NoteDetailScreen({required this.groupIndex});

  final TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteController>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppSpace.spaceMedium,
                  horizontal: AppSpace.spaceMedium),
              child: Obx(
                () => CustomHeader(
                  isPreFixIcon: true,
                  isSuFixIcon: false,
                  prefixIconImage: AppIcons.ic_back,
                  prefixOnTap: () => Get.back(),
                  headerTitle: controller.todoGroups[groupIndex].title,
                  textStyle: AppTextStyle.textTitle1Style,
                ),
              ),
            ),
            // Add to-do field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        hintText: "Add to-do",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpace.spaceSmall),
                  GestureDetector(
                    onTap: () {
                      if (todoController.text.trim().isNotEmpty) {
                        controller.addToDoItem(
                            groupIndex, todoController.text.trim());
                        todoController.clear();
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSpace.spaceMain,
            ),
            Expanded(
              child: Obx(() {
                final items = controller.todoGroups[groupIndex].items;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, itemIndex) {
                    final item = items[itemIndex];
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () =>
                            controller.toggleDone(groupIndex, itemIndex),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: item.isDone
                                  ? AppColors.primaryColor
                                  : AppColors.redColor,
                              width: 2,
                            ),
                          ),
                          child: item.isDone
                              ? Icon(Icons.check,
                                  size: AppSizes.iconButtonSize,
                                  color: AppColors.primaryColor)
                              : null,
                        ),
                      ),
                      title: Text(
                        item.content,
                        style: AppTextStyle.textMainStyle.copyWith(
                          decoration:
                              item.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: AppColors.redColor),
                        onPressed: () =>
                            controller.removeItem(groupIndex, itemIndex),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
