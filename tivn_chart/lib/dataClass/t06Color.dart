import 'dart:convert';

class T06Color {
  int? ID;
  int? ID2;
  String? X041;
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getID2 => this.ID2;

  set setID2(ID2) => this.ID2 = ID2;

  get getX041 => this.X041;

  set setX041(X041) => this.X041 = X041;
  T06Color({
    this.ID,
    this.ID2,
    this.X041,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'ID2': ID2,
      'X041': X041,
    };
  }

  factory T06Color.fromMap(Map<String, dynamic> map) {
    return T06Color(
      ID: map['ID']?.toInt(),
      ID2: map['ID2']?.toInt(),
      X041: map['X041'],
    );
  }

  String toJson() => json.encode(toMap());

  factory T06Color.fromJson(String source) =>
      T06Color.fromMap(json.decode(source));
}
