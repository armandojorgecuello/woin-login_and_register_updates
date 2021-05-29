import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/anuncio/AnuncioMain.dart';

import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/entities/subcategorias/subcategorias.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/Promociones/cardPromocion.dart';
import 'package:woin/src/presentation/pages/Promociones/detallePromocion.dart';
import 'package:woin/src/presentation/pages/anuncio/attributesProduct/detalleProduct.dart';
import 'package:woin/src/presentation/pages/anuncio/mainAnuncio.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/CaracteristicasAnuncio.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/PaquetesPromocion.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/ValorAnuncio.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/informacionOferta.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/lugarOferta.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/mercadoObjetivo.dart';
import 'package:woin/src/presentation/pages/anuncio/subirAnuncio/tiempoVisible.dart';
import 'package:woin/src/presentation/pages/principal/card_swiper.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/services/Anuncio/AnuncioMainService.dart';
import 'package:woin/src/services/Anuncio/AnuncioService.dart';
import 'package:woin/src/services/Scope/countryService.dart';
import 'package:woin/src/services/Scope/countryService.dart';

import 'package:woin/src/services/subcategoria/subcategoriaBloc.dart';

class anuncioDetalle extends StatefulWidget {
  tipoAnuncio tipo;
  List<Subcategoria> lsc;
  lugarOfertaAnuncio lugar;
  mercadoObjetivoClass mercado;
  infoOferta information;
  precioOferta valorOferta;
  paquetePromocion paquete;
  CaracteristicasAn caracteristicas;
  fechaAnuncio fechapublicacion;
  final f = new DateFormat('dd-MM-yyyy');
  anuncioDetalle(this.tipo, this.lsc) {}

  @override
  _anuncioDetalleState createState() => _anuncioDetalleState();
}

