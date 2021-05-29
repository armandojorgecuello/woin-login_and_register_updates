import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/presentation/pages/usuario/ConfigurarCuenta/ConfigPuntos.dart';


class ConfigCuentaMain extends StatefulWidget {
  @override
  _ConfigCuentaMainState createState() => _ConfigCuentaMainState();
}

class _ConfigCuentaMainState extends State<ConfigCuentaMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Configurar Cuenta",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 17),),
        leading: Container(
          width: 30,
          child:InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context)=>TabMain()
                ),
              );
            },
            splashColor: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(50)),
            child:  Align(
              alignment:Alignment.centerLeft,
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.grey[400],
              ),
            ),

          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 18,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (contex)=>ConfigPuntos() ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    height: ResponsiveFlutter.of(context).hp(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:Border.all(color: Colors.grey[500],width: 0.5),
                      color: Colors.white,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.card_giftcard,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 12),
                                    child: Text("Regalar puntos",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),))
                              ],
                            ),
                            SizedBox(
                              width: ResponsiveFlutter.of(context).wp(60),
                              child: Padding(
                                padding:EdgeInsets.only(left: 12,right: 2),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(child: Text("Configure la aplicación el porcentaje a regalar en puntos por compras",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 12),),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: ResponsiveFlutter.of(context).wp(17.2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.chevron_right,color: Colors.grey[700],)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                  height: ResponsiveFlutter.of(context).hp(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border:Border.all(color: Colors.grey[500],width: 0.5),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.red[200],
                            radius: 20,
                            child: Icon(
                              Icons.lock,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 12),
                                  child: Text("Seguridad",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),))
                            ],
                          ),


                          SizedBox(
                            width: ResponsiveFlutter.of(context).wp(60),
                            child: Padding(
                              padding:EdgeInsets.only(left: 12,right: 2),
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Text("Establezca pin, contraseña, huella de seguridad para ingresar al aplicativo y realizar transacciones",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 12),),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: ResponsiveFlutter.of(context).wp(17.2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.chevron_right,color: Colors.grey[700],)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),),
          Expanded(flex: 2,
              child:Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                      SizedBox(
                width: ResponsiveFlutter.of(context).wp(42),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.close,
                                    size: 20, color: Color(0xff1ba6d2)),
                                SizedBox(
                                  width: ResponsiveFlutter.of(context).wp(1),
                                ),
                                Text(
                                  'Cancelar',
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Color(0xff1ba6d2),
                                      fontSize:
                                      ResponsiveFlutter.of(context).hp(2)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(color:Color(0xff1ba6d2),width: 1 )
                            ),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 12, bottom: 12),
                            color: Colors.white,

                            elevation: 0,
                            onPressed: () {


                              // print(username);

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                            },
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
