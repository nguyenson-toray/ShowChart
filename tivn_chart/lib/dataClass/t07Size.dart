import 'dart:convert';

class T07Size {
  int? ID;
  String? Size;
  T07Size({
    this.ID,
    this.Size,
  });
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getSize => this.Size;

  set setSize(Size) => this.Size = Size;

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'Size': Size,
    };
  }

  factory T07Size.fromMap(Map<String, dynamic> map) {
    return T07Size(
      ID: map['ID']?.toInt(),
      Size: map['Size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory T07Size.fromJson(String source) =>
      T07Size.fromMap(json.decode(source));
}
