// To parse this JSON data, do
//
//     final T00Trans = T00TransFromJson(jsonString);

import 'dart:convert';

List<T00Trans> T00TransFromJson(String str) =>
    List<T00Trans>.from(json.decode(str).map((x) => T00Trans.fromJson(x)));

String T00TransToJson(List<T00Trans> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class T00Trans {
  T00Trans({
    required this.codeSmall,
    required this.japanLarge,
    required this.vietLarge,
    required this.jpanSmall,
    required this.vietSmall,
  });

  String codeSmall;
  String japanLarge;
  String vietLarge;
  String jpanSmall;
  String vietSmall;

  factory T00Trans.fromJson(Map<String, dynamic> json) => T00Trans(
        codeSmall: json["codeSmall"],
        japanLarge: json["japanLarge"],
        vietLarge: json["VietLarge"],
        jpanSmall: json["jpanSmall"],
        vietSmall: json["vietSmall"],
      );

  Map<String, dynamic> toJson() => {
        "codeSmall": codeSmall,
        "japanLarge": japanLarge,
        "VietLarge": vietLarge,
        "jpanSmall": jpanSmall,
        "vietSmall": vietSmall,
      };
}
