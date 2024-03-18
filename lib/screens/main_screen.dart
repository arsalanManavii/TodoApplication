import 'package:flutter/material.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/screens/calendar_screen.dart';
import 'package:note_application/screens/cronometerScreen.dart';
import 'package:note_application/screens/home_screen.dart';
import 'package:note_application/screens/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedBottomNavigationIndex = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 83.0,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(),
          onTap: (value) {
            setState(() {
              _selectedBottomNavigationIndex = value;
            });
          },
          currentIndex: _selectedBottomNavigationIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('images/settings_icon_bottom_navigation.png'),
              label: 'home',
              activeIcon: Container(
                height: 25.0,
                width: 25.0,
                child: Icon(
                  Icons.settings,
                  color: greenColor,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/time_icon_bottom_navigation.png'),
              label: 'home',
              activeIcon: Container(
                width: 20.0,
                height: 20.0,
                child: Image.asset(
                  'images/time_icon_bottom_navigation_active.png',
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/calendar_bottom_navigation.png'),
              label: 'home',
              activeIcon: Container(
                width: 20.0,
                height: 20.0,
                child: Image.asset(
                  'images/calendar_bottom_navigation_active.png',
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset('images/home_icon.png'),
              label: 'home',
              activeIcon: Container(
                width: 20.0,
                height: 20.0,
                child: Image.asset('images/home_icon_active.png'),
              ),
            ),
          ],
        ),
      ),
      body: getScreens().elementAt(_selectedBottomNavigationIndex)
    );
  }

  List<Widget> getScreens() {
    return <Widget>[
      SettingScreen(),
      CronometerScreen(),
      CalendarScreen(),
      HomeScreen(),
    ];
  }
}
