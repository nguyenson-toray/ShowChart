import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tivn_chart/global.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

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
}
