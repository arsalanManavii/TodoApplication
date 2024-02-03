import 'package:flutter/material.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/utility/utility.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CalendartScreen extends StatefulWidget {
  const CalendartScreen({super.key});

  @override
  State<CalendartScreen> createState() => _CalendartScreenState();
}

class _CalendartScreenState extends State<CalendartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            _getCalendarHeader(),
          ],
        ),
      ),
    );
  }

  Widget _getCalendarHeader() {
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Image.asset(
                    'images/calendar.png',
                    scale: 3.8,
                  ),
                ),
                SizedBox(width: 30.0),
                CircularPercentIndicator(
                  radius: 27.0,
                  lineWidth: 5,
                  backgroundColor: lightGreenColor,
                  progressColor: greenColor,
                  percent: 0.2,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '%',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                      Text(
                        '${replaceFarsiNumber('20')}',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          'شهریور',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${replaceFarsiNumber(' 2')}',
                          style: TextStyle(
                              color: textColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          'تسک فعال در امروز',
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${replaceFarsiNumber(' 10')}',
                          style: TextStyle(
                              color: greyColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
