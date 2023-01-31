import 'dart:convert';

class T011stInspectionData {
  int? id;
  int? secondary;
  int? x01;
  String? x02;
  int? x03;
  String? x04;
  String? x05;
  int? x06;
  int? x07;
  int? x08;
  int? x09;
  int? x10;
  int? a1;
  int? a2;
  int? a3;
  int? b1;
  int? b2;
  int? b3;
  int? c1;
  int? c2;
  int? c3;
  int? d1;
  int? d2;
  int? d3;
  int? d4;
  int? e1;
  int? e2;
  int? e3;
  int? e4;
  int? e5;
  int? e6;
  int? e7;
  int? f1;
  int? f2;
  int? f3;
  int? f4;
  int? f5;
  int? f6;
  int? f7;
  int? f8;
  int? f9;
  int? g1;
  int? g2;
  int? g3;
  int? h;
  String? xc;
  int? sumA;
  int? sumB;
  int? sumC;
  int? sumD;
  int? sumE;
  int? sumF;
  int? sumG;
  int? sumH;
  int? total;
  int? x11;
  int? x12;
  int? tMonth;
  int? tYear;
  int? tF;
  int? get getId => this.id;

  set setId(id) => this.id = id;
  get getSecondary => this.secondary;

  set setSecondary(secondary) => this.secondary = secondary;

  get getX01 => this.x01;

  set setX01(x01) => this.x01 = x01;

  get getX02 => this.x02;

  set setX02(x02) => this.x02 = x02;

  get getX03 => this.x03;

  set setX03(x03) => this.x03 = x03;

  get getX04 => this.x04;

  set setX04(x04) => this.x04 = x04;

  get getX05 => this.x05;

  set setX05(x05) => this.x05 = x05;

  get getX06 => this.x06;

  set setX06(x06) => this.x06 = x06;

  get getX07 => this.x07;

  set setX07(x07) => this.x07 = x07;

  get getX08 => this.x08;

  set setX08(x08) => this.x08 = x08;

  get getX09 => this.x09;

  set setX09(x09) => this.x09 = x09;

  get getX10 => this.x10;

  set setX10(x10) => this.x10 = x10;

  get getA1 => this.a1;

  set setA1(a1) => this.a1 = a1;

  get getA2 => this.a2;

  set setA2(a2) => this.a2 = a2;

  get getA3 => this.a3;

  set setA3(a3) => this.a3 = a3;

  get getB1 => this.b1;

  set setB1(b1) => this.b1 = b1;

  get getB2 => this.b2;

  set setB2(b2) => this.b2 = b2;

  get getB3 => this.b3;

  set setB3(b3) => this.b3 = b3;

  get getC1 => this.c1;

  set setC1(c1) => this.c1 = c1;

  get getC2 => this.c2;

  set setC2(c2) => this.c2 = c2;

  get getC3 => this.c3;

  set setC3(c3) => this.c3 = c3;

  get getD1 => this.d1;

  set setD1(d1) => this.d1 = d1;

  get getD2 => this.d2;

  set setD2(d2) => this.d2 = d2;

  get getD3 => this.d3;

  set setD3(d3) => this.d3 = d3;

  get getD4 => this.d4;

  set setD4(d4) => this.d4 = d4;

  get getE1 => this.e1;

  set setE1(e1) => this.e1 = e1;

  get getE2 => this.e2;

  set setE2(e2) => this.e2 = e2;

  get getE3 => this.e3;

  set setE3(e3) => this.e3 = e3;

  get getE4 => this.e4;

  set setE4(e4) => this.e4 = e4;

  get getE5 => this.e5;

  set setE5(e5) => this.e5 = e5;

  get getE6 => this.e6;

  set setE6(e6) => this.e6 = e6;

  get getE7 => this.e7;

  set setE7(e7) => this.e7 = e7;

  get getF1 => this.f1;

  set setF1(f1) => this.f1 = f1;

