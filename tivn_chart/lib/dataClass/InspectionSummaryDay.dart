import 'dart:convert';

class InspectionSummaryDay {
  int id;

  String? date;
  int line;
  String? customer;
  String? style;
  int styleCode;
  String? color;
  String? size;
  int planToday;
  int actual;
  int sumDefect;
  double rationDefect;
  get getId => this.id;

  set setId(id) => this.id = id;
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getCustomer => this.customer;

  set setCustomer(customer) => this.customer = customer;

  get getStyle => this.style;

  set setStyle(style) => this.style = style;

  get getStyleCode => this.styleCode;

  set setStyleCode(styleCode) => this.styleCode = styleCode;

  get getColor => this.color;

  set setColor(color) => this.color = color;

  get getSize => this.size;

  set setSize(size) => this.size = size;

  get getplanToday => this.planToday;

  set setplanToday(planToday) => this.planToday = planToday;

  get getActual => this.actual;

  set setActual(actual) => this.actual = actual;

  get getSumDefect => this.sumDefect;

  set setSumDefect(sumDefect) => this.sumDefect = sumDefect;

  get getRationDefect => this.rationDefect;

  set setRationDefect(rationDefect) => this.rationDefect = rationDefect;
  InspectionSummaryDay(
      {this.id = -1,
      this.date = '01-01-2000',
      this.line = 1,
      this.customer = 'KASCO',
      this.style = 'SMR1000-JK02',
      this.styleCode = 0,
      this.color = 'BLUE',
      this.size = 'M',
      this.planToday = 0,
      this.actual = 0,
      this.sumDefect = 0,
      this.rationDefect = 0});
  void increaseGood() {
    actual++;
    rationDefect = sumDefect / actual;
  }

  void increaseDefect() {
    actual++;
    sumDefect++;
    rationDefect = sumDefect / actual;
  }

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'date': date,
      'line': line,
      'customer': customer,
      'style': style,
      'styleCode': styleCode,
      'color': color,
      'size': size,
      'planToday': planToday,
      'actual': actual,
      'sumDefect': sumDefect,
      'rationDefect': rationDefect,
    };
    // map.removeWhere((key, value) => value == null);
    return map;
  }

  factory InspectionSummaryDay.fromMap(Map<String, dynamic> map) {
    return InspectionSummaryDay(
      id: map['id'],
      date: map['date'],
      line: map['line']?.toInt(),
      customer: map['customer'],
      style: map['style'],
      styleCode: map['styleCode']?.toInt(),
      color: map['color'],
      size: map['size'],
      planToday: map['planToday']?.toInt(),
      actual: map['actual']?.toInt(),
      sumDefect: map['sumDefect']?.toInt(),
      rationDefect: map['rationDefect']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionSummaryDay.fromJson(String source) =>
      InspectionSummaryDay.fromMap(json.decode(source));
}
