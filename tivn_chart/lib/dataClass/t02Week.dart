import 'dart:convert';

class T02Week {
  int? week = 999;
  get getWeek => this.week;

  set setWeek(week) => this.week = week;
  T02Week({
    this.week,
  });

  Map<String, dynamic> toMap() {
    return {
      'week': week,
    };
  }

  factory T02Week.fromMap(Map<String, dynamic> map) {
    return T02Week(
      week: map['week']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory T02Week.fromJson(String source) =>
      T02Week.fromMap(json.decode(source));
}
