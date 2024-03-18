import 'package:flutter/material.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/utility/utility.dart';

class CronometerTaskWidget extends StatefulWidget {
  CronometerTaskWidget({
    super.key,
    required this.imageAddress,
    required this.title,
    required this.subTitle,
    required this.hour,
    required this.minut,
    required this.seconds,
  });
  String imageAddress;
  String title;
  String subTitle;
  int hour;
  int minut;
  int seconds;

  @override
  State<CronometerTaskWidget> createState() => _CronometerTaskWidgetState();
}

class _CronometerTaskWidgetState extends State<CronometerTaskWidget> {
  @override
  Widget build(BuildContext context) {
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
              Image.asset('images/play_button_icon.png'),
              SizedBox(width: 10.0),
              Text(
                '${replaceFarsiNumber('${widget.hour}').padLeft(2, '${replaceFarsiNumber('0')}')}:${replaceFarsiNumber('${widget.minut}').padLeft(2, '${replaceFarsiNumber('0')}')}:${replaceFarsiNumber('${widget.seconds}').padLeft(2, '${replaceFarsiNumber('0')}')}',
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
                    '${widget.subTitle}',
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
                '${widget.title}',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(width: 15.0),
              Image.asset('images/${widget.imageAddress}.png'),
            ],
          ),
        ),
      ),
    );
  }
}
