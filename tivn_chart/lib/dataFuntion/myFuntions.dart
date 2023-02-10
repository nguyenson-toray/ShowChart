import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iso_calendar/iso_calendar.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class MyFuntions {
  static showToastNoConnection() {
    Fluttertoast.showToast(
        msg: "Không có kết nối tới máy chủ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // static Future<void> setVolume(double level) async {
  //   try {
  //     await FlutterVolumeController.setMute(false);
  //     await FlutterVolumeController.setVolume(level);
  //   } on PlatformException {
  //     print('setVolume - FlutterVolumeController ERROR');
  //   }
  // }

  // static playMedia(String fileName) async {
  //   String audioAsset = "${fileName}";
  //   AudioPlayer player = AudioPlayer();
  //   await setVolume(0.8);
  //   player.setVolume(1);
  //   await player.play(AssetSource(audioAsset));
  // }

  static List<T011stInspectionData> filterInspectionRangeTimeLine(
      List<T011stInspectionData> input,
      int inspectionType,
      String typeTime,
      int rangeTime,
      int line) {
    List<T011stInspectionData> t01sFilter = input;
    List<T011stInspectionData> result = [];
    int rangeDay = 0;
    if (typeTime == 'daily') rangeDay = rangeTime;
    if (typeTime == 'weekly') rangeDay = rangeTime * 7;
    if (typeTime == 'monthly') rangeDay = rangeTime * 31;
    DateTime beginDate = global.today.subtract(Duration(days: rangeDay));
    if (line != 0) t01sFilter.removeWhere((element) => element.getX01 != line);
    t01sFilter.removeWhere((element) => element.getSecondary != inspectionType);
    t01sFilter.removeWhere((element) => element.getX01 == 9);
    t01sFilter.forEach((element) {
      var day = DateTime.parse(element.getX02);
      if (day.isAfter(beginDate)) {
        result.add(element);
      }
    });
    print(
        'filterInspectionRangTime : Inspection = ${inspectionType.toString()} - RangTime  from ${DateFormat(global.dateFormat).format(
      beginDate,
    )} to today => Result lenght = ${result.length.toString()} !!!');
    return result;
  }

  static DateTime firstDateOfWeek(String weekYear) {
    DateTime startDate;
    DateTime newDateTime;
    int year = int.parse(weekYear.split('-')[0]);
    int week = int.parse(weekYear.split('-')[1]);
    int totaldays = (week - 1) * 7;
    final extraDuration = Duration(days: totaldays);
    startDate = DateTime(year);
    newDateTime = startDate.add(extraDuration);
    print(
        'firstDateOfWeekNumber week : $week - year : $year =>first day : ${newDateTime.toString()}');
    return newDateTime;
  }

  static DateTime lastDateOfWeek(String weekYear) {
    DateTime startDate;
    DateTime newDateTime;
    int year = int.parse(weekYear.split('-')[0]);
    int week = int.parse(weekYear.split('-')[1]);
    int totaldays = (week - 1) * 7 + 6;
    final extraDuration = Duration(days: totaldays);
    startDate = DateTime(year);
    newDateTime = startDate.add(extraDuration);
    print(
        'firstDateOfWeekNumber week : $week - year : $year =>first day : ${newDateTime.toString()}');
    return newDateTime;
  }

  static String dateTimeToWeek(String date) {
    var weekNumber = IsoCalendar.fromDateTime(DateTime.parse(date)).weekNumber;
    var weekString =
        weekNumber > 9 ? weekNumber.toString() : '0' + weekNumber.toString();
    var weekName = DateTime.parse(date).year.toString() + '-' + weekString;
    return weekName;
  }

  static String dateTimeToMonth(String date) {
    final monthNumber = DateTime.parse(date).month;
    var monthString =
        monthNumber > 9 ? monthNumber.toString() : '0' + monthNumber.toString();
    final monthName = DateTime.parse(date).year.toString() + '-' + monthString;
    return monthName;
  }
}
