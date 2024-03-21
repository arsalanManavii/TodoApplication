
import 'package:hive_flutter/hive_flutter.dart';

part 'cronometer_task.g.dart';

@HiveType(typeId: 4)
class CronometerTask {
  CronometerTask({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.minut,
    required this.seconds,
  });

  @HiveField(0)
  String image;
  @HiveField(1)
  String title;
  @HiveField(2)
  String subTitle;
  @HiveField(3)
  int minut;
  @HiveField(4)
  int seconds;
}
