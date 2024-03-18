import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/screens/my_custom_paint.dart';
import 'package:note_application/utility/utility.dart';
import 'package:note_application/widgets/cronometer_task_widget.dart';

class CronometerScreen extends StatefulWidget {
  const CronometerScreen({super.key});

  @override
  State<CronometerScreen> createState() => _CronometerScreenState();
}

class _CronometerScreenState extends State<CronometerScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  double _percentage = 0;
  var minute = 0;
  var seconds = 0;
  String _timerStatus = 'شروع';
  String status = 'توقف';
  String _mainStatus = '';
  int? _minutConfirm = 1;
  int? _secondsConfirm = 5;
  var actualSeconds;
  bool isStop = false;
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
            if (isStop) {
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
                  var per = (temp / totalSeconds) * 100;
                  _percentage = per;
                  temp++;
                }
              }
            }
          },
        );
        print('percent : $_percentage');
      },
    );
  }

  _stopTimer() {
    setState(
      () {
        _secondsConfirm = 0;
        _minutConfirm = 0;
        _percentage = 0.0;
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
              '$_mainStatus',
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
                    if (isStop) {
                      isStop = false;
                      status = 'توقف';
                      _mainStatus = 'ادامه';
                    } else {
                      status = 'ادامه';
                      isStop = true;
                      _mainStatus = 'توقف';
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
                setState(
                  () {
                    _mainStatus = 'شروع';
                    if (isTimeEnd) {
                      _stopTimer();
                      isTimeEnd = false;
                    } else {
                      isTimeEnd = true;
                      _timerStatus = 'پایان';
                    }
                    _startTimer();
                  },
                );
              },
              child: Text(
                '$_timerStatus',
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
          child: ListView.builder(
            itemCount: getCronometerTask().length,
            itemBuilder: (BuildContext context, int index) {
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
                child: CronometerTaskWidget(
                    imageAddress: getCronometerTask()[index].image,
                    title: getCronometerTask()[index].title,
                    subTitle: getCronometerTask()[index].subTitle,
                    hour: getCronometerTask()[index].hour,
                    minut: getCronometerTask()[index].minut,
                    seconds: getCronometerTask()[index].seconds),
              );
            },
          ),
        )
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
            child: Image.asset('images/add_container_icon.png'),
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
}
