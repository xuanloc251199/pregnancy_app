class ToDoItem {
  String content;
  bool isDone;

  ToDoItem({required this.content, this.isDone = false});
}

class ToDoGroup {
  String title;
  List<ToDoItem> items;
  bool isExpanded;

  ToDoGroup({
    required this.title,
    this.items = const [],
    this.isExpanded = false,
  });
}
