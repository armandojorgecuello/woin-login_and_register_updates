
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woin/src/presentation/pages/Promociones/FavoriteProm/FavoriteProm.dart';
import 'package:woin/src/presentation/pages/Promociones/ShoppingCart/CartShopping.dart';

class MainFavoriteShopping extends StatefulWidget {

  int index;
  MainFavoriteShopping({this.index=0});
  @override
  _MainFavoriteShoppingState createState() => _MainFavoriteShoppingState();
}

class _MainFavoriteShoppingState extends State<MainFavoriteShopping> {
  int page=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    page=widget.index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pagar",
          style: TextStyle(
            color: Color(0xff1ba6d2),
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.chevron_left,
            size: 35,
            color: Colors.grey[400],
          ),
          alignment: Alignment.centerLeft,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.favorite_border, color: page==0?Colors.red[300]:Colors.grey[300]),
              onPressed: () {
                setState(() {
                  page=0;
                });
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: page==1?Color(0xff1ba6d2):Colors.grey[300]),
              onPressed: () {
                setState(() {
                  page=1;
                });
              })
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 18,
          child:
          page==1?ShoppingCart():Favorite()
          ),
          Expanded(flex: 2,
            child:Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(10),
                          right: ScreenUtil().setWidth(10)),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                size: ScreenUtil().setSp(20),
                                color: Color(0xff1ba6d2),
                              ),
                              SizedBox(
                                  width: ScreenUtil().setWidth(2)
                              ),
                              Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                    ScreenUtil().setSp(14),)
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setHeight(12), bottom: ScreenUtil().setHeight(12)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          }

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ScreenUtil().setWidth(10),
                          left: ScreenUtil().setWidth(10)),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Siguiente',
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontSize:
                                  ScreenUtil().setSp(14),),
                              ),
                              SizedBox(
                                width:ScreenUtil().setWidth(2),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: ScreenUtil().setSp(20),
                                color: Colors.white,
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Color(0xff1ba6d2),
                          onPressed: () async {


                            //VALIDACION DE CAMPOS
                          }

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
