import 'package:hive/hive.dart';
import 'package:note_application/data/task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  Task(
      {required this.title,
      required this.subTitle,
      this.isDone = false,
      required this.hour,
      required this.minute,
      required this.taskType,
      required this.isAM });

  @HiveField(0)
  String title;
  @HiveField(1)
  String subTitle;
  @HiveField(2)
  bool isDone;
  @HiveField(3)
  int hour;
  @HiveField(4)
  int minute;
  @HiveField(5)
  TaskType taskType;
  @HiveField(6)
  bool isAM;
}
