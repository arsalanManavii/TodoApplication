import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/cronometer_task.dart';
import 'package:note_application/widgets/text_field_widget.dart';
import 'package:numberpicker/numberpicker.dart';

import '../constant/color.dart';
import '../data/task.dart';

class AddCronometerScreen extends StatefulWidget {
  const AddCronometerScreen({super.key});

  @override
  State<AddCronometerScreen> createState() => _AddCronometerScreenState();
}

class _AddCronometerScreenState extends State<AddCronometerScreen> {
  var _cronometerTaskBox = Hive.box<CronometerTask>('cronometerTaskBox');

  final controllerCronometerTitle = TextEditingController();
  final controllerCronometerSubTitle = TextEditingController();

  FocusNode _focusNodeTitle = FocusNode();
  FocusNode _focusNodeSubTitle = FocusNode();

  //variables
  var _minute = 1;
  var _seconds = 0;

  bool _isTimePicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNodeTitle.addListener(
      () {
        setState(
          () {},
        );
      },
    );
    _focusNodeSubTitle.addListener(
      () {
        setState(
          () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 120.0),
              TextFieldWidget(
                  text: 'عنوان شمارنده معکوس',
                  controller: controllerCronometerTitle,
                  focusNode: _focusNodeTitle),
              SizedBox(height: 25.0),
              TextFieldWidget(
                text: 'توضیحات شمارنده معکوس',
                controller: controllerCronometerSubTitle,
                focusNode: _focusNodeSubTitle,
              ),
              SizedBox(height: 35.0),
              _getCronometerTimePicker(),
              SizedBox(height: 50.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 50),
                  backgroundColor: greenColor,
                ),
                onPressed: () {
                  if (!isValid()) {
                    String properMessage = errorValidationMessage();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          properMessage,
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    //add data to hive
                    _cronometerTaskBox.add(
                      CronometerTask(
                        image: 'icon1',
                        title: controllerCronometerTitle.text,
                        subTitle: controllerCronometerSubTitle.text,
                        minut: _minute,
                        seconds: _seconds,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'اضافه کردن تسک',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: whiteColor),
                ),
              ),
            ],
          ),
        ));
  }

  bool isValid() {
    if (controllerCronometerTitle.text.isEmpty ||
        controllerCronometerSubTitle.text.isEmpty) {
      return false;
    } else if (!_isTimePicked) {
      return false;
    } else {
      return true;
    }
  }

  String errorValidationMessage() {
    if (controllerCronometerTitle.text.isEmpty ||
        controllerCronometerSubTitle.text.isEmpty) {
      return 'تسک یا توضیحات یادت نره';
    } else {
      return 'زمان رو یادت رفته!';
    }
  }

  Widget _getCronometerTimePicker() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NumberPicker(
                      minValue: 1,
                      maxValue: 59,
                      value: _minute,
                      zeroPad: false,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 60,
                      onChanged: (value) {
                        setState(() {
                          _minute = value;
                        });
                      },
                      textStyle: TextStyle(
                          color: greenColor.withOpacity(0.3), fontSize: 20),
                      selectedTextStyle:
                          TextStyle(color: greenColor, fontSize: 30),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: greenColor.withOpacity(0.8),
                          ),
                          bottom: BorderSide(
                            color: greenColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      value: _seconds,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 80,
                      itemHeight: 60,
                      onChanged: (value) {
                        setState(() {
                          _seconds = value;
                        });
                      },
                      textStyle: TextStyle(
                          color: greenColor.withOpacity(0.3), fontSize: 20),
                      selectedTextStyle:
                          TextStyle(color: greenColor, fontSize: 30),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: greenColor.withOpacity(0.8),
                          ),
                          bottom:
                              BorderSide(color: greenColor.withOpacity(0.8)),
                        ),
                      ),
                    ),
                  ],
                ),
                Material(
                  child: InkWell(
                    splashColor: greenColor.withOpacity(0.3),
                    onTap: () {
                      setState(
                        () {
                          _isTimePicked = true;
                        },
                      );
                    },
                    child: Text(
                      'تایید',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: greenColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
