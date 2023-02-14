import 'package:flutter/material.dart';
import 'package:tivn_chart/dataClass/t011stInspectionData.dart';

class ListViewData extends StatefulWidget {
  List<T011stInspectionData> data = [];
  ListViewData({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _ListViewDataState createState() => _ListViewDataState();
}

class _ListViewDataState extends State<ListViewData> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            // margin: EdgeInsets.all(3),
            child: ListTile(
                trailing: Text(widget.data[index].getTime),
                title: widget.data[index].getTotal == 0
                    ? Text("Số lượng : ${widget.data[index].totalChecked} Pcs")
                    : Text("Số lượng : 1 Pcs"),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.data[index].getDefectName),
                    Text(widget.data[index].getXc),
                  ],
                ),
                leading: widget.data[index].getX10 > 0
                    ? CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(
                          'C',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : widget.data[index].getTF == 0
                        // ? Image.asset('asset/check1.png')
                        ? CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            child: Icon(
                              widget.data[index].getIsReCheck
                                  ? Icons.done_all
                                  : Icons.done,
                              color: Colors.black,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.yellowAccent,
                            child: Text(
                              widget.data[index].getIsReCheck ? '!!' : '!',
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
          );
        },
        itemCount: widget.data.length,
      ),
    );
  }
}
