import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/presentation/FileIconsWoin/woin_icon.dart';
import 'package:woin/src/presentation/pages/transactions/transactionPpal.dart';



class typeTransactions extends StatefulWidget {
  @override
  _typeTransactionsState createState() => _typeTransactionsState();
}

class _typeTransactionsState extends State<typeTransactions> {
  @override
  int tipo=-1;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () { 
        return Future.value(false);
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(flex:18,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Container(child: Icon(WoinIcon.woin1,size: 30,color: Colors.white,),
                        margin: EdgeInsets.only(right: 16),),
                        backgroundColor: Color(0xff1ba6d2),
                        radius: 32,
                      ),
                      SizedBox(width: 20,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Woin",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 30,fontFamily: "Arial-Rounded" ),textAlign: TextAlign.start,),
                          Text("Suma puntos a tu vida",style: TextStyle(color: Colors.grey[400],fontSize: 12))
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(child: Text("Seleccione tipo de transacción a realizar",style: TextStyle(color: Colors.grey[500],fontSize: 14)),)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                         Row(
                           children: <Widget>[
                             Expanded(
                               child: GestureDetector(
                                 onTap: (){
                                   setState(() {
                                     tipo=0;
                                     Navigator.of(context).push(
                                         CupertinoPageRoute(
                                             builder: (context) => transactionGnal(opcion: this.tipo,editMode: 0,)));
                                   });
                                 },
                                 child: Card(
                                   elevation: tipo==0?5:3,
                                   child: Padding(
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: <Widget>[
                                         Icon(Icons.account_balance_wallet,color: tipo==0?Color(0xff1ba6d2): Colors.grey[500]),
                                         SizedBox(width: 10,),
                                         Text("Pagar    ",style: TextStyle(color:tipo==0?Color(0xff1ba6d2): Colors.grey[500]))
                                       ],
                                     ),
                                     padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(14)),
                                   ),
                                 ),
                               ),
                             )
                           ],
                         ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    tipo=1;
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => transactionGnal(opcion: this.tipo,editMode: 0,)));
                                  });
                                },
                                child: Card(
                                  elevation: tipo==1?5:3,
                                  child: Padding(

                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.card_giftcard,color: tipo==1?Color(0xff1ba6d2):Colors.grey[500]),
                                        SizedBox(width: 10,),
                                        Text("Regalar ",style: TextStyle(color:tipo==1?Color(0xff1ba6d2):Colors.grey[500]),)
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(14)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    tipo=2;
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => transactionGnal(opcion: this.tipo,editMode: 0,)));
                                  });
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.send,color: tipo==2?Color(0xff1ba6d2):Colors.grey[500]),
                                        SizedBox(width: 10,),
                                        Text("Prestar  ",style: TextStyle(color:tipo==2? Color(0xff1ba6d2): Colors.grey[500]))
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(14)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    tipo=3;
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (context) => transactionGnal(opcion: this.tipo,editMode: 0,)));
                                  });
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Padding(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.system_update,color:tipo==3?Color(0xff1ba6d2): Colors.grey[500]),
                                        SizedBox(width: 10,),
                                        Text("Solicitar",style: TextStyle(color: tipo==3? Color(0xff1ba6d2):Colors.grey[500])),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.center,
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(14)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveFlutter.of(context).hp(5),
                  )
                ],
              ),
            ),
            ),


            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
