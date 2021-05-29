import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';
import 'update_user_data.dart';

class WoinerAccountSelected extends StatefulWidget {
  final int typeUserProfile;

  const WoinerAccountSelected({Key key, this.typeUserProfile}) : super(key: key);


  @override
  WoinerAccountState createState() => WoinerAccountState(
    this.typeUserProfile
  );
}

class WoinerAccountState extends State<WoinerAccountSelected> {
  final int typeUserProfile;

  WoinerAccountState(this.typeUserProfile);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: EdgeInsets.all(
          5.0.w,
        ),
        child: Container(
          padding: EdgeInsets.all(3.0.w),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              typeUserProfile == 0
              ? _selectWoinerTypeTitle(context)
              : SizedBox(),
              _accountTypeCards(context),
              _textAccountType(context),
              _nextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Row _accountTypeCards(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            typeUserProfile == 2
            ? _cliWoinCard(context)
            : SizedBox(),
            typeUserProfile == 3
            ? _enWoinCard(context)
            : SizedBox(),
          ],
        )
      ],
    );
  }

  Container _textAccountType(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 18.0.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              typeUserProfile == 2
                  ? "Usuarios(Woiner) que desean comprar en promoción y ganar puntos para adquirir bienes, productos o servicios."
                  : "Comercios que buscan ser visibles, aumentar sus ventas y fidelizar clientes.",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.02,
                color: Colors.grey[400],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Row _nextButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RaisedButton(
            padding: EdgeInsets.symmetric( vertical: 2.5.h),
            onPressed: () {
              Navigator.push( 
                context, CupertinoPageRoute(
                builder: (context) => 
                  MainDatosWoiner(
                    typeWoiner: typeUserProfile,
                    editmode: typeUserProfile
                  )
                )
              );
            },
            elevation: 0,
            color: Color(0xff1ba6d2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Siguiente',
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                    fontSize: 12.0.sp,
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ],
    );
  }

  Container _cliWoinCard(BuildContext context) {
    return Container(
      width: 70.0.w,
      child: GestureDetector(
        onTap: () => {
          
        },
        child: Card(
          elevation: 3,
          color: typeUserProfile == 2 ? Colors.white : Colors.grey[100],
          child: Padding(
            padding: EdgeInsets.only(
              right: 17,
              left: 17,
              top: 10,
              bottom: 10
            ),
            child: Text(
              "Cliwoin",
              style: TextStyle(
                color: typeUserProfile == 2
                  ? Color(0xff1ba6d2)
                  : Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context)
                      .size
                      .height *
                  0.018
                ),
              textAlign: TextAlign.center,
            ),
          )
        ),
      ),
    );
  }

  Container _enWoinCard(BuildContext context) {
    return Container(
      width: 80.0.w,
      child: GestureDetector(
        onTap: () => {
         
        },
        child: Card(
          elevation: 3,
          color: typeUserProfile == 3 ? Colors.white : Colors.grey[100],
          child: Padding(
            padding: EdgeInsets.only(
              right: 17,
              left: 17,
              top: 10,
              bottom: 10
            ),
            child: Text(
              "Emwoin",
              style: TextStyle(
                color: typeUserProfile == 3
                    ? Color(0xff1ba6d2)
                    : Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context)
                        .size
                        .height *
                    0.018
              ),
              textAlign: TextAlign.center,
            ),
          )
        ),
      ),
    );
  }

  Center _selectWoinerTypeTitle(BuildContext context) {
    return Center(
      child: Text(
        "Seleccione un tipo de woiner a crear",
        style: TextStyle( 
          color: Colors.grey[500],
          fontSize: 12.0.sp
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Tipo woiner",
        style: TextStyle(color: Color(0xff1ba6d2)),
      ),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(
        alignment: Alignment.centerLeft,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.chevron_left,
          size: 30,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
