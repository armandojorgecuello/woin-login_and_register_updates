import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/presentation/FileIconsWoin/woin_icon.dart';
class Qr_woiner extends StatefulWidget {

  @override
  _Qr_woinerState createState() => _Qr_woinerState();
}

class _Qr_woinerState extends State<Qr_woiner> {
  userdetalle sesion= userdetalle();
  String code;
  final _screenController=ScreenshotController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    code= sesion.tieneTipo()?sesion.obtenerdetalle(sesion.getCuentaActiva).codewoiner:null;
   // print("CODE WOINER=>"+sesion.obtenerdetalle(sesion.getCuentaActiva).codewoiner);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        title: Text(
          "",
          style: TextStyle(color: Color(0xff1ba6d2),fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(2),
              splashColor: Colors.white,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
              onPressed: () {
               Navigator.of(context).pop();
              },
            );
          }),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 18,
          child: Container(
            color: Colors.white,
            child: code!=null?Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            child: Container(child: Icon(WoinIcon.woin1,size: 22,color: Colors.white,),
                              margin: EdgeInsets.only(right: 11),),
                            backgroundColor: Color(0xff1ba6d2),
                            radius: 25,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(sesion.obtenerdetalle(sesion.getCuentaActiva).nombre,style: TextStyle(color: Colors.grey[700],fontSize: 16,fontWeight: FontWeight.w700),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(   sesion
                              .obtenerdetalle(sesion.getCuentaActiva)
                              .email,style: TextStyle(color: Colors.grey[500],fontSize: 12,fontWeight: FontWeight.w400),)
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                    ],
                  ),
                ),
                Expanded(
                  flex: 13,
                  child: Column(
                    children: <Widget>[

                      Screenshot(
                        controller: _screenController,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          height: 310,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[200],width: 1),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("QR Código",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold,fontSize: 16),)
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Escanear para realizar transacción",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 12),)
                                ],
                              ),

                               Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 2),
                                            color: Colors.white,

                                            alignment: Alignment.center,
                                            child: QrImage(
                                              data: code,
                                              foregroundColor: Color.fromARGB(255, 1, 90, 136),

                                              version: QrVersions.auto,

                                            ),
                                          ),
                                        ),
                               Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(code,style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.w400,fontSize: 16),)
                                            ],
                                          ),
                                        ),
                               Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text("Código de Referido",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 12),)
                                            ],
                                          ),
                                        ),
                               SizedBox(
                                  height: 10,
                                ),





                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(


                                child: OutlineButton(
                                  onPressed: (){},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.print,color: Color(0xff1ba6d2),),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Imprimir",style: TextStyle(fontSize: 12,color: Color(0xff1ba6d2)),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: SizedBox(


                                child: OutlineButton(
                                  onPressed: ()async{
                                    final imgFile= await _screenController.capture();
                                    //Share.shareFiles([imgFile.]);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.device_hub,color: Color(0xff1ba6d2),),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Compartir",style: TextStyle(fontSize: 12,color: Color(0xff1ba6d2)),)
                                    ],
                                  ),
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info_outline,size: 50,color: Colors.grey[500]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("Cree su cuenta para poder obtener su QR",style: TextStyle(color: Colors.grey[500]),)
                  ],
                )
              ],
            ),
          ),),
          Expanded(
            flex: 2,
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1,color: Colors.grey[200])
                )
              ),
              padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(

                    width: 120,
                     child: OutlineButton(
                       borderSide: BorderSide(
                         color: Colors.white,
                         width: 1,
                       ),
                       highlightedBorderColor: Color(0xff1ba6d2),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10),

                       ),
                      onPressed: (){
                         Navigator.of(context).pop();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.close,color: Colors.grey[500]),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Cerrar",style: TextStyle(color: Colors.grey[500]),)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
