// To parse this JSON data, do
//
//     final T00Month = T00MonthFromJson(jsonString);

import 'dart:convert';

List<T00Month> T00MonthFromJson(String str) =>
    List<T00Month>.from(json.decode(str).map((x) => T00Month.fromJson(x)));

String T00MonthToJson(List<T00Month> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class T00Month {
  int? id;
  int? month;
  T00Month({
    this.id,
    this.month,
  });

  factory T00Month.fromJson(Map<String, dynamic> json) => T00Month(
        id: json["ID"],
        month: json["month"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "month": month,
      };
}
