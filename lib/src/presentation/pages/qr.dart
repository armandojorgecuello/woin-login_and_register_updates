import 'dart:typed_data';

import 'package:flutter/material.dart';
//import 'package:qrscan/qrscan.dart' as scanner;


class Qr extends StatefulWidget {
  @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  String barcode = '';
  Uint8List bytes = Uint8List(200);

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Qrcode Scanner Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: 200,
                child: Image.memory(bytes),
              ),
              Text('RESULT  $barcode'),
            ],
          ),
        ),
      ),
    );
  }

}