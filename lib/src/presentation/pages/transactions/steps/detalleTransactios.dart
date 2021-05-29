import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Transactions/Transaccion.dart';
import 'package:woin/src/entities/Transactions/transactionJsonPost.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/services/Transactions/TransactionsService.dart';

class DetalleTransaccion extends StatefulWidget {
  @override
  _DetalleTransaccionState createState() => _DetalleTransaccionState();
}

class _DetalleTransaccionState extends State<DetalleTransaccion> {
  TransctionsService ts=TransctionsService();
  Utilities utils = Utilities();


  List<transactionJson>transaccionforUser(String code){
    List<transactionJson>ltu=List();
    for(transactionJson t in ts.listaTransacciones){
      if(t.woinerIdReceirve.toString()==code){
        ltu.add(t);
      }
    }
    return ltu;
  }

  double totalTransaccionUser(String code){
    double total=0;
    for(transactionJson t in ts.listaTransacciones){
     if(t.woinerIdReceirve.toString()==code){
       total+=t.transaction.amount;
     }
    }
    return total;
  }

  List<String> listCodewoiner(){
    List<String>lu=List();
    for(transactionJson t in ts.listaTransacciones){
      if(!lu.contains(t.woinerIdReceirve)){
        lu.add(t.woinerIdReceirve.toString());
      }
    }
    return lu;
  }

  Widget transactionsUser(String code){
    List<transactionJson> ltu=transaccionforUser(code);
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(15)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: Colors.grey[500],
          width: 0.5
        ),
      ),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(ltu[0].woinerIdReceirve.toString(),style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)),
          for(transactionJson t in ltu)...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Cartera ${t.transaction.woinType==2? "Cliwoin":"Emwoin"}",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300),),
                  Text("${utils.format(t.transaction.amount.ceilToDouble())}",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w400),)
                ],
              ),
            )
          ],
          Divider(color: Colors.grey[400],),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
             Padding(
               padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
               child: Text(utils.format(totalTransaccionUser(code)),style: TextStyle(color: Color.fromRGBO( 21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).fontSize(2.5),fontWeight: FontWeight.bold),),
             )
            ],
          )


        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        title: Text("Detalle",style: TextStyle(color: Color(0xff1ba6d2)),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 18,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                itemCount: listCodewoiner().length,
                itemBuilder: (context,index){
                  List<String> luser=listCodewoiner();
                  return transactionsUser(luser[index]);
                }
                ),


          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top:BorderSide(width: 1,color:Colors.grey[300])
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
             SizedBox(width: ResponsiveFlutter.of(context).wp(28),),

                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveFlutter.of(context).wp(3)),
                      child: OutlineButton(
                        borderSide: BorderSide(
                          width: 1,
                          color:  Color(0xff1ba6d2),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon(
                              LineIcons.home,
                              size: 20,
                              color:Color(0xff1ba6d2),
                            ),
                            SizedBox(
                              width: ResponsiveFlutter.of(context).wp(1),
                            ),
                            Text(
                              'Ir a inicio',
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color:  Color(0xff1ba6d2),
                                  fontSize:
                                  MediaQuery.of(context).size.height *
                                      0.0195),
                            ),

                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 12, bottom: 12),

                        onPressed: () {

                          TransctionsService ts=TransctionsService();
                          ts.nuevaTransaccion();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder:(context)=> Login()
                              )
                          );




                        },
                      ),
                    ),
                  ),

                  SizedBox(width: ResponsiveFlutter.of(context).wp(28),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
