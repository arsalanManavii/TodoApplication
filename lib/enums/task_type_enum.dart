

import 'package:hive_flutter/hive_flutter.dart';
part 'task_type_enum.g.dart';
@HiveType(typeId: 3)
enum TaskTypeEnum {
  @HiveField(0)
  banking,
  @HiveField(1)
  hardWorking,
  @HiveField(2)
  meditate,
  @HiveField(3)
  socialFriends,
  @HiveField(4)
  studyEnglish,
  @HiveField(5)
  study,
  @HiveField(6)
  uiPractice,
  @HiveField(7)
  workMeeting,
  @HiveField(8)
  workout,
}
