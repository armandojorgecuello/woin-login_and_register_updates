import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Anuncio/AnuncioService.dart';
class PaquetePromocion extends StatefulWidget {

  final paquetePromocion paquete;
  PaquetePromocion({@required this.paquete});
  @override
  _precioOfertaState createState() => _precioOfertaState();
}

class _precioOfertaState extends State<PaquetePromocion> {
int filter=2;
Utilities utils=Utilities();
 paquetePromocion paq;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.paquete!=null){
      paq=widget.paquete;
    }

  }



  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "paquetePromocion",
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
          title: Text("Oferta",style: TextStyle(
            fontFamily: "Roboto",
            fontSize: MediaQuery.of(context).size.height * 0.0195,
            color: Color(0xff1ba6d2),
            fontWeight: FontWeight.w700,
          ),),
          leading: Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.centerLeft,
            //color: Colors.amber,
            padding: EdgeInsets.all(0),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              splashColor: Colors.white10,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(flex: 18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey[300],width: 0.7)
                        ),
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child:  SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Row(

                                    children: <Widget>[
                                      Text("Paquetes Disponibles",style: TextStyle(color: Colors.grey[600]),),

                                    ],
                                  ),
                                ),
                               Padding(
                                 padding: EdgeInsets.symmetric(horizontal: 10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: <Widget>[

                                     InkWell(
                                       onTap: (){
                                         filter=0;
                                         anuncioService.tipoPaquete.add(2);
                                         setState(() {

                                         });
                                       },
                                       child: Container(

                                         width:ResponsiveFlutter.of(context).wp(25),
                                         height: ResponsiveFlutter.of(context).hp(5),
                                         child: Card(
                                           elevation: 0,
                                           shape: RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(10),
                                             side: BorderSide(color: filter==0?Color(0xff1ba6d2):Colors.grey[300],width: 0.5)
                                           ),
                                           margin: EdgeInsets.zero,
                                           child: Center(child: Text("Mes",style: TextStyle(color: filter==0?Color(0xff1ba6d2):Colors.grey[500],fontWeight: FontWeight.w300),),),
                                         ),
                                       ),
                                     ),
                                     InkWell(
                                       onTap: (){
                                         filter=1;
                                         anuncioService.tipoPaquete.add(1);
                                         setState(() {

                                         });
                                       },
                                       child: Container(

                                         width:ResponsiveFlutter.of(context).wp(25),
                                         height: ResponsiveFlutter.of(context).hp(5),
                                         child: Card(
                                           elevation: 0,
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10),
                                               side: BorderSide(color: filter==1?Color(0xff1ba6d2):Colors.grey[300],width: 0.5)
                                           ),
                                           margin: EdgeInsets.zero,
                                           child: Center(child: Text("Días",style: TextStyle(color: filter==1?Color(0xff1ba6d2):Colors.grey[500],fontWeight: FontWeight.w300))),
                                         ),
                                       ),
                                     ),
                                     InkWell(
                                       onTap: (){
                                         filter=2;
                                         anuncioService.tipoPaquete.add(0);
                                         setState(() {

                                         });
                                       },
                                       child: Container(

                                         width:ResponsiveFlutter.of(context).wp(25),
                                         height: ResponsiveFlutter.of(context).hp(5),
                                         child: Card(
                                           elevation: 0,
                                           shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(10),
                                               side: BorderSide(color: filter==2?Color(0xff1ba6d2):Colors.grey[300],width: 0.5)
                                           ),
                                           margin: EdgeInsets.zero,
                                           child: Center(child: Text("Todos",style: TextStyle(color: filter==2?Color(0xff1ba6d2):Colors.grey[500],fontWeight: FontWeight.w300))),
                                         ),
                                       ),
                                     ),

                                   ],
                                 ),
                               ),
                               SizedBox(
                                 height: ResponsiveFlutter.of(context).verticalScale(20),
                               ),
                               Container(
                                 height: ResponsiveFlutter.of(context).hp(13),
                                 child: StreamBuilder<List<paquetePromocion>>(
                                   stream: anuncioService.listPaquest,
                                   builder: (context,AsyncSnapshot<List<paquetePromocion>> snapshot){
                                     return snapshot.hasData?ListView.builder(
                                       scrollDirection: Axis.horizontal,
                                         padding: EdgeInsets.only(left: 10,right: 10),
                                         itemCount: snapshot.data.length,
                                         itemBuilder: (context, int index){
                                           return Container(
                                             padding: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(5)),
                                             margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),
                                             width: ResponsiveFlutter.of(context).wp(utils.format(snapshot.data[index].valor).length>7?20+utils.format(snapshot.data[index].valor).length:27),
                                             child: InkWell(
                                               onTap: (){
                                                 paq=snapshot.data[index];
                                                 setState(() {

                                                 });
                                               },
                                               child: Card(
                                                 elevation: paq!=null && paq==snapshot.data[index]?4:0,
                                                 margin: EdgeInsets.zero,
                                                 shape: RoundedRectangleBorder(
                                                   borderRadius: BorderRadius.circular(5),
                                                   side: BorderSide(width: 0.4,color: paq!=null && paq==snapshot.data[index]?Color(0xff1ba6d2):Colors.grey[500])
                                                 ),
                                                 child: Column(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: <Widget>[
                                                     Padding(
                                                       padding:EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: <Widget>[
                                                           Text("${snapshot.data[index].timeString} ${snapshot.data[index].type==1?" días":snapshot.data[index].timeString=="1"?" mes":" meses" }",style: TextStyle(
                                                             color: Colors.grey[500],
                                                             fontWeight: FontWeight.w300,
                                                             fontSize: ResponsiveFlutter.of(context).fontSize(1.6),
                                                           ),),
                                                           Container(
                                                             width: 18,
                                                             height: 18,
                                                             decoration: BoxDecoration(
                                                               shape: BoxShape.circle,
                                                               color: paq!=null && paq==snapshot.data[index]?Color(0xff1ba6d2):Colors.white,
                                                               border: Border.all(width: 0.5,color: Colors.grey[400])
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                     Center(
                                                       child: Text(utils.format(snapshot.data[index].valor),style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold,fontSize: ResponsiveFlutter.of(context).fontSize(2.2)),),
                                                     ),
                                                     Padding(
                                                       padding: EdgeInsets.only(bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.center,
                                                         children: <Widget>[
                                                           Text("Banner",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w300,
                                                           fontSize: ResponsiveFlutter.of(context).fontSize(1.8)
                                                           ),
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                             ),
                                           );
                                         }

                                     )


                                         :CircularProgressIndicator();
                                 },
                                 ),
                               ),



                              ],
                            ),
                          ),

                      ),
                    ),
                    Expanded(flex: 3,child: SizedBox(),)
                  ],
                ),
              ),


            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1,color: Colors.grey[300])
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03,
                            right: MediaQuery.of(context).size.width * 0.03),
                        child: RaisedButton(
                            elevation: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Color(0xff1ba6d2),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  'Cancelar',
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Color(0xff1ba6d2),
                                      fontSize:
                                      MediaQuery.of(context).size.height *
                                          0.019),
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 12, bottom: 12),
                            color: Colors.white,
                            onPressed: () {
                              //anuncioService.tipoPaquete.add(0);
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
                            right: MediaQuery.of(context).size.width * 0.03,
                            left: MediaQuery.of(context).size.width * 0.03),
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
                                      MediaQuery.of(context).size.height *
                                          0.019),
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.03,
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            padding: EdgeInsets.only(
                                left: 30, right: 30, top: 12, bottom: 12),
                            color: Color(0xff1ba6d2),
                            onPressed: () {

                              if(paq==null) {
                                closeModal() {
                                  Navigator.of(context).pop();
                                }
                                showAlerts( context, "Seleccione un paquete", false,closeModal, null,"Aceptar","", null);
                              }else{
                               // anuncioService.tipoPaquete.add(0);
                                Navigator.of(context).pop(paq);
                              }



                            }
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ),
          ],
        ),),
    );
  }
}
