class InspectionChartData {
  DateTime? date;
  int? qty1st;
  int? qty1stOK;
  int? qty1stNOK;
  int? qtyAfterRepaire;
  int? qtyOKAfterRepaire;
  double? rationDefect1st;
  double? rationDefectAfterRepaire;
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
    this.date,
    this.qty1st,
    this.qty1stOK,
    this.qty1stNOK,
    this.qtyAfterRepaire,
    this.qtyOKAfterRepaire,
    this.rationDefect1st,
    this.rationDefectAfterRepaire,
  });
}
