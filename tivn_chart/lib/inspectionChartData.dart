import 'package:intl/intl.dart';

class InspectionChartData {
  DateTime date;
  num qty1st;
  num qty1stOK;
  num qty1stNOK;
  num qtyAfterRepaire;
  num qtyOKAfterRepaire;
  num rationDefect1st;
  num rationDefectAfterRepaire;
  get getDate => this.date;

  set setDate(date) => this.date = date;

  get getQty1st => this.qty1st;

  set setQty1st(qty1st) => this.qty1st = qty1st;

  get getQty1stOK => this.qty1stOK;

  set setQty1stOK(qty1stOK) => this.qty1stOK = qty1stOK;

  get getQty1stNOK => this.qty1stNOK;

  set setQty1stNOK(qty1stNOK) => this.qty1stNOK = qty1stNOK;

  get getQtyAfterRepaire => this.qtyAfterRepaire;

  set setQtyAfterRepaire(qtyAfterRepaire) =>
      this.qtyAfterRepaire = qtyAfterRepaire;

  get getQtyOKAfterRepaire => this.qtyOKAfterRepaire;

  set setQtyOKAfterRepaire(qtyOKAfterRepaire) =>
      this.qtyOKAfterRepaire = qtyOKAfterRepaire;

  get getRationDefect1st => this.rationDefect1st;

  set setRationDefect1st(rationDefect1st) =>
      this.rationDefect1st = rationDefect1st;

  get getRationDefectAfterRepaire => this.rationDefectAfterRepaire;

  set setRationDefectAfterRepaire(rationDefectAfterRepaire) =>
      this.rationDefectAfterRepaire = rationDefectAfterRepaire;

  InspectionChartData({
    required this.date,
    this.qty1st = 0,
    this.qty1stOK = 0,
    this.qty1stNOK = 0,
    this.qtyAfterRepaire = 0,
    this.qtyOKAfterRepaire = 0,
    this.rationDefect1st = 0,
    this.rationDefectAfterRepaire = 0,
  });
}
