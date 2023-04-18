import 'package:flutter/material.dart';
    
class ErrorPage extends StatelessWidget {

  ErrorPage({ Key? key }) : super(key: key);
  String errorInfo='''Please press BACK button on remote control to exit app,check wifi connection setting of TV, and then open app again !
  Vui lòng bấm nút BACK trên điều khiển từ xa để thoát ứng dụng, kiểm tra cài đặt kết nối wifi của thiết bị, sau đó mở lại ứng dụng !''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('CONNECTION ERROR - LỖI KẾT NỐI'),
      ),
    body: Container(child: Row(children: [
        Text(errorInfo,style: TextStyle(fontSize: 15),),Image.asset('assets/no-wifi.png')
      ],),),
    );
  }
}