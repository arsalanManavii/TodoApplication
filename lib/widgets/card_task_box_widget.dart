import 'package:flutter/material.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/utility/utility.dart';

import '../constant/color.dart';

class CardTaskBoxWidget extends StatefulWidget {
  CardTaskBoxWidget({super.key, required this.task});
  Task task;

  @override
  State<CardTaskBoxWidget> createState() => _CardTaskBoxWidgetState();
}

class _CardTaskBoxWidgetState extends State<CardTaskBoxWidget> {
  bool _isDone = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isDone = widget.task.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      width: 380.0,
      height: 132.0,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getCheckBox(),
          Spacer(),
          _getMiddlePartOfBox(),
          SizedBox(width: 15.0),
          _getImage(),
        ],
      ),
    );
  }

  Widget _getImage() {
    return SizedBox(
        width: 116.0,
        height: 116.0,
        child: Image.asset('${widget.task.taskType.image}'));
  }

  Widget _getMiddlePartOfBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 15.0),
        Text(
          '${widget.task.title}',
          style: TextStyle(
              fontSize: 14.0, fontWeight: FontWeight.bold, color: textColor),
        ),
        SizedBox(height: 10.0),
        Text(
          '${widget.task.subTitle}',
          style: TextStyle(
              fontSize: 12.0, fontWeight: FontWeight.normal, color: textColor),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Row(
            children: [
              Container(
                width: 83.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      (widget.task.isAM)
                          ? '${replaceFarsiNumber('${widget.task.hour}').padLeft(2, '${replaceFarsiNumber('0')}')}:${replaceFarsiNumber('${widget.task.minute}').padLeft(2, '${replaceFarsiNumber('0')}')}'
                          : '${replaceFarsiNumber('${widget.task.hour + 12}')}:${replaceFarsiNumber('${widget.task.minute}').padLeft(2, '${replaceFarsiNumber('0')}')}',
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: Image.asset('images/time_icon.png'),
                    )
                  ],
                ),
              ),
              SizedBox(width: 15.0),
              Container(
                width: 92.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: lightGreenColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(14.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'ویرایش',
                      style: TextStyle(
                          color: greenColor,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 16.0,
                      height: 16.0,
                      child: Image.asset('images/edit_icon.png'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _getCheckBox() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isDone = !_isDone;
          widget.task.isDone = _isDone;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 15.0, top: 15.0),
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          border:
              Border.all(color: (_isDone) ? greenColor : greyColor, width: 2),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: (_isDone) ? Image.asset('images/check_icon.png') : Text(''),
      ),
    );
  }
}
