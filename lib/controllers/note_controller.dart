import 'package:get/get.dart';
import '../models/todo_model.dart';

class NoteController extends GetxController {
  // Danh sách các nhóm to-do theo từng giai đoạn
  var todoGroups = <ToDoGroup>[
    ToDoGroup(title: "First trimester", items: [
      ToDoItem(
          content:
              "Say goodbye to bad habits (smoking, alcohol, high caffeine intake)"),
      ToDoItem(
          content:
              "Confirm pregnancy (over-the-counter pregnancy test or HCG blood test)"),
      ToDoItem(content: "Find an OB-GYN and hospital"),
      ToDoItem(
          content: "Prepare a list of questions for your first doctor's visit"),
      ToDoItem(
          content:
              "Check your insurance coverage (buy insurance if you don't have any)"),
      ToDoItem(content: "Monthly OB/GYN visits"),
      ToDoItem(content: "Urine test (at each OB/GYN visit)"),
    ]),
    ToDoGroup(title: "Second trimester", items: []),
    ToDoGroup(title: "Third trimester", items: []),
    ToDoGroup(title: "Hospital bag", items: []),
    ToDoGroup(title: "Bringing baby home", items: []),
  ].obs;

  // Index nhóm đang mở
  var expandedIndex = RxnInt();

  // Thêm nhiệm vụ mới vào nhóm
  void addToDoItem(int groupIndex, String content) {
    todoGroups[groupIndex].items.add(ToDoItem(content: content));
    todoGroups.refresh();
  }

  // Đánh dấu hoàn thành
  void toggleDone(int groupIndex, int itemIndex) {
    final item = todoGroups[groupIndex].items[itemIndex];
    item.isDone = !item.isDone;
    todoGroups.refresh();
  }

  // Xoá nhiệm vụ
  void removeItem(int groupIndex, int itemIndex) {
    todoGroups[groupIndex].items.removeAt(itemIndex);
    todoGroups.refresh();
  }

  // Expand/collapse nhóm
  void setExpanded(int? index) {
    expandedIndex.value = index;
  }
}
