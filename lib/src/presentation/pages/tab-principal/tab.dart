import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:kf_drawer/kf_drawer.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:woin/src/entities/Promocion/filterPromociondet.dart';
import 'package:woin/src/entities/subcategorias/subcategorias.dart';
import 'package:woin/src/presentation/pages/Comercios/Comercio.dart';
import 'package:woin/src/presentation/pages/Movements/movements.dart';
import 'package:woin/src/presentation/pages/Promociones/promo_page.dart';
import 'package:woin/src/presentation/pages/Transporte/Transporte.dart';
import 'package:woin/src/presentation/pages/drawer2.dart';

import 'package:woin/src/presentation/pages/principal/card_swiper.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woin/src/presentation/pages/transactions/transactionsMain.dart';

class TabMain extends KFDrawerContent {
  // Tabs({Key key}) : super(key: key);
  int index;
  bool filtercats;
  bool filtermode;
  bool filterprom;
  List<Subcategoria> list;
  filterPromociondet filterAplicados;
  TabMain({this.index=-1,this.filtercats=false,this.filtermode=false,this.filterprom=false,this.list,this.filterAplicados=null});

  @override
  _TabMainState createState() => _TabMainState();
}

class _TabMainState extends State<TabMain> {

  int silver=0;
  GlobalKey<TransaccionesMainState > _keyChild1;
  GlobalKey<MovementsState> _keyMovements;
  int pageIndex = 2;
  String title = 'Woin';
  bool fabOpen = false;
  Widget _showPage ;
  bool pressfilter=false;


  limpiarfiltros(){
    this.widget.filtermode=false;
    this.widget.filterprom=false;
    this.widget.filtercats=false;

  }

  Widget _pages(int page) {
    switch (page) {
      case 0:
        pressfilter=false;
       // return TransaccionesMain(key: _keyChild1,);
        return PromoPage();
        break;
      case 1:
        limpiarfiltros();
        title = 'Comercios';
        pressfilter=false;
        return Comercio();
        break;
      case 2:
        limpiarfiltros();
        title = 'Woin';
        pressfilter=false;
        return CardSwiper();
        break;
      case 3:
        limpiarfiltros();
        title = 'Transporte';
        pressfilter=false;
        return Transporte();
        break;
      case 4:
        limpiarfiltros();
        title = 'Movimientos';
        pressfilter=false;
        return Movements(key: _keyMovements,);
        break;
      default:
    }
    setState(() {});
  }

  GlobalKey _bottomNavigationKey ;

  @override
  void initState() {

    super.initState();
    print(widget.list);
    pageIndex=widget.index>-1?widget.index:2;
    silver=widget.index>-1?1:0;
    _showPage=_pages(pageIndex);
    _keyChild1=GlobalKey();
    _bottomNavigationKey =GlobalKey();
    _keyMovements= GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    void abrirDrawer(){
      _scaffoldKey.currentState.openDrawer();
    }
    return WillPopScope(
      onWillPop: () async{
        if(pageIndex!=2){
          setState(() {
            pageIndex=2;
            _showPage=_pages(pageIndex);
            silver=0;
            //return Future.value(false);
          });
          return Future.value(false);
        }else{
          return Future.value(true);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        drawer: Drawermenu(),
        appBar: silver==0 ? _appBar() : null,
        bottomNavigationBar: _navigationBar(),
        body:Container(
          height: 50.0.h,
          width: 50.0.w,
          color: Colors.red,
        )
      )
    );
  }

  CurvedNavigationBar _navigationBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: pageIndex,
      height: 10.0.h,
      items: <Widget>[
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Icon(
               Icons.label_outline,
               size: 25,
               color: pageIndex == 0 ? Colors.white : Colors.grey[400],
             ),
            pageIndex != 0 ? Text(
              "Promociones",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,

              )
              :SizedBox()
           ],
         ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            LineAwesomeIcons.map_marker,
            size: 25,
            color: pageIndex == 1 ? Colors.white : Colors.grey[400],
          ),
          pageIndex != 1 ? Text(
            "Comercios",
            style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
          ):SizedBox()
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
          ):SizedBox()
        ],
      ),
       Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Icon(
             Icons.local_shipping,
             size: 25,
             color: pageIndex == 3 ? Colors.white : Colors.grey[400],
           ),
          pageIndex != 3 ? Text(
            "Domicilios",
            style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
            textScaleFactor: 1.0,
            ):SizedBox()
         ],
       ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              LineAwesomeIcons.bar_chart_o,
              size: 25,
              color: pageIndex == 4 ? Colors.white : Colors.grey[400],
            ),
            pageIndex != 4 ? Text(
              "Movimientos",
              style: TextStyle(fontSize: 10.0.sp,color:Colors.grey[400],fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ):SizedBox()
          ],
        )
      ],
      color: Colors.white,
      buttonBackgroundColor: Color(0xff1ba6d2),
      backgroundColor: Colors.transparent ,
      animationCurve: Curves.easeIn,
      animationDuration: Duration(milliseconds: 300),
      onTap: (index) {
        setState(() {
          pageIndex = index;
          if(index==0){
            silver=1;
          }else{
            silver=0;
            _showPage = _pages(index);
          }

        });
      },

    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.light,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: "Arial-Rounded",
          color: Color(0xff1ba6d2),
          letterSpacing: .5,
          fontWeight: FontWeight.bold,
          fontSize: pageIndex == 2 ? 25.0 : 17
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) => InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          splashColor: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: IconButton(
            onPressed: null,
            alignment: Alignment.centerLeft,
            icon: Icon(
              LineIcons.bars,
              color: Colors.grey[400],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        pageIndex == 0
        ? Builder(
            builder: (context) => InkWell(
              onTap: () {
              },
              splashColor: Colors.grey[100],
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: IconButton(
                onPressed: (){
                  _keyChild1.currentState.limpiarMontoUser();
                },
                alignment: Alignment.center,
                icon: Icon(
                  Icons.cancel,
                  color: Color.fromRGBO(214, 214, 214, 1),
                  size: 25,
                ),
              ),
            ),
          )
        : SizedBox(),
        pageIndex == 2
        ? Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                LineIcons.bell,
                color: Colors.grey[400],
              ),
              iconSize: 28.0,
              onPressed: () {},
            );
          })
        : SizedBox(),
        pageIndex == 2
        ? Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerRight,
              icon: Icon(
                LineIcons.users,
                color: Colors.grey[400],
              ),
              iconSize: 28.0,
              onPressed: () {},
            );
          })
        : SizedBox(),
        pageIndex==4?
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.only(left: 12, right: 12),
              alignment: Alignment.centerRight,
              icon: Icon(
              Icons.filter_list,
              color: pressfilter?Color(0xff1ba6d2):Colors.grey[400],
              ),
              iconSize: 28.0,
              onPressed: () {
                _keyMovements.currentState.filterFecha();

                pressfilter=_keyMovements.currentState.stateFilteredFecha();
                setState(() {

                });

              },
            );
          }
        )
      : SizedBox(),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


}
