import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';
import 'package:tivn_chart/global.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
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

  static Future<void> setVolume(double level) async {
    try {
      await FlutterVolumeController.setMute(false);
      await FlutterVolumeController.setVolume(level);
    } on PlatformException {
      print('setVolume - FlutterVolumeController ERROR');
    }
  }

  static playMedia(String fileName) async {
    String audioAsset = "${fileName}";
    AudioPlayer player = AudioPlayer();
    await setVolume(0.8);
    player.setVolume(1);
    await player.play(AssetSource(audioAsset));
  }

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
}
