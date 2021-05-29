import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/models/add_model.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/woiner_data_model.dart';
import 'package:woin/src/presentation/mainTabs/CardsProductView.dart';
import 'package:woin/src/presentation/pages/QR_code/QR_woiner.dart';
import 'package:woin/src/presentation/pages/transactions/steps/typeTransactions.dart';
import 'package:woin/src/presentation/pages/usuario/how_earn_points_woin.dart';
import 'package:woin/src/presentation/pages/usuario/register_user/user_register.dart';
import 'package:woin/src/presentation/widgets/cardWoin.dart';
import 'package:woin/src/providers/add_providers.dart';
import 'package:woin/src/providers/current_account_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/services/ServiceWallet/ServiceWallet.dart';



  CurrentAccount sesion;


class CardSwiper extends StatefulWidget {
  CardSwiper({Key key}):super(key:UniqueKey());




  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  WalletService ws;
  userdetalle sesion;
  Utilities utils;

  @override
  void initState() {
    ws= WalletService();
    sesion = new userdetalle();
    utils =Utilities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _body()
      )
    );
  }

  _body(){
    Woiner woiner =  Provider.of<CurrentAccount>(context).woiner;
    UserDetailResponse userDetail = Provider.of<LoginProvider>(context).userDetail;
    return Container(
      height: 100.0.h,
      width: 100.0.w,
      child: Column(
        children: [
          SizedBox(height: 1.0.h,),
          _promoSwiper(context),
          SizedBox(height: 2.0.h),
          userDetail.typeDefault == 0 ? cardsWoinVisitante(context) : cardsWoin(context, userDetail.typeDefault, userDetail, woiner),
          SizedBox(height: 2.0.h),
          _buttons(),
          SizedBox(height: 2.0.h),
          userDetail.typeDefault == 0 ? Container() : TextButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera, size: 20.0.sp, color:Colors.grey),
                Text("   Suma puntos a tu vida!", style: TextStyle(color: Colors.grey))
              ],
            ),
            onPressed: (){
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => HowToEarnWoinPoints()
              ));
            },
          )
        ],
      )
    );
  }

Container _promoSwiper(BuildContext context) {
  return Container(
    height: 27.0.h,
    child: FutureBuilder<List<AddModel>>(
      future: AddProvider().getAllAdds(context),
      builder: ( context, snapshot) {
        if (!snapshot.hasData) return Container(child: Center(child: CircularProgressIndicator()));
        if(snapshot.data.length == 0) return Center(child: Text("No hay anuncions disponibles"),);
        return Container(
          height: 25.0.h,
          width: 100.0.w,
          child: Swiper(
            itemBuilder: (BuildContext context,int index) => CardProductView(
              addModel: snapshot.data[index] ,
              index:index
            ), 
            itemCount: snapshot.data.length,
            itemWidth: 95.0.w,
            itemHeight: 25.0.h,
            autoplay: true,
            duration: 900,
            autoplayDelay: 7000,
            layout: SwiperLayout.STACK,
            scrollDirection: Axis.horizontal,
            key: GlobalKey(),
          ),
        );
      },
    ),
  );
}

Future<double> obtenerBalance (int cuenta)async {
  var resp= await ws.obtenerWallet(0, cuenta);
  return resp.entities[0].balance;
}

