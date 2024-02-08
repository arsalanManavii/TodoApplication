import 'package:flutter/material.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/utility/utility.dart';
import 'package:numberpicker/numberpicker.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  final controllerTitle = TextEditingController();
  final controllerSubTitle = TextEditingController();
  var hour = 0;
  var minute = 0;
  bool isAMFormat = true;
  int _selectedItem = 0;
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.0),
            _getTitleContainer(),
            SizedBox(height: 25.0),
            _getSubTitleContainer(),
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
              onPressed: () {},
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
                        minValue: 0,
                        maxValue: 12,
                        value: hour,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            hour = value;
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
                        value: minute,
                        zeroPad: true,
                        infiniteLoop: true,
                        itemWidth: 80,
                        itemHeight: 60,
                        onChanged: (value) {
                          setState(() {
                            minute = value;
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
                      onTap: () {},
                      child: Text(
                        'تایید',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: greenColor),
                      ),
                    ),
                  )
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
          isAMFormat = false;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          color: !isAMFormat ? greenColor : greenColor.withOpacity(0.4),
          border: Border.all(
            color: !isAMFormat == "PM" ? whiteColor : Colors.transparent,
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
          isAMFormat = true;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            color: isAMFormat ? greenColor : greenColor.withOpacity(0.4),
            border: Border.all(
              color: isAMFormat ? whiteColor : Colors.transparent,
            )),
        child: Text(
          "ق.ظ",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  Widget _getSubTitleContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controllerSubTitle,
          maxLines: 2,
          focusNode: negahban2,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'توضیحات تسک',
            labelStyle: TextStyle(
              fontSize: 20,
              color: negahban2.hasFocus ? greenColor : greyColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                width: 3,
                color: greenColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTitleContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controllerTitle,
          focusNode: negahban1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'عنوان تسک',
            labelStyle: TextStyle(
              fontSize: 20,
              color: negahban1.hasFocus ? greenColor : greyColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(
                width: 3,
                color: greenColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
