import 'package:note_application/data/cronometer_task.dart';
import 'package:note_application/data/task_type.dart';
import 'package:note_application/enums/task_type_enum.dart';

List<String> list() {
  var listResult = [
    'همه',
    '${replaceFarsiNumber('8')}:${replaceFarsiNumber('30')} - ${replaceFarsiNumber('10')}',
    '${replaceFarsiNumber('10')} - ${replaceFarsiNumber('12')}',
    '${replaceFarsiNumber('12')} - ${replaceFarsiNumber('13')}:${replaceFarsiNumber('30')}',
    '${replaceFarsiNumber('14')} - ${replaceFarsiNumber('16')}:${replaceFarsiNumber('20')}',
    '${replaceFarsiNumber('18')} - ${replaceFarsiNumber('19')}:${replaceFarsiNumber('30')}',
    '${replaceFarsiNumber('20')}:${replaceFarsiNumber('30')} - ${replaceFarsiNumber('21')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
    '${replaceFarsiNumber('23')}:${replaceFarsiNumber('15')} - ${replaceFarsiNumber('00')}',
  ];

  return listResult;
}

List<TaskType> getTaskItem() {
  var listTask = [
    TaskType(
        image: 'images/banking.png',
        title: 'امور مالی',
        taskTypeEnum: TaskTypeEnum.banking),
    TaskType(
        image: 'images/hard_working.png',
        title: 'کار کردن',
        taskTypeEnum: TaskTypeEnum.hardWorking),
    TaskType(
        image: 'images/meditate.png',
        title: 'مدیتیشن',
        taskTypeEnum: TaskTypeEnum.meditate),
    TaskType(
        image: 'images/social_friends.png',
        title: 'قرار دوستانه',
        taskTypeEnum: TaskTypeEnum.socialFriends),
    TaskType(
        image: 'images/study_english.png',
        title: 'زبان خوندن',
        taskTypeEnum: TaskTypeEnum.studyEnglish),
    TaskType(
        image: 'images/study.png',
        title: 'مطالعه کردن',
        taskTypeEnum: TaskTypeEnum.study),
    TaskType(
        image: 'images/ui_practice.png',
        title: 'طراحی ',
        taskTypeEnum: TaskTypeEnum.uiPractice),
    TaskType(
        image: 'images/work_meeting.png',
        title: 'قرار کاری',
        taskTypeEnum: TaskTypeEnum.workMeeting),
    TaskType(
        image: 'images/workout.png',
        title: 'ورزش کردن',
        taskTypeEnum: TaskTypeEnum.workout),
  ];

  return listTask;
}

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

List<CronometerTask> getCronometerTask(){
  List<CronometerTask> list = [
    CronometerTask(image: 'icon1', title: 'کارآموزی', subTitle: 'جلسه با خانم رضایی', hour: 0, minut: 25, seconds: 0),
    CronometerTask(image: 'icon2', title: 'همانگی', subTitle: 'جلسه هماهنگی کارها', hour: 0, minut: 6, seconds: 10),
    CronometerTask(image: 'icon2', title: 'جلسه', subTitle: 'گفتگو راجب رونده استارتاپ', hour: 1, minut: 0, seconds: 0),
    CronometerTask(image: 'icon3', title: 'لایو', subTitle: 'دیدن لایو طبقه ۱۶', hour: 0, minut: 40, seconds: 0),

  ];
  return list;
}


