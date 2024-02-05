import 'package:flutter/material.dart';

import '../constant/color.dart';
import '../utility/utility.dart';

class TimeLineWidget extends StatefulWidget {
  const TimeLineWidget({super.key});

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  double left = 340;
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Divider(
              color: greenColor.withOpacity(0.2),
              thickness: 1.0,
              endIndent: 24.0,
            ),
            AnimatedPositioned(
              left: left,
              duration: Duration(milliseconds: 100),
              child: Container(
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                  color: Color(0xff18DAA3),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          height: 25.0,
          margin: EdgeInsets.only(right: 16.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemCount: list().length,
            itemBuilder: (BuildContext context, int index) {
              GlobalKey _key = GlobalKey();
              return GestureDetector(
                onTap: () {
                  Offset offset = _getSizedAndPosition(context, _key, index);
                  setState(() {
                    if (offset.dx < 0) {
                      left = offset.dx + 20;
                    } else if (offset.dx <= 392 && offset.dx >= 368 ||
                        offset.dx >= 392) {
                      left = 368.0;
                    } else {
                      left = offset.dx;
                    }

                    _selectedItem = index;
                  });
                },
                child: Container(
                  key: _key,
                  margin: EdgeInsets.only(right: 18.0),
                  child: Text(
                    list()[index],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: (_selectedItem == index)
                            ? Colors.black
                            : Colors.grey),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Offset _getSizedAndPosition(BuildContext context, GlobalKey key, int index) {
    RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);
    Offset resultOffset = Offset(position.dx + (size.width / 2 - (12)), 399.7);
    return resultOffset;
  }
}
