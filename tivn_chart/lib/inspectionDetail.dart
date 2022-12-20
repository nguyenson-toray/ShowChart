// To parse this JSON data, do
//
//     final inspectionDetail = inspectionDetailFromJson(jsonString);

import 'dart:convert';

List<InspectionDetail> inspectionDetailFromJson(String str) =>
    List<InspectionDetail>.from(
        json.decode(str).map((x) => InspectionDetail.fromJson(x)));

String inspectionDetailToJson(List<InspectionDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InspectionDetail {
  InspectionDetail({
    this.time,
    this.date,
    this.line,
    this.customer,
    this.style,
    this.color,
    this.size,
    this.spectionFirstSecond,
    this.quantity,
    this.result,
    this.groupDefect,
    this.defect,
  });

  String? time;
  String? date;
  String? line;
  String? customer;
  String? style;
  String? color;
  String? size;
  int? spectionFirstSecond;
  int? quantity;
  String? result;
  String? groupDefect;
  String? defect;
  String? get gettime => this.time;

  set setTime(String? time) => this.time = time;

  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getLine => this.line;

  set setLine(line) => this.line = line;

  get getCustomer => this.customer;

  set setCustomer(customer) => this.customer = customer;

  get getStyle => this.style;

  set setStyle(style) => this.style = style;

  get getColor => this.color;

  set setColor(color) => this.color = color;

  get getSize => this.size;

  set setSize(size) => this.size = size;

  get getSpectionFirstSecond => this.spectionFirstSecond;

  set setSpectionFirstSecond(spectionFirstSecond) =>
      this.spectionFirstSecond = spectionFirstSecond;

  get getQuantity => this.quantity;

  set setQuantity(quantity) => this.quantity = quantity;

  get getResult => this.result;

  set setResult(result) => this.result = result;

  get getGroupDefect => this.groupDefect;

  set setGroupDefect(groupDefect) => this.groupDefect = groupDefect;

  get getDefect => this.defect;

  set setDefect(defect) => this.defect = defect;

  factory InspectionDetail.fromJson(Map<String, dynamic> json) =>
      InspectionDetail(
        time: json["time"],
        date: json["date"],
        line: json["line"],
        customer: json["customer"],
        style: json["style"],
        color: json["color"],
        size: json["size"],
        spectionFirstSecond: json["spectionFirstSecond"],
        quantity: json["quantity"],
        result: json["result"],
        groupDefect: json["groupDefect"],
        defect: json["defect"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "date": date,
        "line": line,
        "customer": customer,
        "style": style,
        "color": color,
        "size": size,
        "spectionFirstSecond": spectionFirstSecond,
        "quantity": quantity,
        "result": result,
        "groupDefect": groupDefect,
        "defect": defect,
      };
}
