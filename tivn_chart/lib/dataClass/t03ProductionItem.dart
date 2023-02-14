import 'dart:convert';

class T03ProductionItem {
  int? ID;
  int? ID1;
  String? X151;
  String? X131;
  String? x18;
  String? X19;
  int? X20;
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getID1 => this.ID1;

  set setID1(ID1) => this.ID1 = ID1;

  get getX151 => this.X151;

  set setX151(X151) => this.X151 = X151;

  get getX131 => this.X131;

  set setX131(X131) => this.X131 = X131;

  get getx18 => this.x18;

  set setx18(x18) => this.x18 = x18;

  get getX19 => this.X19;

  set setX19(X19) => this.X19 = X19;

  get getX20 => this.X20;

  set setX20(X20) => this.X20 = X20;
  T03ProductionItem({
    this.ID,
    this.ID1,
    this.X151,
    this.X131,
    this.x18,
    this.X19,
    this.X20,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'ID1': ID1,
      'X151': X151,
      'X131': X131,
      'x18': x18,
      'X19': X19,
      'X20': X20,
    };
  }

  factory T03ProductionItem.fromMap(Map<String, dynamic> map) {
    return T03ProductionItem(
      ID: map['ID']?.toInt(),
      ID1: map['ID1']?.toInt(),
      X151: map['X151'],
      X131: map['X131'],
      x18: map['x18'],
      X19: map['X19'],
      X20: map['X20']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory T03ProductionItem.fromJson(String source) =>
      T03ProductionItem.fromMap(json.decode(source));
}
