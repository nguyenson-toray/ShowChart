import 'package:flutter/material.dart';
import 'package:tivn_chart/dataClass/inspectionDetail.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';

class inspectionDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  late var dataGridRows;
  inspectionDataSource({required List<T011stInspectionData> inspectionData}) {
    dataGridRows = inspectionData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'time', value: e.getX02),
              // DataGridCell<String>(
              //     columnName: '1or2', value: e.spectionFirstSecond.toString()),
              // DataGridCell<String>(columnName: 'name', value: e.date),
              // DataGridCell<String>(columnName: 'line', value: e.line),
              // DataGridCell<String>(columnName: 'customer', value: e.customer),
              // DataGridCell<String>(columnName: 'style', value: e.style),
              // DataGridCell<String>(columnName: 'color', value: e.color),
              // DataGridCell<String>(columnName: 'size', value: e.size),
              // DataGridCell<int>(
              //     columnName: 'spectionFirstSecond',
              //     value: e.spectionFirstSecond),
              // DataGridCell<int>(columnName: 'quantity', value: e.quantity),
              DataGridCell<String>(
                  columnName: 'result', value: e.getTF == 0 ? 'ĐẠT' : 'LỖI'),
              // DataGridCell<String>(
              //     columnName: 'groupDefect', value: e.groupDefect),
              // DataGridCell<String>(columnName: 'defect', value: e.defect),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}