Padding cardsWoin(context, int id, UserDetailResponse userData, Woiner woiner) {
  return Padding(
    padding:EdgeInsets.symmetric(horizontal:3.0.w),
    child: Container(
      height: 28.0.h,
      width: 100.0.w,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        elevation: 5,
        child: Stack(
          children: [
            _curveBackgroundGrey(),
            _curveBackgroundColor(context: context, id: id ),
            Positioned(
              top:5.0.h,
              left:8.0.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    id == 2 ? "Cliwoin" : "Emwoin", 
                    style: TextStyle(color: id == 2 ? Color(0xff1ba6d2) : Color.fromRGBO(194, 159, 0, 1), fontSize:15.0.sp )
                  ),
                  SizedBox(height: 3.5.h ),
                  Text(
                    "Saldo", 
                    style: TextStyle(color:Colors.grey, fontSize:12.0.sp )
                  ),
                  Text(
                    "000.00", 
                    style: TextStyle(color: id == 2 ? Color(0xff1ba6d2) : Color.fromRGBO(194, 159, 0, 1), fontSize:15.0.sp )
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 2.0.h,
              right: 10.0.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    id == 2 ? woiner?.publicName ?? "No name" : userData.email ?? "No e-mail", 
                    style: TextStyle(color: Colors.black, fontSize:12.0.sp )
                  ),
                  Text(
                    "Ultimo ingreso ${userData.lastConnection}", 
                    style: TextStyle(color:Colors.grey, fontSize:10.0.sp )
                  ),
                ],
              )
            ),
            Positioned(
              top:1.0.h,
              right: 3.0.w,
              child:CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: userData.image != null ? NetworkImage(userData.image) : AssetImage("assets/no_user_image.png"),
              )
            ),
          ],
        ),
      )
    )
  );
}

Align _curveBackgroundColor({context, int id}) {
  return Align(
    alignment: Alignment.centerRight,
    child: ClipPath(
      child: Container(
        width: 60.0.w,
        height: 28.0.h,
        decoration: BoxDecoration(
        gradient: id == 2
            ? LinearGradient(
                colors: [
                  Color.fromRGBO(0, 255, 229, 1),
                  Color.fromRGBO(13, 183, 203, 1),
                  Color.fromRGBO(0, 117, 177, 1)
                ],
                stops: [  0.01,  0.15,  0.5],
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft)
            : LinearGradient(
                colors: [
                  Color.fromRGBO(255, 238, 0, 1),
                  Color.fromRGBO(194, 159, 0, 1),
                  Color.fromRGBO(128, 73, 0, 1)
                ],
                stops: [  0.08,  0.22,  0.8],
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),bottomRight: Radius.circular(20.0))),
      ),
      clipper: BottomWaveClipper(),
    ),
  );
}

Align _curveBackgroundGrey() {
  return Align(
    alignment: Alignment.centerRight,
    child: ClipPath(
      child: Container(
        width: 65.0.w,
        decoration: BoxDecoration(
          color: Color.fromRGBO(235, 237, 242, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)
          )
        ),
        alignment: Alignment.centerRight,
      ),
      clipper: BottomGreyClipper()
    ),
  );
}

Padding cardsWoinVisitante(context,) {
   return Padding(
    padding:EdgeInsets.symmetric(horizontal:3.0.w),
    child: GestureDetector(
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context)=> mainRegisterUser()
        ));
      }, 
      child: Container(
        height: 28.0.h,
        width: 100.0.w,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          elevation: 5,
          child: Stack(
            children: [
              _greyCurveVisitantCard(context),
              _colorCurveVisitantCard(context),
              Positioned(
                top:5.0.h,
                left:8.0.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Visitante", 
                      style: TextStyle(color:Colors.grey[500] , fontSize:15.0.sp )
                    ),
                    SizedBox(height: 3.5.h ),
                    Text(
                      "Saldo", 
                      style: TextStyle(color:Colors.grey, fontSize:15.0.sp )
                    ),
                    Text(
                      "000.00", 
                      style: TextStyle(color:Colors.grey, fontSize:15.0.sp )
                    ),
                  ],
                )
              ),
              Positioned(
                bottom: 2.0.h,
                right: 10.0.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Sin tipo de cuenta Woiner?", 
                          style: TextStyle(color: Colors.black, fontSize:11.0.sp )
                        ),
                        SizedBox(width: 1.0.w,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context)=> mainRegisterUser()
                            ));
                          }, 
                          child: Text("Regístrese",style:TextStyle(color:Color(0xff1ba6d2),))
                        )
                      ],
                    ),
                    Text(
                      "Ultimo ingreso 14/04/2020  10:56:14", 
                      style: TextStyle(color:Colors.grey, fontSize:10.0.sp )
                    ),
                  ],
                )
              ),
              Positioned(
                right: 3.0.w,
                top:1.0.h,
                child:CircleAvatar(
                  backgroundColor:  Colors.grey,
                  backgroundImage: AssetImage("assets/no_user_image.png"),
                )
              ),
            ],
          ),
        )
      ),
    )
  );    
}

