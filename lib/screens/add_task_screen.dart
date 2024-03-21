import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/utility/utility.dart';
import 'package:note_application/widgets/text_field_widget.dart';
import 'package:numberpicker/numberpicker.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final controllerTitle = TextEditingController();
  final controllerSubTitle = TextEditingController();
  var _hour = 1;
  var _minute = 0;
  bool _isAMFormat = true;
  int _selectedItem = 0;
  bool _isTimePicked = false;
  @override
  void initState() {
    super.initState();
    negahban1.addListener(
      () {
        setState(
          () {},
        );
      },
    );
    negahban2.addListener(
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
      backgroundColor: backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            TextFieldWidget(
              text: 'عنوان تسک',
              controller: controllerTitle,
              focusNode: negahban1,
            ),
            SizedBox(height: 25.0),
            TextFieldWidget(
              text: 'توضیحات تسک',
              controller: controllerSubTitle,
              focusNode: negahban2,
            ),
            SizedBox(height: 25.0),
            _getTimePickerContainer(),
            SizedBox(height: 25.0),
            _getTaskTypeList(),
            SizedBox(height: 25.0),
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
                  taskBox.add(
                    Task(
                        title: controllerTitle.text,
                        subTitle: controllerSubTitle.text,
                        hour: _hour,
                        minute: _minute,
                        taskType: getTaskItem()[_selectedItem],
                        isAM: _isAMFormat),
                  );
                  Navigator.of(context).pop();
                  var task = taskBox.values.toList()[0];
                  print(task.title);
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
      ),
    );
  }

  Widget _getTaskTypeList() {
    return Container(
      height: 180.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: getTaskItem().length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(
                () {
                  _selectedItem = index;
                },
              );
            },
            child: Container(
              margin: EdgeInsets.all(10.0),
              height: 150.0,
              width: 130.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                border: (_selectedItem == index)
                    ? Border.all(color: greenColor, width: 2.0)
                    : Border.all(color: greyColor, width: 1.0),
              ),
              child: Column(
                children: [
                  Image.asset(getTaskItem()[index].image),
                  Text(
                    getTaskItem()[index].title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getTimePickerContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Ink(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      NumberPicker(
                        minValue: 1,
                        maxValue: 12,
                        value: _hour,
                        zeroPad: false,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            _hour = value;
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
                        value: _minute,
                        zeroPad: true,
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
                            bottom:
                                BorderSide(color: greenColor.withOpacity(0.8)),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          _getAmContainer(),
                          SizedBox(
                            height: 15,
                          ),
                          _getPMContainer()
                        ],
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
          ),
        ],
      ),
    );
  }

  Widget _getPMContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAMFormat = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: !_isAMFormat ? greenColor : greenColor.withOpacity(0.4),
          border: Border.all(
            color: !_isAMFormat == "PM" ? whiteColor : Colors.transparent,
          ),
        ),
        child: Text(
          "ب.ظ",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  Widget _getAmContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isAMFormat = true;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: _isAMFormat ? greenColor : greenColor.withOpacity(0.4),
            border: Border.all(
              color: _isAMFormat ? whiteColor : Colors.transparent,
            )),
        child: Text(
          "ق.ظ",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  bool isValid() {
    if (controllerTitle.text.isEmpty || controllerSubTitle.text.isEmpty) {
      return false;
    } else if (!_isTimePicked) {
      return false;
    } else {
      return true;
    }
  }

  String errorValidationMessage() {
    if (controllerTitle.text.isEmpty || controllerSubTitle.text.isEmpty) {
      return 'تسک یا توضیحات یادت نره';
    } else if (_hour == 0 || _minute == 0) {
      return 'زمان رو یادت رفته!';
    }
    return '';
  }
}
