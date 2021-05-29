import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:woin/src/entities/anuncio/AnuncioList.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/presentation/mainTabs/CardsProductView.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/services/Anuncio/AnuncioListBloc.dart';
class PublicacionesMe extends StatefulWidget {
  @override
  _PublicacionesMeState createState() => _PublicacionesMeState();
}

class _PublicacionesMeState extends State<PublicacionesMe> {

 List<AnuncioAd> listpublicaciones=[];
 userdetalle sesion =userdetalle();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  int verOpciones=0;

 Future<List<AnuncioAd>> obtenerMisPublicaciones()async {
   //OBTENER PUBLICACIONES
   listpublicaciones = await AnuncioBloc.cargarAnuncios();
   //FILTRAR POR CODE WOINER
   List<AnuncioAd> lfilter=listpublicaciones.where((p)=>p.codeWoiner.trim()==sesion.obtenerdetalle(sesion.getCuentaActiva).codewoiner.trim()).toList();

   return lfilter ;


 }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context)=>TabMain()
          ),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Mis publicaciones",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 17),),
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
        body:
           Column(
              children: <Widget>[
                Expanded(
                  flex: 18,
                  child: FutureBuilder(
                    future: obtenerMisPublicaciones(),
                    builder: (BuildContext context,AsyncSnapshot<List<AnuncioAd>>snapshot){
                      //print("DATA=>"+snapshot.data.length.toString());
                      print(snapshot.hasData);
                      if(!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator(),);

                      }else{
                        return snapshot.data.length>0? Container(
                          padding: EdgeInsets.only(top: 10),
                          color: Colors.grey[100],
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.length,
                              itemBuilder: (context,int index){
                               return Container(
                                 padding: EdgeInsets.symmetric(vertical: 10),
                                 height: ScreenUtil().setHeight(200),
                                 child: Slidable(
                                   closeOnScroll: false,
                                 actionPane: SlidableDrawerActionPane(),
                                actionExtentRatio: 0.25,
                                secondaryActions: <Widget>[
                                IconSlideAction(
                                caption: 'Eliminar',
                                foregroundColor: Colors.red[600],
                                color: Colors.transparent,
                                icon: Icons.archive,
                                onTap: (){
                                  setState(() {
                                    verOpciones= verOpciones==1?0:1;
                                  });
                                }
                                ),],
                                   child: CardProductView(
                                     //anuncio: snapshot.data[index],
                                   ),
                                 ),
                               );
                              } ),
                        ):Center(child: Text("No se han subido anuncio en su cuenta!!"),);
                      }
                      },
                ),),
               verOpciones==1? Expanded(
                  flex: 2,
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

                ):SizedBox(),
              ],
         )


      ),
    );
  }
}
