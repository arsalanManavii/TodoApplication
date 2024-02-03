import 'package:flutter/material.dart';
import 'package:note_application/constant/color.dart';
import 'package:note_application/widgets/card_task_box_widget.dart';
import 'package:note_application/widgets/time_line_widget.dart';

import '../utility/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.0),
              _getHeader(),
              SizedBox(height: 32.0),
              _getSearchBox(),
              SizedBox(height: 32.0),
              _getCategoryRow(),
              SizedBox(height: 20.0),
              Container(
                height: 163.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return (index % 2 == 0)
                        ? _getItemList('study_icon', 'آموزش')
                        : _getItemList('sport', 'ورزش');
                  },
                ),
              ),
              SizedBox(height: 32.0),
              TimeLineWidget(),
              SizedBox(height: 32.0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return (index % 2 == 0)
                      ? CardTaskBoxWidget(
                          imageName: 'study',
                          title: 'تمرین زبان انگلیسی',
                          subTitle: 'تمرین زبان انگلیسی کتاب آموزشگاه',
                        )
                      : CardTaskBoxWidget(
                          imageName: 'hard_working',
                          title: 'آموزش فلاتر',
                          subTitle: 'دیدن ویدیو های دوره فلاتر Vip امیر احمد',
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCategoryRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'مشاهده بیشتر',
            style: TextStyle(
                color: greenColor, fontSize: 13.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'دسته بندی',
            style: TextStyle(
                color: textColor, fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _getItemList(String imageName, String category) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset('images/$imageName.png'),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            width: 100.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: Color(0xffffffff),
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            child: Center(
              child: Text(
                '$category',
                style: TextStyle(
                    color: textColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSearchBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 15.0),
          Image.asset('images/filter_icon.png'),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'جستوجوی تسکات...',
                    hintStyle: TextStyle(
                        color: greyColor,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
          ),
          SizedBox(width: 15.0),
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: Image.asset('images/search_icon.png'),
          ),
          SizedBox(width: 15.0),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 85.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: lightGreenColor,
              borderRadius: BorderRadius.all(
                Radius.circular(13.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تسک فعال',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: greenColor),
                ),
                Text(
                  '${replaceFarsiNumber(' 20')}',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: greenColor),
                ),
              ],
            ),
          ),
          Spacer(),
          _middlePartHeader(),
          SizedBox(width: 15),
          Container(
            child: Image.asset('images/userProfile.png'),
          ),
        ],
      ),
    );
  }

  Widget _middlePartHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Image.asset('images/greeting_emoji.png'),
            Text(
              ' محمد جواد',
              style: TextStyle(
                  color: greenColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '، سلام',
              style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Text(
              'شهریور',
              style: TextStyle(
                  color: greyColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              ' ${replaceFarsiNumber('2')}',
              style: TextStyle(
                  color: greyColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.normal),
            ),
          ],
        )
      ],
    );
  }
}
