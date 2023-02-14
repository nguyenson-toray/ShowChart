import 'dart:convert';

import 'package:tivn_chart/dataFuntion/myFuntions.dart';

class LastSetting {
  bool secondary;
  int line;
  String customer;
  String style;
  int styleCode;
  String color;
  String size;
  get getSecondary => this.secondary;

  set setSecondary(secondary) => this.secondary = secondary;
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
  LastSetting({
    this.secondary = false,
    this.line = 1,
    this.customer = 'KASCO',
    this.style = 'KSRWL-002JA',
    this.styleCode = 1,
    this.color = 'LAVENDER',
    this.size = 'XS',
  });

  Map<String, dynamic> toMap() {
    return {
      'inspectionType': secondary,
      'line': line,
      'customer': customer,
      'style': style,
      'styleCode': styleCode,
      'color': color,
      'size': size,
    };
  }

  factory LastSetting.fromMap(Map<String, dynamic> map) {
    return LastSetting(
      secondary: map['inspectionType'],
      line: map['line'].toInt(),
      customer: map['customer'],
      style: map['style'],
      styleCode: map['styleCode'].toInt(),
      color: map['color'],
      size: map['size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LastSetting.fromJson(String source) =>
      LastSetting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LastSetting(secondary : ${secondary.toString()}, line: ${line.toString()}, customer: $customer, style: $style, styleCode: ${styleCode.toString()}, color: $color, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LastSetting &&
        other.secondary == secondary &&
        other.line == line &&
        other.customer == customer &&
        other.style == style &&
        other.styleCode == styleCode &&
        other.color == color &&
        other.size == size;
  }

  @override
  int get hashCode {
    return secondary.hashCode ^
        line.hashCode ^
        customer.hashCode ^
        style.hashCode ^
        styleCode.hashCode ^
        color.hashCode ^
        size.hashCode;
  }
}