  get getF2 => this.f2;

  set setF2(f2) => this.f2 = f2;

  get getF3 => this.f3;

  set setF3(f3) => this.f3 = f3;

  get getF4 => this.f4;

  set setF4(f4) => this.f4 = f4;

  get getF5 => this.f5;

  set setF5(f5) => this.f5 = f5;

  get getF6 => this.f6;

  set setF6(f6) => this.f6 = f6;

  get getF7 => this.f7;

  set setF7(f7) => this.f7 = f7;

  get getF8 => this.f8;

  set setF8(f8) => this.f8 = f8;

  get getF9 => this.f9;

  set setF9(f9) => this.f9 = f9;

  get getG1 => this.g1;

  set setG1(g1) => this.g1 = g1;

  get getG2 => this.g2;

  set setG2(g2) => this.g2 = g2;

  get getG3 => this.g3;

  set setG3(g3) => this.g3 = g3;

  get getH => this.h;

  set setH(h) => this.h = h;

  get getXc => this.xc;

  set setXc(xc) => this.xc = xc;

  get getSumA => this.sumA;

  set setSumA(sumA) => this.sumA = sumA;

  get getSumB => this.sumB;

  set setSumB(sumB) => this.sumB = sumB;

  get getSumC => this.sumC;

  set setSumC(sumC) => this.sumC = sumC;

  get getSumD => this.sumD;

  set setSumD(sumD) => this.sumD = sumD;

  get getSumE => this.sumE;

  set setSumE(sumE) => this.sumE = sumE;

  get getSumF => this.sumF;

  set setSumF(sumF) => this.sumF = sumF;

  get getSumG => this.sumG;

  set setSumG(sumG) => this.sumG = sumG;

  get getSumH => this.sumH;

  set setSumH(sumH) => this.sumH = sumH;

  get getTotal => this.total;

  set setTotal(total) => this.total = total;

  get getX11 => this.x11;

  set setX11(x11) => this.x11 = x11;

  get getX12 => this.x12;

  set setX12(x12) => this.x12 = x12;

  get getTMonth => this.tMonth;

  set setTMonth(tMonth) => this.tMonth = tMonth;

  get getTYear => this.tYear;

  set setTYear(tYear) => this.tYear = tYear;

  get getTF => this.tF;

  set setTF(tF) => this.tF = tF;
  T011stInspectionData({
    this.id,
    this.secondary,
    this.x01,
    this.x02,
    this.x03,
    this.x04,
    this.x05,
    this.x06,
    this.x07,
    this.x08,
    this.x09,
    this.x10,
    this.a1,
    this.a2,
    this.a3,
    this.b1,
    this.b2,
    this.b3,
    this.c1,
    this.c2,
    this.c3,
    this.d1,
    this.d2,
    this.d3,
    this.d4,
    this.e1,
    this.e2,
    this.e3,
    this.e4,
    this.e5,
    this.e6,
    this.e7,
    this.f1,
    this.f2,
    this.f3,
    this.f4,
    this.f5,
    this.f6,
    this.f7,
    this.f8,
    this.f9,
    this.g1,
    this.g2,
    this.g3,
    this.h,
    this.xc,
    this.sumA,
    this.sumB,
    this.sumC,
    this.sumD,
    this.sumE,
    this.sumF,
    this.sumG,
    this.sumH,
    this.total,
    this.x11,
    this.x12,
    this.tMonth,
    this.tYear,
    this.tF,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      '2nd': secondary,
      'x01': x01,
      'x02': x02,
      'x03': x03,
      'x04': x04,
      'x05': x05,
      'x06': x06,
      'x07': x07,
      'x08': x08,
      'x09': x09,
      'x10': x10,
      'a1': a1,
      'a2': a2,
      'a3': a3,
      'b1': b1,
      'b2': b2,
      'b3': b3,
      'c1': c1,
      'c2': c2,
      'c3': c3,
      'd1': d1,
      'd2': d2,
      'd3': d3,
      'd4': d4,
      'e1': e1,
      'e2': e2,
      'e3': e3,
      'e4': e4,
      'e5': e5,
      'e6': e6,
      'e7': e7,
      'f1': f1,
      'f2': f2,
      'f3': f3,
      'f4': f4,
      'f5': f5,
      'f6': f6,
      'f7': f7,
      'f8': f8,
      'f9': f9,
      'g1': g1,
      'g2': g2,
      'g3': g3,
      'h': h,
      'xc': xc,
      'sumA': sumA,
      'sumB': sumB,
      'sumC': sumC,
      'sumD': sumD,
      'sumE': sumE,
      'sumF': sumF,
      'sumG': sumG,
      'sumH': sumH,
      'total': total,
      'x11': x11,
      'x12': x12,
      'tMonth': tMonth,
      'tYear': tYear,
      'tF': tF,
    };
  }

