import 'dart:convert';

class InspectionDetail {
  String? time;
  String? date;
  int? line;
  String? customer;
  String? style;
  int? styleCode;
  String? color;
  String? size;
  int? spectionFirstSecond;
  int? quantity;
  String? result;
  String? groupDefect;
  String? defect;
  String? comment;

  get getComment => this.comment;
  set setComment(comment) => this.comment = comment;
  get getTime => this.time;

  set setTime(time) => this.time = time;

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
  InspectionDetail({
    this.time,
    this.date,
    this.line,
    this.customer,
    this.style,
    this.styleCode,
    this.color,
    this.size,
    this.spectionFirstSecond,
    this.quantity,
    this.result,
    this.groupDefect,
    this.defect,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'date': date,
      'line': line,
      'customer': customer,
      'style': style,
      'styleCode': styleCode,
      'color': color,
      'size': size,
      'spectionFirstSecond': spectionFirstSecond,
      'quantity': quantity,
      'result': result,
      'groupDefect': groupDefect,
      'defect': defect,
      'comment': comment,
    };
  }

  factory InspectionDetail.fromMap(Map<String, dynamic> map) {
    return InspectionDetail(
      time: map['time'],
      date: map['date'],
      line: map['line']?.toInt(),
      customer: map['customer'],
      style: map['style'],
      styleCode: map['styleCode']?.toInt(),
      color: map['color'],
      size: map['size'],
      spectionFirstSecond: map['spectionFirstSecond']?.toInt(),
      quantity: map['quantity']?.toInt(),
      result: map['result'],
      groupDefect: map['groupDefect'],
      defect: map['defect'],
      comment: map['comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InspectionDetail.fromJson(String source) =>
      InspectionDetail.fromMap(json.decode(source));
}
