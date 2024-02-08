import 'package:note_application/enums/task_type_enum.dart';

class TaskType {
  TaskType({
    required this.image,
    required this.title,
    required this.taskTypeEnum,
  });

  String image;
  String title;
  Enum taskTypeEnum;
}