Align _colorCurveVisitantCard(context) {
  return Align(
    alignment: Alignment.centerRight,
      child: ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.grey[100],
                  Colors.grey[400],
                  Colors.grey[700]
                ],
                stops:[
                  0.01,
                  0.15,
                  0.5
                ],
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
      ),
      clipper: BottomWaveClipper(),
    ),
  );
}

Align _greyCurveVisitantCard(context) {
  return Align(
    alignment: Alignment.centerRight,
    child: ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.46,
        decoration: BoxDecoration(
            color: Color.fromRGBO(235, 237, 242, 1),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0))),
        alignment: Alignment.centerRight,
      ),
      clipper: BottomGreyClipper(),
    ),
  );
}

Container _buttons(){
  UserDetailResponse userDetail = Provider.of<LoginProvider>(context).userDetail;
  return Container(
    width: 100.0.w,
    padding: EdgeInsets.symmetric(horizontal:4.0.w),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 11.0.h,
          width:28.0.w,
          child: RaisedButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            padding: EdgeInsets.all(0),
            onPressed: userDetail.typeDefault != 0 ? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>typeTransactions())
              );
            } : (){},
            color: Colors.white,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .115 *
                      .01,
                ),
                Container(
                  padding:
                      EdgeInsets.only(right: 11, bottom: 0),
                  child: Icon(
                    Icons.person_add,
                    color:userDetail.typeDefault == 0 ? Colors.grey : userDetail.typeDefault == 2 ? Color(0xff1ba6d2) : Color(0xffD2A409)  ,
                    size: MediaQuery.of(context).size.height *
                        .115 *
                        .35,
                    textDirection: TextDirection.ltr,
                  ),
                ),
                Text(
                  "Invitar",
                  style: TextStyle(
                      color: Color.fromRGBO(188, 188, 188, 1),
                      fontSize:
                          MediaQuery.of(context).size.height *
                              .115 *
                              .16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .115 *
                      .01,
                )
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .11,
          width: MediaQuery.of(context).size.width * .28,
          child: RaisedButton(
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
            onPressed: userDetail.typeDefault == 0 ? (){

            } : () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context)=>Qr_woiner()
              ));
            },
            color: Colors.white,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .115 *
                      .1,
                ),
                Icon(
                  LineIcons.qrcode,
                  color:userDetail.typeDefault == 0 ? Colors.grey : userDetail.typeDefault == 2 ? Color(0xff1ba6d2) : Color(0xffD2A409)  ,
                  size: MediaQuery.of(context).size.height *
                      .115 *
                      .35,
                ),
                Text(
                  "Mi QR",
                  style: TextStyle(
                      color: Color.fromRGBO(188, 188, 188, 1),
                      fontSize:
                          MediaQuery.of(context).size.height *
                              .115 *
                              .16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Roboto"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      .115 *
                      .1,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .11,
          width: MediaQuery.of(context).size.width * .28,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7)),
            padding: EdgeInsets.all(0),
            onPressed: userDetail.typeDefault == 0 ?() {} : (){},
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                            .115 *
                            .1,
                  ),
                  Icon(
                    Icons.flash_on,
                    color:userDetail.typeDefault == 0 ? Colors.grey : userDetail.typeDefault == 2 ? Color(0xff1ba6d2) : Color(0xffD2A409)  ,
                    size: MediaQuery.of(context).size.height *
                        .115 *
                        .35,
                  ),
                  Text(
                    "Recargar",
                    style: TextStyle(
                        color:
                            Color.fromRGBO(188, 188, 188, 1),
                        fontSize: MediaQuery.of(context)
                                .size
                                .height *
                            .115 *
                            .16,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                            .115 *
                            .1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}

