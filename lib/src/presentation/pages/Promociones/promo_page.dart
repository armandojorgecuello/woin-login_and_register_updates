import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/widgets/swipers.dart';

class PromoPage extends StatefulWidget {
  @override
  _PromoPageState createState() => _PromoPageState();
}

class _PromoPageState extends State<PromoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body()
    );
  }

  _body(){
    return Container(
      height: 100.0.h,
      width:100.0.w,
      child:Column(
        children: [
          SwipersCard()
        ],
      )
    );
  }


}