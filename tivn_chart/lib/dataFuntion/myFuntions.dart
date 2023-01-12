import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:tivn_chart/dataBase/MySQLite.dart';
import 'package:tivn_chart/dataClass/InspectionSummaryDay.dart';
import 'package:tivn_chart/global.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:tivn_chart/dataBase/mySqlServer.dart';
import 'package:tivn_chart/dataBase/mySQLite.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class MyFuntions {
  static Future<bool> loginInitData() async {
    var isConnected = await global.mySqlServer.checkConnection();
    if (isConnected)
      await global.mySqlServer.getTable01InspectionData();
    else {
      print("SQL Server not available -Load offline data");
    }

    global.inspectionSummaryDays =
        await global.mySqlife.loadInspectionSummaryDay();

    return true;
  }

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
}
