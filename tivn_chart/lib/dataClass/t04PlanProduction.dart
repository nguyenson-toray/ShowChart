import 'dart:convert';

class T04PlanProduction {
  int? ID;
  String? X021;
  int? X011;
  int? X13;
  int? T_Year;
  int? T_Month;
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getX021 => this.X021;

  set setX021(X021) => this.X021 = X021;

  get getX011 => this.X011;

  set setX011(X011) => this.X011 = X011;

  get getX13 => this.X13;

  set setX13(X13) => this.X13 = X13;

  get tYear => this.T_Year;

  set tYear(value) => this.T_Year = value;

  get tMonth => this.T_Month;

  set tMonth(value) => this.T_Month = value;
  T04PlanProduction({
    this.ID,
    this.X021,
    this.X011,
    this.X13,
    this.T_Year,
    this.T_Month,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'X021': X021,
      'X011': X011,
      'X13': X13,
      'T-Year': T_Year,
      'T-Month': T_Month,
    };
  }

  factory T04PlanProduction.fromMap(Map<String, dynamic> map) {
    return T04PlanProduction(
      ID: map['ID']?.toInt(),
      X021: map['X021'],
      X011: map['X011']?.toInt(),
      X13: map['X13']?.toInt(),
      T_Year: map['T-Year']?.toInt(),
      T_Month: map['T-Month']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory T04PlanProduction.fromJson(String source) =>
      T04PlanProduction.fromMap(json.decode(source));
}
