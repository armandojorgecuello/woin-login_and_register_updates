import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/models/user_detail.dart';
import 'package:woin/src/models/woiner_data_model.dart';

import 'package:woin/src/presentation/pages/Promociones/Mis%20publicaciones/PublicacionesMe.dart';
import 'package:woin/src/presentation/pages/anuncio/mainAnuncio.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/typeWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/ConfigurarCuenta/ConfigurarCuentaMain.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/presentation/pages/usuario/how_earn_points_woin.dart';
import 'package:woin/src/providers/current_account_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/services/SesionPersistence/db_SQLite.dart';
import 'package:woin/src/services/usuario/blocUser.dart';
import 'package:woin/src/widgets/clippers_home.dart';
import 'package:woin/src/widgets/cuves_colors.dart';
import 'package:woin/src/widgets/toggle_button.dart';

import 'usuario/AddWoiner/update_user_data.dart';
import 'usuario/register_user/user_register.dart';

class Drawermenu extends StatefulWidget {
  @override
  _DrawermenuState createState() => _DrawermenuState();
}

class _DrawermenuState extends State<Drawermenu> {
  @override
  Widget build(BuildContext context) {
    UserDetailResponse user = Provider.of<LoginProvider>(context).userDetail;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          padding: EdgeInsets.all(0),
          width: 85.0.w,
          color: Colors.white,
          child: Drawer(
            child: Menu(
              user: user,
            )
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  final UserDetailResponse user;

   Menu({Key key, this.user}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  USerProviderDB _db = USerProviderDB();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<CurrentAccount>(context).woiner;

    double size = MediaQuery.of(context).size.width;
    double anchomenu = size * .71;
    double alturabanner = anchomenu * .70;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: ClipPath(
                  clipper: BottomGreyClipperCurve(),
                  child:Container(
                    height: 30.0.h,
                    width: 85.0.w,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 237, 242, 1),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                    ),
                  )
                ),
              ),
              widget.user.typeDefault != 0 ? _woinCurveColor() : _greyCurve(context),
              _netWorkImages(anchomenu, alturabanner, context, userData),
              Positioned(
                right: 3.0.w,
                top: 2.0.h,
                child: ToggleButton(
                  user: widget.user,
                )
              )
            ],
          ),
           _divider(),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Inicio",
            onPressed: (){
              
            },
            icons: Icon(
              LineIcons.home,
              size:17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Woiners",
            onPressed: (){
              
            },
            icons: Icon(
              LineAwesomeIcons.users,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Notificaciones",
            onPressed: (){
              
            },
            icons: Icon(
              LineAwesomeIcons.bell,
              size:17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Subir Anuncio",
            onPressed: () async => {
              await Scaffold.of(context).openEndDrawer(),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => mainAnuncio()))
            },
            icons: Icon(
              LineIcons.image,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Mis Publicaciones",
            onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context)=> PublicacionesMe()));
            },
            icons: Icon(
              LineAwesomeIcons.tags,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton:"Configurar cuenta",
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context)=>ConfigCuentaMain()
              ));
            },
            icons: Icon(
              LineAwesomeIcons.cog,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          _divider(),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "PQRSF",
            onPressed: (){
            
            },
            icons: Icon(
              Icons.record_voice_over,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton: "Tutorial",
            onPressed: (){
             
            },
            icons: Icon(
              LineIcons.playCircle,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          SizedBox(height: 2.0.h,),
          _buttonsDrawer(
            nameButton:"Contactenos",
            onPressed: (){
              
            },
            icons: Icon(
              LineAwesomeIcons.envelope,
              size: 17.0.sp,
              textDirection: TextDirection.ltr,
              color: Colors.black26,
            ),
          ),
          _divider(),
          SizedBox(height: 2.0.h,),
          Row(
            children: [
              _buttonsDrawer(
                nameButton:"Términos y condiciones",
                onPressed: (){

                },
                icons: Icon(
                  Icons.filter_hdr,
                  size:17.0.sp,
                  textDirection: TextDirection.ltr,
                  color: Colors.black26,
                ),
              ),
              Expanded(child:Container()),
              widget.user.typeDefault == 0 ? _exitButton(context) : Container(),
            ],
          ),
          SizedBox(height: 2.0.h,),
          widget.user.typeDefault == 0 ? Container() :Row(
            children: [
              _buttonsDrawer(
                nameButton:"Cómo ganar puntos woin?",
                onPressed: (){
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context)=> HowToEarnWoinPoints()
                  ));
                },
                icons: Icon(
                  Icons.filter_hdr,
                  size:17.0.sp,
                  textDirection: TextDirection.ltr,
                  color: Colors.black26,
                ),
              ),
              Expanded(child:Container()),
              _exitButton(context),
            ],
          ),
        ],
      ),
    );
  }

  ClipPath _greyCurve(BuildContext context) {
    return ClipPath(
      child: Container(
        width:85.0.w,
        height: 30.0.h,
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
    );
  }

  ClipRRect _woinCurveColor() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: ClipPath(
        clipper: BottomWaveClipperCurve(),
        child:Container(
          height: 30.0.h,
          width: 85.0.w,
          decoration: BoxDecoration(
            gradient:  widget.user.typeDefault == 2 ? LinearGradient(
              colors: [Color.fromRGBO(0, 255, 229, 1), Color.fromRGBO(13, 183, 203, 1), Color.fromRGBO(0, 117, 177, 1)],
              stops: [0.01,0.15,0.5],
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft
            ) :LinearGradient(
              colors: [Color.fromRGBO(255, 238, 0, 1),Color.fromRGBO(194, 159, 0, 1),  Color.fromRGBO(128, 73, 0, 1)],
              stops: [0.08,0.22, 0.8],
              begin: FractionalOffset.topRight,
              end: FractionalOffset.bottomLeft
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
          ),
        )
      ),
    );
  }

   SizedBox _divider() {
    return SizedBox(
      height:1.0.h,
      child: Padding(
        padding: EdgeInsets.only(
          left: 3.0.w,
        ),
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black26))),
        ),
      )
    );
  }

  TextButton _exitButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await _db.deleteUserLog();
        Provider.of<LoginProvider>(context, listen:false).userDetail = null;
        tipoUser.userSesionGSink.add(null);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            LineAwesomeIcons.sign_out,
            size: 17.0.sp,
            color: Colors.black26,
          ),
          SizedBox(
            width:3.0.w
          ),
          Text(
            "Salir",
            style: TextStyle(fontFamily: 'Roboto',color: Colors.black38,fontSize: 11.0.sp),
          ),
          SizedBox(width: 2.0.w,)
        ],
      ),
    );
  }

  Padding _buttonsDrawer({Function onPressed, String nameButton, Widget icons }) {
    return Padding(
      padding: EdgeInsets.only(left:1.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 2.0.w,
          ),
          icons,
          SizedBox(
            width:2.0.w,
          ),
          Text(
            nameButton,
            style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black38,
                fontSize: 11.0.sp
            ),
          ),
        ],
      ),
    );
  }

  Align _netWorkImages(double anchomenu, double alturabanner, BuildContext context, Woiner userData) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.only(top: 0, bottom: 0),
        padding: EdgeInsets.only(left: 20, right: 20, top: 1.0.h, bottom: 5),
        color: Colors.transparent,
        child: Center(
          child: Column(
            children: <Widget>[
              widget.user.typeDefault == 0
              ? _visitantHeader(anchomenu, alturabanner, context)
              : _headerWithUser(alturabanner, anchomenu, context, userData),
            ],
          ),
        ),
      ),
    );
  }

  Container _headerWithUser(double alturabanner, anchomenu, context, Woiner userData) {
    return Container(
      height: 30.0.h,
      margin: EdgeInsets.only(top: 0, bottom: 0),
      padding: EdgeInsets.only(left: 20, right: 20, top: 0.5.h, bottom: 5),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: widget.user.image != null ?  NetworkImage(widget.user.image) : AssetImage("assets/no_user_image.png"),
            radius: 8.0.w,
          ),
          SizedBox(
            height:2.0.h,
          ),
          Text(
            userData.publicName ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height:0.5.h,
          ),
          Text(
            widget.user.email ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.black26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height:2.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                itemSize: 14.0.sp,
                rating: 0.0,
                itemCount: 5,
                unratedColor: Colors.grey[500],
                itemBuilder: (context, _) => Icon(
                  Icons.star,color: Color(0xff0075b1), 
                ),
              ),
            ],
          ),
          SizedBox(
            height:1.0.h,
          ),
          FlatButton(
            onPressed: () => {
              if( widget.user.woinerType.length == 1){
                Navigator.push( 
                context, CupertinoPageRoute(
                builder: (context) => 
                  MainDatosWoiner(
                    typeWoiner: widget.user.typeDefault,
                    editmode: widget.user.typeDefault,
                    
                  )
                )
              )
              }else if(widget.user.woinerType.length == 2){
                Navigator.push(context,MaterialPageRoute(builder: (context) => WoinerAccountSelected(typeUserProfile:  widget.user.typeDefault,)))
              }

            },
            color: Color(0xff1ba6d2),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Actualizar perfil",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _visitantHeader(anchomenu, alturabanner, context) {
    return Container(
      height: 30.0.h,
      margin: EdgeInsets.only(top: 0, bottom: 0),
      padding: EdgeInsets.only(left: 20, right: 20, top: 0.5.h, bottom: 5),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/no_user_image.png"),
            radius: 8.0.w,
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            "Sin cuenta Woiner?",
            style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Text(
            "correo@*****.com",
            style: TextStyle(
              fontSize: 10.0.sp,
              color: Colors.black26,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                itemSize: 14.0.sp,
                rating: 0.0,
                itemCount: 5,
                unratedColor: Colors.grey,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xff0075b1), //Theme.of(context).primaryColor
                ),
              ),
              Text(
                "0.0",
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.black26,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          SizedBox(
            height: 1.0.h,
          ),
          FlatButton(
            onPressed: () => {
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(builder: (context) => mainRegisterUser()),
             )
            },
            color: Color(0xff1ba6d2),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Registrarme",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
