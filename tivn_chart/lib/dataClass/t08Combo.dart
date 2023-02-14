import 'dart:convert';

class T08Combo {
  int? ID;
  int? CLine;
  String? Customer;
  int? CYear;
  int? CMonth;
  int? CWeek;
  String? CSize;
  get getID => this.ID;

  set setID(ID) => this.ID = ID;

  get getCLine => this.CLine;

  set setCLine(CLine) => this.CLine = CLine;

  get getCustomer => this.Customer;

  set setCustomer(Customer) => this.Customer = Customer;

  get getCYear => this.CYear;

  set setCYear(CYear) => this.CYear = CYear;

  get getCMonth => this.CMonth;

  set setCMonth(CMonth) => this.CMonth = CMonth;

  get getCWeek => this.CWeek;

  set setCWeek(CWeek) => this.CWeek = CWeek;

  get getCSize => this.CSize;

  set setCSize(CSize) => this.CSize = CSize;
  T08Combo({
    this.ID = 1,
    this.CLine = 1,
    this.Customer = 'KASCO',
    this.CYear = 2022,
    this.CMonth = 1,
    this.CWeek = 1,
    this.CSize = 'XS',
  });

  Map<String, dynamic> toMap() {
    return {
      'ID': ID,
      'C-Line': CLine,
      'Customer': Customer,
      'C-Year': CYear,
      'C-Month': CMonth,
      'C-Week': CWeek,
      'C-Size': CSize,
    };
  }

  factory T08Combo.fromMap(Map<String, dynamic> map) {
    return T08Combo(
      ID: map['ID']?.toInt(),
      CLine: map['C-Line']?.toInt(),
      Customer: map['Customer'],
      CYear: map['C-Year']?.toInt(),
      CMonth: map['C-Month']?.toInt(),
      CWeek: map['C-Week']?.toInt(),
      CSize: map['C-Size'],
    );
  }

  String toJson() => json.encode(toMap());

  factory T08Combo.fromJson(String source) =>
      T08Combo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'T08Combo(ID: $ID, CLine: $CLine, Customer: $Customer, CYear: $CYear, CMonth: $CMonth, CWeek: $CWeek, CSize: $CSize)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is T08Combo &&
        other.ID == ID &&
        other.CLine == CLine &&
        other.Customer == Customer &&
        other.CYear == CYear &&
        other.CMonth == CMonth &&
        other.CWeek == CWeek &&
        other.CSize == CSize;
  }

  @override
  int get hashCode {
    return ID.hashCode ^
        CLine.hashCode ^
        Customer.hashCode ^
        CYear.hashCode ^
        CMonth.hashCode ^
        CWeek.hashCode ^
        CSize.hashCode;
  }
}
