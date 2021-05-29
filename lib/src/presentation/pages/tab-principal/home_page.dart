import 'dart:convert';

import 'package:flutter/material.dart';



import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/woiner_data_model.dart';
import 'package:woin/src/presentation/pages/Comercios/Comercio.dart';


import 'package:woin/src/presentation/pages/Movements/movements.dart';
import 'package:woin/src/presentation/pages/Promociones/promo_page.dart';
import 'package:woin/src/presentation/pages/Transporte/Transporte.dart';
import 'package:woin/src/presentation/pages/principal/card_swiper.dart';
import 'package:woin/src/presentation/pages/transactions/steps/typeTransactions.dart';
import 'package:woin/src/providers/current_account_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/providers/user_service.dart';
import '../drawer2.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<MovementsState> _keyMovements;
  
  GlobalKey _bottomNavigationKey;
  int pageIndex = 2;

  Widget _pages(){
    if(pageIndex == 0){
      return typeTransactions();
    }else if(pageIndex == 1){
      return Movements(key: _keyMovements,); 
    }else if(pageIndex == 2){
      return CardSwiper();
    }else if(pageIndex == 3){
      return Comercio();
    }else if(pageIndex == 4){
      return  PromoPage(); 
    }else{
      return Container();
    }
  }

  String _titleAppBar(){
    if(pageIndex == 0){
      return "Transferir";
    }else if(pageIndex == 1){
      return "Movimientos";
    }else if(pageIndex == 2){
      return "Woin";
    }else if(pageIndex == 3){
      return "Emwoiners";
    }else if(pageIndex == 4){
      return "Promociones";
    }else{
      return "Container()";
    }
  }


  @override
  void initState() { 
    super.initState(); 
  }

  getUserData(context, int typeDefaultAccount, String token )async{
    if(typeDefaultAccount == 0){

    }else{
      var userData = await userService.dataWoiner(typeDefaultAccount, token,);
      var responseJson = json.decode(userData.body);
      List entities = responseJson["entities"];
      Woiner woinerData;
      entities.forEach((element) { 
        Map<dynamic, dynamic> woinData = Map.from(element);
        woinerData = Woiner.fromJson(woinData); 
        Provider.of<CurrentAccount>(context, listen:false).woiner = woinerData;
    });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    UserDetailResponse userDetail = Provider.of<LoginProvider>(context, listen:false).userDetail;
    getUserData(context, userDetail.typeDefault, userDetail.token);
    return WillPopScope(
      onWillPop:  () { 
        return Future.value(false);
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: Drawermenu(),
        appBar: _appBar(),
        bottomNavigationBar: _navigationBar(),
        body: Container(
          height: 100.0.h,
          width: 100.0.w,
          child: _pages(),
        ),
      ), 
    );
  }

  AppBar _appBar() => AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    title:Text(_titleAppBar(), style:TextStyle( color:Color(0xff4ab8db), fontSize:15.0.sp)),
    leading: IconButton(
      icon:Icon(Icons.menu, color:Colors.grey),
      onPressed: (){
        _scaffoldKey.currentState.openDrawer();
      },
      color: Colors.white,
    ),
  );

  
  CurvedNavigationBar _navigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: pageIndex,
      height: 50,
      items: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.compare_arrows,
              size: 25,
              color: pageIndex == 0 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 0 ? Text(
              "Trasnferir",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ): Container()
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              LineAwesomeIcons.bar_chart_o,
              size: 25,
              color: pageIndex == 1 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 1 ? Text(
              "Movimientos",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ) : Container()
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              LineAwesomeIcons.home,
              size: 25,
              color: pageIndex == 2 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 2 ? Text(
              "Inicio",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ) : Container()
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              LineAwesomeIcons.map_marker,
              size: 25,
              color: pageIndex == 3 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 3 ? Text(
              "Emwoiners",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ) : Container()
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.label_outline,
              size: 25,
              color: pageIndex == 4 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 4 ? Text(
              "Promociones",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ):Container()
          ],
        )
      ],
      color: Colors.grey[50],
      buttonBackgroundColor: Color(0xff1ba6d2),
      backgroundColor: Colors.transparent ,
      animationCurve: Curves.easeIn,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
    );
  }



}