  factory T011stInspectionData.fromMap(Map<String, dynamic> map) {
    var result = T011stInspectionData(
      id: map['ID']?.toInt(),
      secondary: map['2nd']?.toInt(), //.bool(),
      x01: map['X01']?.toInt(),
      x02: map['X02'],
      x03: map['X03']?.toInt(),
      x04: map['X04'],
      x05: map['X05'],
      x06: map['X06']?.toInt(),
      x07: map['X07']?.toInt(),
      x08: map['X08']?.toInt(),
      x09: map['X09']?.toInt(),
      x10: map['X10']?.toInt(),
      a1: map['A1']?.toInt(),
      a2: map['A2']?.toInt(),
      a3: map['A3']?.toInt(),
      b1: map['B1']?.toInt(),
      b2: map['B2']?.toInt(),
      b3: map['B3']?.toInt(),
      c1: map['C1']?.toInt(),
      c2: map['C2']?.toInt(),
      c3: map['C3']?.toInt(),
      d1: map['D1']?.toInt(),
      d2: map['D2']?.toInt(),
      d3: map['D3']?.toInt(),
      d4: map['D4']?.toInt(),
      e1: map['E1']?.toInt(),
      e2: map['E2']?.toInt(),
      e3: map['E3']?.toInt(),
      e4: map['E4']?.toInt(),
      e5: map['E5']?.toInt(),
      e6: map['E6']?.toInt(),
      e7: map['E7']?.toInt(),
      f1: map['F1']?.toInt(),
      f2: map['F2']?.toInt(),
      f3: map['F3']?.toInt(),
      f4: map['F4']?.toInt(),
      f5: map['F5']?.toInt(),
      f6: map['F6']?.toInt(),
      f7: map['F7']?.toInt(),
      f8: map['F8']?.toInt(),
      f9: map['F9']?.toInt(),
      g1: map['G1']?.toInt(),
      g2: map['G2']?.toInt(),
      g3: map['G3']?.toInt(),
      h: map['H']?.toInt(),
      xc: map['XC'],
      sumA: map['Sum A']?.toInt(),
      sumB: map['Sum B']?.toInt(),
      sumC: map['Sum C']?.toInt(),
      sumD: map['Sum D']?.toInt(),
      sumE: map['Sum E']?.toInt(),
      sumF: map['Sum F']?.toInt(),
      sumG: map['Sum G']?.toInt(),
      sumH: map['Sum H']?.toInt(),
      total: map['Total']?.toInt(),
      x11: map['X11']?.toInt(),
      x12: map['X12']?.toInt(),
      tMonth: map['T-Month']?.toInt(),
      tYear: map['T-Year']?.toInt(),
      tF: map['TF']?.toInt(),
    );
    return result;
  }

  String toJson() => json.encode(toMap());

  factory T011stInspectionData.fromJson(String source) =>
      T011stInspectionData.fromMap(json.decode(source));
  static bool intToBool(int input) {
    if (input > 0)
      return true;
    else
      return false;
  }
}
