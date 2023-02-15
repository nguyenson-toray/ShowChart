import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iso_calendar/iso_calendar.dart';
import 'package:tivn_chart/dataClass/inspectionSetting.dart';
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
    t01sFilter
        .removeWhere((element) => element.getInspectionType != inspectionType);
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

  static bool parseBool(int integer) {
    if (integer > 0)
      return true;
    else
      return false;
  }
//

  static List<T011stInspectionData> t01FilterByLastInspectionSetting(
      List<T011stInspectionData> allInspectionData, InspectionSetting setting) {
    print('t01FilterByLastInspectionSetting');

    List<T011stInspectionData> output = <T011stInspectionData>[];

    for (final element in allInspectionData) {
      final date = DateFormat(global.dateFormat).parse(element.getX02);
      final today = DateFormat(global.dateFormat).parse(global.todayString);
      if (date == today &&
          element.getInspectionType == setting.getInspectionType &&
          element.getX01 == setting.getLine &&
          element.getX04 == setting.getColor &&
          element.getX03 == setting.getStyleCode &&
          element.getX05 == setting.getSize) {
        output.add(element);
      }
    }
    return output;
  }

  //
  static T011stInspectionData t01sSummaryByLastInspectionSetting(
      List<T011stInspectionData> dataInput, InspectionSetting setting) {
    print('t01sSummaryByLastInspectionSetting');
    T011stInspectionData output = T011stInspectionData();
    if (dataInput.length == 0) return output;
    output.setTMonth = global.today.month;
    output.setTYear = global.today.year;
    output.setInspectionType = setting.getInspectionType;
    output.setX01 = setting.getLine;
    output.setX02 = global.todayString;
    output.setX03 = setting.getStyleCode;
    output.setX04 = setting.getColor;
    output.setX05 = setting.getSize;
    // output.setX06 = 0;
    // output.setX07 = 0;
    // output.setX08 = 0;
    // output.setX09 = 0;
    // output.setX10 = 0;
    // output.setXc = '';
    dataInput.forEach((element) {
      output.setX06 = output.getX06 + element.getX06;
      output.setX07 = output.getX07 + element.getX07;
      output.setX08 = output.getX08 + element.getX08;
      output.setX09 = output.getX09 + element.getX09;
      output.setX10 = output.getX10 + element.getX10;

      output.setA1 = output.getA1 + element.getA1;
      output.setA2 = output.getA2 + element.getA2;
      output.setA3 = output.getA3 + element.getA3;

      output.setB1 = output.getB1 + element.getB1;
      output.setB2 = output.getB2 + element.getB2;
      output.setB3 = output.getB3 + element.getB3;

      output.setC1 = output.getC1 + element.getC1;
      output.setC2 = output.getC2 + element.getC2;

      output.setD1 = output.getD1 + element.getD1;
      output.setD2 = output.getD2 + element.getD2;
      output.setD3 = output.getD3 + element.getD3;
      output.setD4 = output.getD4 + element.getD4;

      output.setE1 = output.getE1 + element.getE1;
      output.setE2 = output.getE2 + element.getE2;
      output.setE3 = output.getE3 + element.getE3;
      output.setE4 = output.getE4 + element.getE4;
      output.setE5 = output.getE5 + element.getE5;
      output.setE6 = output.getE6 + element.getE6;
      output.setE7 = output.getE7 + element.getE7;

      output.setF1 = output.getF1 + element.getF1;
      output.setF2 = output.getF2 + element.getF2;
      output.setF3 = output.getF3 + element.getF3;
      output.setF4 = output.getF4 + element.getF4;
      output.setF5 = output.getF5 + element.getF5;
      output.setF6 = output.getF6 + element.getF6;
      output.setF7 = output.getF7 + element.getF7;
      output.setF8 = output.getF8 + element.getF8;
      output.setF9 = output.getF9 + element.getF9;

      output.setG1 = output.getG1 + element.getG1;
      output.setG2 = output.getG2 + element.getG2;
      output.setG3 = output.getG3 + element.getG3;

      output.setH = output.getH + element.getH;
      output.setXc = output.getXc + element.getXc;
    });
    output.calculateValue();

    return output;
  }

  static void clearDefectQtyCmt() {
    global.defectQtys.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        global.defectQtys[key]![i] = 0;
      }
    });
    global.defectQtys.forEach((key, value) {
      for (int i = 0; i < value.length; i++) {
        global.defectCmts[key]![i] = '';
      }
    });
  }

  static void saveData() {
    print('Save DATA');
    global.t01 = new T011stInspectionData();
    global.t01.setValue(
        global.inspectionSetting,
        global.result,
        global.isRecheck,
        global.isTypeC,
        global.commentTotal,
        global.totalChecked,
        global.defectQtys,
        global.defectNames);

    global.t01.setTime = DateFormat('hh:mm:ss').format(DateTime.now());
    global.t01.setDefectName = global.defectTotal;
    global.t01.setIsReCheck = global.isRecheck;
    global.t01.setTotalChecked = global.totalChecked;
    // print('----------defectQtys----------------- ' +
    //     global.defectQtys.toString());
    // print('-----------defectCmts---------------- ' +
    //     global.defectCmts.toString());
    if (global.result == 'LỖI') {
      global.t01.setTotalChecked = 1;
      String cmt = '';
      global.defectQtys.forEach((key, value) {
        for (int i = 0; i < value.length; i++) {
          if (value[i] > 0) {
            global.t01.setDefectName =
                global.t01.getDefectName + global.defectNames[key]![i] + " ; ";
          }
        }
      });
      global.defectCmts.forEach((key, value) {
        value.forEach((element) {
          if (element.length > 0) cmt = cmt + element + ' ; ';
        });
      });
      global.t01.setXc = cmt;
      global.defectQtys.forEach((key, value) {
        switch (key) {
          case "Thông số":
            {
              global.t01.setA1 = value[0];
              global.t01.setA2 = value[1];
              global.t01.setA3 = value[2];
            }
            break;
          case "Phụ liệu":
            {
              global.t01.setB1 = value[0];
              global.t01.setB2 = value[1];
              global.t01.setB3 = value[2];
            }
            break;
          case "Nguy hiểm":
            {
              global.t01.setC1 = value[0];
              global.t01.setC2 = value[1];
            }
            break;
          case "Vải":
            {
              global.t01.setD1 = value[0];
              global.t01.setD2 = value[1];
              global.t01.setD3 = value[2];
              global.t01.setD4 = value[3];
            }
            break;
          case "Lỗi may đan":
            {
              global.t01.setE1 = value[0];
              global.t01.setE2 = value[1];
              global.t01.setE3 = value[2];
              global.t01.setE4 = value[3];
              global.t01.setE5 = value[4];
              global.t01.setE6 = value[5];
              global.t01.setE7 = value[6];
            }
            break;

          case "Ngoại quan, thành phẩm":
            {
              global.t01.setF1 = value[0];
              global.t01.setF2 = value[1];
              global.t01.setF3 = value[2];
              global.t01.setF4 = value[3];
              global.t01.setF5 = value[4];
              global.t01.setF6 = value[5];
              global.t01.setF7 = value[6];
              global.t01.setF8 = value[8];
              global.t01.setF9 = value[8];
            }
            break;

          case "Vật liệu":
            {
              global.t01.setG1 = value[0];
              global.t01.setG2 = value[1];
              global.t01.setG3 = value[2];
            }
            break;
          case "Lỗi khác":
            {
              global.t01.setH = value[0];
            }
            break;
          default:
        }
      });
      global.t01.calculateValue();
      print('------------ global.t01.calculateValue');
    }
    print("global.t01 : " + global.t01.toString());
    global.t01sLocal.add(global.t01);
    global.t01sFilteredByInspectionSetting.add(global.t01);
    global.t01SummaryByInspectionSetting =
        MyFuntions.t01sSummaryByLastInspectionSetting(
            global.t01sFilteredByInspectionSetting, global.inspectionSetting);
    //save to SqLite
    global.mySqlife.insertIntoTable_T011stInspectionData(global.t01);
    global.mySqlServer
        .updateInspectionDataToT01(global.t01SummaryByInspectionSetting);

    global.comment = '';
  }
}
