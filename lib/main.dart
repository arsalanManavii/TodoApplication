import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/cronometer_task.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/data/task_type.dart';
import 'package:note_application/enums/task_type_enum.dart';
import 'package:note_application/screens/add_cronometer_screen.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/screens/main_screen.dart';

void main() async {
  var app = Application();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(CronometerTaskAdapter());
  await Hive.openBox<Task>('taskBox');
  await Hive.openBox<CronometerTask>('cronometerTaskBox');
  runApp(app);
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SM'),
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
