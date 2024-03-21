import 'package:flutter/material.dart';

import '../constant/color.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {super.key,
      required this.text,
      required this.controller,
      required this.focusNode});

  String text;
  TextEditingController controller;
  FocusNode focusNode;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 44),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: '${widget.text}',
            labelStyle: TextStyle(
              fontSize: 20,
              color: widget.focusNode.hasFocus ? greenColor : greyColor,
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