class _anuncioDetalleState extends State<anuncioDetalle> {
  List<Governorates> lg = new List();
  List<Cities> lc = new List();
  DateTime _dateDesde;
  DateTime _dateHasta;
  var myFormat = new DateFormat('yyyy-MM-dd');
  var myFormat2 = new DateFormat('yyyy-MM-dd');
  int validLugar = 0;
  int validMercado = 0;
  bool errlugar=false;
  bool errfecha=false;
  bool errmercado=false;
  bool errinfo=false;
  bool errCaracteristicas=false;
  bool errprecio=false;
  bool errpaquete=false;


  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var _spacing = widthScreen * 0.03;
    var _crossAxisCount = 2;
    var width =
        ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
    var celHeight = heightScreen * .04 + 30;
    var aspectratio = width / celHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: true,

        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Subir anuncio " + this.widget.tipo.tipo,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 16,
            color: Color(0xff1ba6d2),
            fontWeight: FontWeight.w700,
          ),
        ),
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
        actions: <Widget>[
        Container(
          width: 28,
          height:28,
          child: RawMaterialButton(

                    elevation: 0,
                    fillColor: this.widget.tipo.color,
                    padding: EdgeInsets.all(
                        2),
                    shape: CircleBorder(),
                    child: Icon(
                      this.widget.tipo.icono,
                      color: Colors.white,
                      size: 16,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mainAnuncio()));
                    },
                  ),
        ),


          Container(
            height: 45,
            width: 30,
            decoration: BoxDecoration(shape: BoxShape.circle),
            alignment: Alignment.centerRight,
            //color: Colors.amber,
            padding: EdgeInsets.all(0),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              splashColor: Colors.white10,
              onTap: () {
                // Navigator.of(context).pop();
              },
              child: Icon(
                Icons.more_vert,
                size: 25,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
      color: Colors.grey[100],

        child: Column(
          children: <Widget>[
            SizedBox(
              height: ResponsiveFlutter.of(context).verticalScale(10),
            ),



    /*    Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                 Padding(
                      padding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                        child: Text("Subcategorías",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.w300),)),
                   Expanded(
                     child:
                            ListView.builder(
                               shrinkWrap: true,
                               padding: EdgeInsets.only(bottom: 5,left: 5),
                               scrollDirection: Axis.horizontal,
                               itemCount: widget.lsc.length,
                               itemBuilder:(context,index){
                                 return Container(

                                   margin: EdgeInsets.all(5),
                                   width: MediaQuery.of(context).size.width * .42,
                                   padding: EdgeInsets.all(2),
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: Colors.white,
                                       border: Border.all(width: 0.5,color: Colors.grey[400])
                                   ),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Flexible(
                                         child: Padding(
                                           padding:EdgeInsets.only(top: 5),
                                           child: Text(
                                             this.widget.lsc[index].name.trim(),
                                             style: TextStyle(
                                                 color: Color(0xff929292),
                                                 fontFamily: "TrebushetMS",
                                                 fontSize: this.widget.lsc[index].name.length>12?ResponsiveFlutter.of(context).fontSize(1.6):ResponsiveFlutter.of(context).fontSize(1.8)),
                                             textAlign: TextAlign.center,
                                           ),
                                         ),
                                       ),
                                       InkWell(
                                         onTap:(){},
                                         child: Icon(Icons.cancel,color: Colors.grey[400],size: 20,),
                                       ),
                                     ],
                                   ),
                                 );
                               } ),


                   ),
                  ],
                ),
              ),
            ), */
            Expanded(
              flex: 18,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10,bottom: 5),
               decoration: BoxDecoration(
                 color: Colors.grey[100],
                // border: Border.all(color: Colors.grey[200],width: 1)
               ),
                child: Padding(
                    padding: EdgeInsets.only(
                        //top: MediaQuery.of(context).size.height * 0.01,
                        left: 0,
                        right: 0,
                        bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[


                        Expanded(
                          child: Scrollbar(
                            child: ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Card(
                                  child: Column(
                                    children: <Widget>[
                                      Hero(
                                        tag: "subcategoria",
                                        child: GestureDetector(
                                          onTap: () {

                                          },
                                          child: Material(
                                            color: errlugar?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.map,
                                                  color: Colors.orange[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Subcategoría del producto",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: Text(widget.lsc[0].name),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "LugarOferta",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                    Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) =>
                                                        lugarOferta(
                                                          lugarAnuncio: widget.lugar,
                                                          tipoAnuncio:
                                                          this.widget.tipo.tipo ==
                                                              "Pago"
                                                              ? 1
                                                              : 2,
                                                        ))).then((lug) {
                                              if (lug != null) {
                                                setState(() {
                                                  widget.lugar = lug;
                                                  validLugar = 1;
                                                  errlugar=false;
                                                });
                                              }
                                            });
                                          },
                                          child: Material(
                                            color: errlugar?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.green[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Donde mostrar su oferta",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: widget.lugar == null
                                                  ? Text("No registra")
                                                  : Text(widget.lugar.pais.name),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      this.widget.tipo.tipo == "Gratis"
                                          ? Hero(
                                        tag: "tiempoVisible",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>tiempoVisible (fecha: widget.fechapublicacion,))
                                            ).then((fechas){
                                              if(fechas!=null){
                                                fechaAnuncio fn=fechaAnuncio(fechadesde: fechas.fechadesde,fechaHasta: fechas.fechaHasta);
                                                widget.fechapublicacion=fn;
                                                errfecha=false;
                                                setState(() {

                                                });
                                              }
                                            });
                                          },
                                          child: Material(
                                            color:  errfecha?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                Colors.grey[200],
                                                child: Icon(
                                                  Icons.timelapse,
                                                  color: Colors.red[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Fecha publicación del anuncio",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: widget.fechapublicacion==null?Text("Sin fecha"):Text(widget.f.format(widget.fechapublicacion.fechadesde)),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "mercadoObjetivo",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    transitionDuration:
                                                    Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) =>
                                                        mercadoObjetivo(
                                                          mercado: widget.mercado,
                                                        ))).then((merc) {
                                              if (merc != null) {
                                                setState(() {
                                                  widget.mercado = merc;
                                                  validMercado = 1;
                                                  errmercado=false;
                                                });
                                              }
                                            });
                                          },
                                          child: Material(
                                            color:  errmercado?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(Icons.business,
                                                    color: Colors.blue[600]),
                                              ),
                                              title: Text(
                                                "Mercado objetivo",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: Text(widget.mercado == null
                                                  ? "Mercado no seleccionado"
                                                  : widget.mercado.gender.name +
                                                  " ${widget.mercado.isTodaEdad() ? " Todas las edades" : widget.mercado.edadDesde.toString() + "-" + widget.mercado.edadHasta.toString() + " años"}"),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "infoOferta",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) => InfoAnuncio(
                                                      information: widget.information,
                                                    ))).then((info){
                                                      if(info!=null){
                                                        widget.information=info;
                                                        errinfo=false;
                                                        setState(() {

                                                        });
                                                      }
                                            });


                                          },
                                          child: Material(
                                            color: errinfo?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.amber[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Información de la oferta",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: widget.information==null?Text("Sin Información"):Text(widget.information.titulo,style: TextStyle(color:Colors.grey[500]),),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "caracteristicaArticulo",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) => CaracteristicasAnuncio(
                                                      caracteristicas: widget.caracteristicas ,
                                                    ))).then((car){
                                                      if(car!=null){
                                                        print("ENTRO A CAMBIAR");
                                                        widget.caracteristicas=car;
                                                        print("LATRIB=>"+widget.caracteristicas.detalleProduct.length.toString());
                                                        print("LAVAL=>"+widget.caracteristicas.valores.length.toString());
                                                        errCaracteristicas=false;
                                                        setState(() {

                                                        });
                                                      }
                                            });


                                          },
                                          child: Material(
                                            color: errCaracteristicas?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.description,
                                                  color: Colors.deepPurple[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Características",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: widget.caracteristicas==null?Text("Sin características"):Text("Producto: "+widget.caracteristicas.nombreProduct,style: TextStyle(color:Colors.grey[500]),),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "precioOferta",
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) => ValorAnuncio(
                                                      valorOferta: widget.valorOferta,
                                                    ))).then((po){
                                                      if(po!=null){
                                                        widget.valorOferta=po;
                                                        setState(() {

                                                        });
                                                      }
                                            });


                                          },
                                          child: Material(
                                            color: errprecio?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.attach_money,
                                                  color: Colors.blue[900],
                                                ),
                                              ),
                                              title: Text(
                                                "Precio/ promoción de la oferta",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: widget.valorOferta==null?Text("Sin precio"):Text("\$"+widget.valorOferta.precioFinal.toString()+" ${widget.valorOferta.descuento!=0?"Desc: ${widget.valorOferta.descuento}%":""}"),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      this.widget.tipo.tipo == "Pago"
                                          ? Hero(
                                        tag: "paquetePromocion",
                                        child: GestureDetector(
                                          onTap: () {
                                            anuncioService.tipoPaquete.add(0);
                                            Navigator.push(context,
                                                PageRouteBuilder(transitionDuration: Duration(milliseconds: 1200),
                                                    pageBuilder: (_, __, ___) =>PaquetePromocion(
                                                      paquete: widget.paquete,
                                                    ))).then((paq){
                                                      if(paq!=null){
                                                        widget.paquete=paq;
                                                      }
                                            });


                                          },
                                          child: Material(
                                            color: errpaquete?Colors.blue[100]: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                Colors.grey[200],
                                                child: Icon(
                                                  Icons.card_giftcard,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              title: Text(
                                                "Paquetes en promoción",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: Text(
                                                  widget.paquete==null?"Sin paquete seleccionado":"${ widget.paquete.timeString} ${ widget.paquete.type==1?" días": widget.paquete.timeString=="1"?" mes":" meses" } -\$ ${widget.paquete.valor}"),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          : SizedBox(),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                      Hero(
                                        tag: "valorAgregado",
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Material(
                                            color: Colors.white,
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.grey[200],
                                                child: Icon(
                                                  Icons.card_membership,
                                                  color: Colors.green[200],
                                                ),
                                              ),
                                              title: Text(
                                                "Adicione valor agregado a su oferta",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                              subtitle: Text("Sin valor agregado"),
                                              trailing: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.chevron_right,
                                                    size: 28,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.all(0),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top:BorderSide(color: Colors.grey[300],width: 1))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        child: RaisedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.close,
                                    size: 20, color: Color(0xff1ba6d2)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  'Cancelar',
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Color(0xff1ba6d2),
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.0195),
                                )
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.only(
                                left: 37, right: 37, top: 12, bottom: 12),
                            color: Colors.white,
                            elevation: 0,
                            onPressed: () {
                              // print(username);
                              subcategorias.filterSubcat.add("");
                              Navigator.of(context).pop();

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                            }),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.03),
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
                                              0.0195),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
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
                                left: 37, right: 37, top: 12, bottom: 12),
                            color: Color(0xff1ba6d2),
                            onPressed: ()async{
                              showDialogV2(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialogLoading());

                              bool modalview=false;
                              int r=0;


                              if(widget.lugar==null){
                                errlugar=true;
                                r=1;

                              }
                              if(widget.fechapublicacion==null){
                                errfecha=true;
                                r=1;
                              }

                              if(widget.mercado==null){
                                errmercado=true;
                                r=1;
                              }

                              if(widget.information==null){
                                errinfo=true;
                                r=1;
                              }

                              if(widget.caracteristicas==null){
                                errCaracteristicas=true;
                                r=1;
                              }

                              if(widget.valorOferta==null){
                                errprecio=true;
                                r=1;
                              }


                              if(widget.tipo.tipo.toLowerCase()=="gratis"){
                                print("GRATIS");
                              }else{

                                if(widget.paquete==null){
                                  errpaquete=true;
                                  r=1;
                                }

                              }

                              if(r==1){
                                setState(() {

                                });
                                closeModal(){
                                  Navigator.of(context).pop();
                                }
                                showAlerts(context, "Los campos seleccionados son obligatorios", false, closeModal, null, "Aceptar", "", null);
                              }else{

                                List<keyValues> keyvaluesList=List();


                                //CREAR ATRIBUTOS
                                for(valorAtributos dp in widget.caracteristicas.valores){

                                  for(int i=0;i<dp.llaves.length;i++){


                                    keyValues kv= new keyValues(
                                        valores: dp.valores[i],
                                        keys: dp.llaves[i],
                                        id: dp.id,
                                        parent: i==0?1:0,
                                        total: dp.cantidad
                                    );
                                    keyvaluesList.add(kv);

                                  }



                                }
                                //CREAR PRODUCTO
                                producto p = new producto(
                                  name: widget.caracteristicas.nombreProduct.trim(),
                                  createdAt: 0,
                                  updatedAt: 0,
                                  description: "",
                                  price: widget.valorOferta.precioFinal,
                                  subcategoryId: widget.lsc[0].id,

                                );

                                //CREAR AD



                                Ad ad=Ad(
                                  id: 0,
                                  keyvalues: keyvaluesList,
                                  subcategoryId:  widget.lsc[0].id,
                                  price: widget.valorOferta.precioFinal,
                                  description: widget.information.descripcion,
                                  updatedAt: 0,
                                  createdAt: 0,
                                  type: 1,
                                  adParent: 0,
                                  ageFinal: widget.mercado.isTodaEdad()?100: widget.mercado.edadHasta,
                                  ageInitial:widget.mercado.isTodaEdad()?1: widget.mercado.edadDesde,
                                  gender:widget.mercado.gender.id==1000?null: widget.mercado.gender.id,
                                  currentStock: widget.caracteristicas.valores[0].cantidad,
                                  giftPercentage: widget.valorOferta.descuento.toInt(),
                                  discountPercentage: widget.valorOferta.vdescuento.toInt(),
                                  productId: 0,
                                  state: 1,
                                  title: widget.information.titulo,
                                  initialStock: widget.caracteristicas.valores[0].cantidad,
                                  initialTime: myFormat2.format(widget.fechapublicacion.fechadesde),
                                  finalTime: myFormat2.format(widget.fechapublicacion.fechaHasta),
                                  woinerId: 0,
                                  multimediaIds: null,
                                );
                                FreeAd fa=null;
                                PaidAd pa=null;
                                if(widget.tipo.tipo.toLowerCase()=="gratis"){
                                  fa=FreeAd(
                                    createdAt: 0,
                                    updatedAt: 0,
                                    packetId: 0,
                                    id: 0,
                                    adId: 0,
                                    start:  widget.fechapublicacion.fechadesde.millisecondsSinceEpoch,
                                    end: widget.fechapublicacion.fechaHasta.millisecondsSinceEpoch,

                                  );

                                }else{
                                  pa=PaidAd(
                                    start:  widget.fechapublicacion.fechadesde.millisecondsSinceEpoch,
                                    end: widget.fechapublicacion.fechaHasta.millisecondsSinceEpoch,
                                  );
                                }
                                List<Multimedia> lmu=List<Multimedia>();

                                if(widget.caracteristicas.img1!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img1,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }
                                if(widget.caracteristicas.img2!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img2,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }
                                if(widget.caracteristicas.img3!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img3,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }
                                if(widget.caracteristicas.img4!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img4,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }

                                if(widget.caracteristicas.img5!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img5,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }

                                if(widget.caracteristicas.img6!=""){
                                  Multimedia mu=Multimedia(
                                    id: 0,
                                    updatedAt: 0,
                                    createdAt: 0,
                                    state: 1,
                                    imageBase64:widget.caracteristicas.img6,
                                    type: 1,
                                    description: null,
                                    imageFile: null,
                                    source: null,
                                  );
                                  lmu.add(mu);
                                }



                                //SUBIR ANUNCIO
                                anuncioAd anuncio= anuncioAd(
                                  ad: ad,
                                  freeAd:widget.tipo.tipo.toLowerCase()=="gratis"?fa:null ,
                                  multimedia:lmu ,
                                  paidAd:widget.tipo.tipo.toLowerCase()=="gratis"?null:pa ,
                                  product:p
                                );




                              RespanuncioAd respuesta=await MainAnuncioService.addAnuncio(anuncio);

                                if(respuesta.status){
                                  Navigator.of(context).pop();

                                  closeModal(){
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context)=>TabMain())
                                    );
                                  }
                                  showAlerts(context, "Se ha guardado correctamente su anunncio", true, closeModal, null, "Aceptar", "", null);
                                }else{
                                  closeModal(){
                                    Navigator.of(context).pop();
                                  }
                                  showAlerts(context, "Error al guardar anuncio", false, closeModal, null, "Aceptar", "", null);
                                }




                              }


                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardsPromocion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (context) => detallePromocion()));
        },
        child: Container(
          height: ResponsiveFlutter.of(context).hp(20),
          width: ResponsiveFlutter.of(context).wp(42),

          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[500],
                offset: new Offset(3.0, 3.0),
                blurRadius: 1.0,
              ),],),
          margin: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(4) ,right: ResponsiveFlutter.of(context).scale(4) ,bottom: ResponsiveFlutter.of(context).verticalScale(5),top:ResponsiveFlutter.of(context).verticalScale(3)),
          child: CardPromocion(),
        ),
      );

  }
}

