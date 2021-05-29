import 'package:flutter/material.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/entities/anuncio/Colors.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Anuncio/ColorService.dart';
import 'package:woin/src/services/Scope/countryService.dart';

Future<ColorsD> showDialogColor(
    BuildContext context, ColorsD lc) async {

  onpress() {
    Navigator.of(context).pop();
  }

  ColorsD color = await showDialog<ColorsD>(
      context: context,
      builder: (context) {
        List<Widget> colorsWidget(List<ColorsD> lc){
          List<Widget> row=List();
          int tam=lc.length;
          int m=8;

          int rows=(tam/m).ceil();
          print(rows);
          int r=0;
          while(r<rows){


            row.add(  Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(

                  children: <Widget>[
              for(int i=r*m;i<r*m+m;i++)...[

                i<lc.length?
                 InkWell(
                   onTap: (){
                     colorService.selectionColors.add(lc[i]);
                   },
                   child: Container(
                     width: 26,
                     height: 26,
                     margin: EdgeInsets.all(5),
                     padding: EdgeInsets.all(2),
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: lc[i].selected==1?Colors.blue[900]:Colors.white,
                     ),
                     child:Container(
                       width: 25,
                       height: 25,
                       decoration: BoxDecoration(
                         color: colorService.colores[i].color,
                           shape: BoxShape.circle,
                         border: lc[i].selected==1?null:Border.all(color: Colors.grey[400],width: 1)
                       ),
                     ) ,
                   ),
                 ):SizedBox()]


                  ],



                ),
            ));

            r++;

          }

          return row;
        }


        // print(ccity.getcountry.name);
        // print(ccity.getCity.name);

        return StatefulBuilder(builder: (context, setState) {

          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                double ancho = MediaQuery.of(context).size.width;
                var widthScreen = MediaQuery.of(context).size.width;
                var heightScreen = MediaQuery.of(context).size.height;
                var _spacing = widthScreen * 0.03;
                var _crossAxisCount = 2;
                var width = ((widthScreen - (_crossAxisCount - 1) * _spacing)) /
                    _crossAxisCount;

                var celHeight = heightScreen * .106;
                var aspectratio = width / celHeight;
                ScrollController ctrl = PageController();
                var heightc = MediaQuery.of(context).size.height * .5;
                var widthc = MediaQuery.of(context).size.width;


                return Container(
                  width: widthc,
                  height: heightc,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        titleSpacing: -20,
                        actions: <Widget>[

                        ],
                        leading: IconButton(
                          icon: Icon(
                            Icons.chevron_left,
                            size: 18,
                            color: Color(0xff97a4b1),
                          ),
                          alignment: Alignment.centerLeft,
                          onPressed: () {
                           Navigator.of(context).pop();
                          },
                        ),
                        title: Text("Colores")
                      ),
                      body: Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[

                            Expanded(
                              flex:8,
                              child: StreamBuilder<List<ColorsD>>(
                                stream: colorService.listaColores,
                                builder:(context,AsyncSnapshot<List<ColorsD>> snapshot){
                                  return snapshot.hasData?
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 15),
                                        child: Column(
                                          children:colorsWidget(snapshot.data) ,
                                        ),
                                      )


                                      :CircularProgressIndicator();
                                },
                              ),
                            ),
                            Expanded(flex: 2,child: Container(
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
                                          left: widthc * 0.03,
                                          right: widthc * 0.03),
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
                                                widthc * 0.015,
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
                                            if(lc==null){
                                              colorService.deseleccionarColores(1);
                                            }else{
                                              colorService.colorsSelected.add(lc);
                                            }

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
                                          right: widthc * 0.03,
                                          left: widthc * 0.03),
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
                                                widthc * 0.015,
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
                                            
                                            if(colorService.colores.where((c)=>c.selected==1).toList().length>0){
                                              //colorService.colorsSelected.add(lc);

                                              print(colorService.colores.where((c)=>c.selected==1).toList()[0].nombre);
                                              Navigator.of(context).pop(colorService.colores.where((c)=>c.selected==1).toList()[0]);
                                            }else{

                                              closeModal() {
                                                Navigator.of(context).pop();
                                              }
                                              showAlerts( context, "Seleccione un color", false,closeModal, null,"Aceptar","", null);
                                            }

                                          }
                                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
      });



  return color;
}



