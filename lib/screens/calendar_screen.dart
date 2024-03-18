import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/utility/utility.dart';
import 'package:note_application/widgets/card_task_box_widget.dart';
import 'package:note_application/widgets/time_line_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  List<Task>? tasks;
  bool _isVisible = false;
  String _arrowDirection = 'up_arrow';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tasks = taskBox.values.where((element) => element.isDone == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        backgroundColor: greenColor,
        child: Image.asset('images/add_icon.png'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            SliverToBoxAdapter(
              child: _getCalendarHeader(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 32.0),
            ),
            SliverToBoxAdapter(
              child: _getCalendarContainer(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 15.0),
            ),
            SliverToBoxAdapter(
              child: TimeLineWidget(),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 32.0),
            ),
            _getTaskContainer(),
            _getDoneTaskButton(),
            SliverPadding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Visibility(
                  visible: _isVisible,
                  child: Stack(
                    children: [
                      CardTaskBoxWidget(
                        task: tasks![index],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        width: 380.0,
                        height: 132.0,
                        decoration: BoxDecoration(
                          color: whiteColor.withOpacity(0.6),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }, childCount: tasks!.length),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTaskContainer() {
    return ValueListenableBuilder(
      valueListenable: taskBox.listenable(),
      builder: (context, value, child) {
        var tasks = taskBox.values.where((element) => element.isDone == false).toList();
        return SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var task = tasks[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                task.delete();
              },
              child: CardTaskBoxWidget(
                task: task,
              ),
            );
          }, childCount: tasks.length),
        );
      },
    );
  }

  Widget _getDoneTaskButton() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
      sliver: SliverToBoxAdapter(
        child: Container(
          width: 380.0,
          height: 32.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                color: Color(0xff00000005),
              ),
              BoxShadow(
                offset: Offset(0.0, 10.0),
                blurRadius: 23.0,
                color: Color(0xff00000005),
              ),
              BoxShadow(
                offset: Offset(0.0, 42.0),
                blurRadius: 42.0,
                color: Color(0xff00000005),
              ),
              BoxShadow(
                offset: Offset(0.0, 94.0),
                blurRadius: 56.0,
                color: Color(0xff00000003),
              ),
              BoxShadow(
                offset: Offset(0.0, 167.0),
                blurRadius: 67.0,
                color: Color(0xff00000000),
              ),
              BoxShadow(
                offset: Offset(0.0, 261.0),
                blurRadius: 73.0,
                color: Color(0xff00000000),
              ),
            ],
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                tasks = taskBox.values
                    .where((element) => element.isDone == true)
                    .toList();
                _isVisible = !_isVisible;
                if (_isVisible) {
                  _arrowDirection = 'down_arrow';
                } else {
                  _arrowDirection = 'up_arrow';
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12.0),
                  width: 14.0,
                  height: 8.0,
                  child: Image.asset('images/$_arrowDirection.png'),
                ),
                Text(
                  'تسک های انجام شده',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCalendarContainer() {
    return Container(
      height: 100.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 80.0,
            height: 99.0,
            decoration: (index == 0)
                ? BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        color: greenColor.withOpacity(0.1),
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 2.0),
                        blurRadius: 5.0,
                        color: greenColor.withOpacity(0.1),
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 10.0),
                        blurRadius: 10.0,
                        color: greenColor.withOpacity(0.09),
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 22.0),
                        blurRadius: 13.0,
                        color: greenColor.withOpacity(0.05),
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 38.0),
                        blurRadius: 15.0,
                        color: greenColor.withOpacity(0.01),
                      ),
                      BoxShadow(
                        offset: Offset(0.0, 60.0),
                        blurRadius: 17.0,
                        color: greenColor.withOpacity(0.0),
                      ),
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(22.0),
                    ),
                    color: greenColor,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(22.0),
                    ),
                    color: lightGreenColor,
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'چهارشنبه',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: (index == 0) ? whiteColor : greenColor),
                ),
                Text(
                  '${replaceFarsiNumber('2')}',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: (index == 0) ? whiteColor : greenColor),
                ),
              ],
            ),
          );
        },
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
