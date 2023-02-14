import 'dart:convert';

class T05MainPowerSewingTime {
  int? ID;
  int? X01;
  String? X02;
  int? Mplan;
  int? Mact;
  int? Madd;
  int? OVT;
  int? X21;
  int? A_Month;
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getX01 => this.X01;

  set setX01(X01) => this.X01 = X01;

  get getX02 => this.X02;

  set setX02(X02) => this.X02 = X02;

  get getMplan => this.Mplan;

  set setMplan(Mplan) => this.Mplan = Mplan;

  get getMact => this.Mact;

  set setMact(Mact) => this.Mact = Mact;

  get getMadd => this.Madd;

  set setMadd(Madd) => this.Madd = Madd;

  get getOVT => this.OVT;

  set setOVT(OVT) => this.OVT = OVT;

  get getX21 => this.X21;

  set setX21(X21) => this.X21 = X21;

  get aMonth => this.A_Month;

  set aMonth(value) => this.A_Month = value;
  int? A_Year;
  T05MainPowerSewingTime({
    this.ID,
    this.X01,
    this.X02,
    this.Mplan,
    this.Mact,
    this.Madd,
    this.OVT,
    this.X21,
    this.A_Month,
    this.A_Year,
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'X01': X01,
      'X02': X02,
      'Mplan': Mplan,
      'Mact': Mact,
      'Madd': Madd,
      'OVT': OVT,
      'X21': X21,
      'A-Month': A_Month,
      'A-Year': A_Year,
    };
  }

  factory T05MainPowerSewingTime.fromMap(Map<String, dynamic> map) {
    return T05MainPowerSewingTime(
      ID: map['ID']?.toInt(),
      X01: map['X01']?.toInt(),
      X02: map['X02'],
      Mplan: map['Mplan']?.toInt(),
      Mact: map['Mact']?.toInt(),
      Madd: map['Madd']?.toInt(),
      OVT: map['OVT']?.toInt(),
      X21: map['X21']?.toInt(),
      A_Month: map['A-Month']?.toInt(),
      A_Year: map['A-Year']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory T05MainPowerSewingTime.fromJson(String source) =>
      T05MainPowerSewingTime.fromMap(json.decode(source));
}
