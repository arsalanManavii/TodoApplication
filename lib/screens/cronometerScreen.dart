import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/data/cronometer_task.dart';
import 'package:note_application/screens/add_cronometer_screen.dart';
import 'package:note_application/screens/my_custom_paint.dart';

import '../utility/utility.dart';

class CronometerScreen extends StatefulWidget {
  const CronometerScreen({super.key});

  @override
  State<CronometerScreen> createState() => _CronometerScreenState();
}

class _CronometerScreenState extends State<CronometerScreen>
    with SingleTickerProviderStateMixin {
  var cronometerTaskBox = Hive.box<CronometerTask>('cronometerTaskBox');
  Timer? _timer;
  double _percentage = 0;
  String _startButtonStatus = 'شروع';
  String status = 'توقف';
  String _textFormatStatus = '';
  int? _minutConfirm = 0;
  int? _secondsConfirm = 0;
  var actualSeconds;
  bool _isStop = false;
  bool isTimeEnd = false;
  var temp = 1;

  TabController? _tabController;
  double? size;

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer == null) {
    } else {
      this._timer!.cancel();
    }
    super.dispose();
  }

  _startTimer() {
    actualSeconds = (_minutConfirm! * 60) + (_secondsConfirm!);
    var totalSeconds = (_minutConfirm! * 60) + (_secondsConfirm!);

    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        print(' time : ${timer.tick}');
        setState(
          () {
            if (_isStop) {
            } else {
              if (actualSeconds > 0) {
                actualSeconds--;

                if (_minutConfirm == 0 && _secondsConfirm! > 0) {
                  _secondsConfirm = _secondsConfirm! - 1;
                } else if (_minutConfirm! > 0 && _secondsConfirm == 0) {
                  _secondsConfirm = 59;
                  _minutConfirm = _minutConfirm! - 1;
                } else if (_minutConfirm! > 0 && _secondsConfirm! > 0) {
                  _secondsConfirm = _secondsConfirm! - 1;
                }
                if (temp <= totalSeconds) {
                  _percentage = (temp / totalSeconds) * 100;

                  temp++;
                }
              } else {
                setState(
                  () {
                    _percentage = 0.0;
                    _isStop = false;
                    temp = 1;
                    _startButtonStatus = 'شروع';
                    status = 'توقف';
                    isTimeEnd = false;
                    _timer!.cancel();
                  },
                );
              }
            }
          },
        );
      },
    );
  }

  _stopTimer() {
    setState(
      () {
        _secondsConfirm = 0;
        _minutConfirm = 0;
        _percentage = 0.0;
        _isStop = false;
        temp = 1;

        _timer!.cancel();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //   size = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            _getTabBar(),
            _getTabBarContent(),
          ],
        ),
      ),
    );
  }

  Widget _getTabBarContent() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          _getCountDownColumn(),
          _getCountDownColumn(),
        ],
      ),
    );
  }

  Widget _getCountDownColumn() {
    return Column(
      children: [
        Container(
          child: CustomPaint(
            painter: MyCustomPainter(_percentage),
          ),
        ),
        SizedBox(height: 110.0),
        Column(
          children: [
            Text(
              '$_textFormatStatus',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${_minutConfirm.toString().padLeft(2, '0')} : ${_secondsConfirm.toString().padLeft(2, '0')}',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: textColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 120.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                minimumSize: Size(100.0, 40.0),
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  if (isTimeEnd) {
                    if (_isStop) {
                      _isStop = false;
                      status = 'توقف';
                      _textFormatStatus = 'ادامه';
                    } else {
                      status = 'ادامه';
                      _isStop = true;
                      _textFormatStatus = 'توقف';
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('هنوز شروع نکردی'),
                      ),
                    );
                  }
                });
              },
              child: Text(
                '$status',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: whiteColor),
              ),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                minimumSize: Size(100.0, 40.0),
                backgroundColor: lightGreenColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                //for now we have atleast one minut//
                if (_minutConfirm == 0 && !isTimeEnd) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('زمان تسک رو انتخاب کن'),
                    ),
                  );
                } else {
                  setState(
                    () {
                      _textFormatStatus = 'شروع';
                      if (isTimeEnd) {
                        _stopTimer();
                        isTimeEnd = false;
                        _startButtonStatus = 'شروع';
                        status = 'توقف';
                      } else {
                        isTimeEnd = true;
                        _startButtonStatus = 'پایان';
                        _startTimer();
                      }
                    },
                  );
                }
              },
              child: Text(
                '$_startButtonStatus',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: greenColor),
              ),
            ),
          ],
        ),
        SizedBox(height: 32.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'شمارنده های ذخیره',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: greyColor,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: cronometerTaskBox.listenable(),
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: cronometerTaskBox.values.length,
                itemBuilder: (BuildContext context, int index) {
                  var cronometerTask = cronometerTaskBox.values.toList()[index];

                  return Slidable(
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 76.0,
                              height: 76.0,
                              decoration: BoxDecoration(
                                color: Color(0xffFF5252),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Image.asset(
                                'images/delete_icon.png',
                                scale: 4.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 76.0,
                              height: 76.0,
                              decoration: BoxDecoration(
                                color: Color(0xff5263FC),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Image.asset(
                                'images/edit.png',
                                scale: 4.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      child: _getCronometerTasksListItem(cronometerTask));
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _getTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 25.0,
            height: 25.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddCronometerScreen();
                    },
                  ),
                );
              },
              child: Image.asset('images/add_container_icon.png'),
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            width: 25.0,
            height: 25.0,
            child: Image.asset('images/settings_icon.png'),
          ),
          Spacer(),
          Container(
            child: Align(
              alignment: Alignment.centerRight,
              child: TabBar(
                isScrollable: true,
                labelPadding: EdgeInsets.all(8.0),
                labelColor: textColor,
                unselectedLabelColor: greyColor,
                controller: _tabController,
                indicatorColor: greenColor,
                indicatorPadding: EdgeInsets.only(bottom: 12.0),
                labelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                    color: textColor),
                unselectedLabelStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                    color: greyColor),
                tabs: [
                  Tab(
                    text: 'زمان شمار',
                  ),
                  Tab(
                    text: 'شمارنده معکوس',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getCronometerTasksListItem(var cronometerTask) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: Container(
        height: 76.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: whiteColor),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        if (isTimeEnd) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('زمان در حال اجرا است'),
                            ),
                          );
                        } else {
                          _minutConfirm = cronometerTask.minut;
                          _secondsConfirm = cronometerTask.seconds;
                        }
                      },
                    );
                  },
                  child: Image.asset('images/play_button_icon.png')),
              SizedBox(width: 10.0),
              Text(
                '${replaceFarsiNumber('${cronometerTask.minut}').padLeft(2, '${replaceFarsiNumber('0')}')}:${replaceFarsiNumber('${cronometerTask.seconds}').padLeft(2, '${replaceFarsiNumber('0')}')}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              Spacer(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  flex: 3,
                  child: Text(
                    '${cronometerTask.subTitle}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: greyColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                '${cronometerTask.title}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(width: 15.0),
              Image.asset('images/${cronometerTask.image}.png'),
            ],
          ),
        ),
      ),
    );
  }
}
