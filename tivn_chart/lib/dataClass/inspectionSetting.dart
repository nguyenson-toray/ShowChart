import 'dart:convert';

import 'package:tivn_chart/dataFuntion/myFuntions.dart';

class InspectionSetting {
  int inspectionType;
  int line;
  String customer;
  String style;
  int styleCode;
  String color;
  String size;

  get getInspectionType => this.inspectionType;

  set setInspectionType(inspectionType) => this.inspectionType = inspectionType;

  get getLine => this.line;

  set setLine(currentLine) => this.line = currentLine;

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
  InspectionSetting({
    this.inspectionType = 1,
    this.line = 1,
    this.customer = 'KASCO',
    this.style = 'KSRWL-002JA',
    this.styleCode = 1,
    this.color = 'LAVENDER',
    this.size = 'XS',
  });

  Map<String, dynamic> toMap() {
    return {
      'inspectionType': inspectionType,
      'line': line,
      'customer': customer,
      'style': style,
      'styleCode': styleCode,
      'color': color,
      'size': size,
    };
  }

  factory InspectionSetting.fromMap(Map<String, dynamic> map) {
    return InspectionSetting(
      inspectionType: map['inspectionType']?.toInt() ?? 0,
      line: map['line']?.toInt() ?? 0,
      customer: map['customer'] ?? '',
      style: map['style'] ?? '',
      styleCode: map['styleCode']?.toInt() ?? 0,
      color: map['color'] ?? '',
      size: map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionSetting.fromJson(String source) =>
      InspectionSetting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InspectionSetting(inspectionType: $inspectionType, line: $line, customer: $customer, style: $style, styleCode: $styleCode, color: $color, size: $size)';
  }
}
