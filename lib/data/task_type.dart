import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/enums/task_type_enum.dart';
part 'task_type.g.dart';
@HiveType(typeId: 2)
class TaskType {
  TaskType({
    required this.image,
    required this.title,
    required this.taskTypeEnum,
  });

  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}
