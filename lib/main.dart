import 'package:flutter/material.dart';
import 'package:note_application/screens/calendar_screen.dart';
import 'package:note_application/screens/home_screen.dart';

void main() {
  var app = Application();
  runApp(app);
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SM'),
      debugShowCheckedModeBanner: false,
      home: CalendarScreen(),
    );
  }
}
