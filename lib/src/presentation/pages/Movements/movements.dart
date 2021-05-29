import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:woin/src/entities/Movements/item_movement_model.dart';
import 'package:woin/src/entities/Transactions/listTransactions.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/services/Movements/movements_bloc.dart';
import 'package:woin/src/services/Transactions/TransactionsServiceList.dart';


class Movements extends StatefulWidget {

  Movements({Key key}) : super(key: key);

  @override
  MovementsState createState() => MovementsState();
}

class MovementsState extends State<Movements> {
  DateTime _fechaDesde = null;
  DateTime _fechaHasta = null;
  double totMovements=0;
  bool _filtroPorFecha = false;
  bool _filtroPorRecibido = false;
  bool _filtroPorEnviado = false;
  bool _filtroPorPago = false;
  bool _filtroPorRegalo = false;
  bool _filtroPorPrestamo = false;
  bool _filtroPorSolicitado = false;
  DateFormat dformat;
  transactionList tl;
  var formatter = new DateFormat('yyyy-MM-dd');
  TransactionsService ts=TransactionsService();
  Utilities utils =Utilities();
  userdetalle sesion = new userdetalle();
  String _newFechaDesde;
  String _newFechaHasta;
  List<MovementsT> listGnal;
  List<MovementsT> lshow;
  List<String> lfechas=[];
  int typeTransaction=-1;

  bool stateFilteredFecha(){
    print("FILTRO FECHA=>"+_filtroPorFecha.toString());
    return _filtroPorFecha? true:false;
  }


  obtenerTransacciones() async{
    List<MovementsT> listformater=[];
   var resp=await ts.obtenerTransactions();
   tl=resp;
   double totMov=0;

   for(MovementsT d in tl.entities) {
     //print(d.woinEmailGift.id);
     totMov += d.amount;
     if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
       lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
       // print("AGREGADO");
     }
     DateTime fi=DateTime.fromMillisecondsSinceEpoch(d.createdAt);
     DateTime ff=new DateTime(fi.year,fi.month,fi.day,0,0,0);
     d.fechaFormater=ff;
     listformater.add(d);
   }

   lshow=listformater;
   listGnal=listformater;
   setState(() {
     totMovements=totMov;
   });

  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }


  void filtrarMovimientos( DateTime fechadesde,DateTime fechaHasta,int typeTransaction,int recibido){
    List<MovementsT> lfilter;
    lfechas.clear();
    if(fechadesde!=null&& fechaHasta!=null ){
       if(typeTransaction>-1 && recibido==0){
         //CON TIPO DE TRANSACCION  Y SI SELECCIONÖ RECIBIDOS O NO
         lfilter=listGnal.where((m)=> (m.fechaFormater).compareTo(fechadesde)>=0 && (m.fechaFormater).compareTo(fechaHasta)<=0 && m.typeWoinerInTransaction==recibido && m.transactionType==typeTransaction).toList();

         setState(() {
           for(MovementsT d in lfilter) {
             //print(d.woinEmailGift.id);
             if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
               lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
               // print("AGREGADO");
             }
           }
           lshow=lfilter;
         });


       }else{
         //SIN TIPO DE TRANSACCION  Y SELECCIONÖ RECIBIDOS
         lfilter=listGnal.where((m)=> (m.fechaFormater).compareTo(fechadesde)>=0 && (m.fechaFormater).compareTo(fechaHasta)<=0 && m.typeWoinerInTransaction==recibido).toList();
         setState(() {
           for(MovementsT d in lfilter) {
             //print(d.woinEmailGift.id);
             if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
               lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
               // print("AGREGADO");
             }
           }
           lshow=lfilter;
         });

       }
    }
    if(fechadesde==null&& fechaHasta!=null ){
      if(typeTransaction>-1 && recibido==0){
        //CON TIPO DE TRANSACCION  Y SI SELECCIONÖ RECIBIDOS O NO
        lfilter=listGnal.where((m)=> (m.fechaFormater).compareTo(fechaHasta)<=0 && m.typeWoinerInTransaction==recibido && m.transactionType==typeTransaction).toList();
        setState(() {
          for(MovementsT d in lfilter) {
            //print(d.woinEmailGift.id);
            if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
              lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
              // print("AGREGADO");
            }
          }
          lshow=lfilter;
        });

      }else{
        //SIN TIPO DE TRANSACCION  Y SELECCIONÖ RECIBIDOS
        lfilter=listGnal.where((m)=> (m.fechaFormater).compareTo(fechaHasta)<=0 && m.typeWoinerInTransaction==recibido).toList();
        setState(() {
          for(MovementsT d in lfilter) {
            //print(d.woinEmailGift.id);
            if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
              lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
              // print("AGREGADO");
            }
          }
          lshow=lfilter;
        });

      }
    }
    if(fechadesde!=null&& fechaHasta==null ){
      if(typeTransaction>-1 && recibido==0){
        //CON TIPO DE TRANSACCION  Y SI SELECCIONÖ RECIBIDOS O NO
        lfilter=listGnal.where((m)=>(m.fechaFormater).compareTo(fechadesde)>=0 && m.typeWoinerInTransaction==recibido && m.transactionType==typeTransaction).toList();
        setState(() {
          for(MovementsT d in lfilter) {
            //print(d.woinEmailGift.id);
            if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
              lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
              // print("AGREGADO");
            }
          }
          lshow=lfilter;
        });

      }else{
        //SIN TIPO DE TRANSACCION  Y SELECCIONÖ RECIBIDOS
        lfilter=listGnal.where((m)=> (m.fechaFormater).compareTo(fechadesde)>=0 && m.typeWoinerInTransaction==recibido).toList();
        setState(() {
          for(MovementsT d in lfilter) {
            //print(d.woinEmailGift.id);
            if(!lfechas.contains(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)))){
              lfechas.add(dformat.format( new DateTime.fromMillisecondsSinceEpoch(d.createdAt)));
              // print("AGREGADO");
            }
          }
          lshow=lfilter;
        });

      }
    }



  }



  @override
  void initState() {
    super.initState();
    dformat= DateFormat("yMMMd");
    lshow=[];
    listGnal=[];
    /*movementsBloc.fetchAllMovements();

    _newFechaDesde = dformat.format(DateTime.now());
    _newFechaHasta = dformat.format(DateTime.now());*/
    obtenerTransacciones();
  }

  @override
  void dispose() {
    super.dispose();

    movementsBloc.dispose();
  }

  void filterFecha(){
    setState(() {
      _filtroPorFecha = _filtroPorFecha ? false : true;
    });

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Column(
        children: <Widget>[
          Expanded(
            flex: _filtroPorFecha ? 9:5,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: _filtroPorFecha ? 3: 0,
                      child: _filtroPorFecha
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 850),
                              curve: Curves.elasticInOut,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.028,
                                                color: Colors.grey[500]),
                                            SizedBox(width: 3.5),
                                            Text(_newFechaDesde!=null?_newFechaDesde:"",
                                                style: TextStyle(
                                                    color: Color(0xfc979797),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.018))
                                          ]),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .wp(3),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .hp(1)),
                                        child: GestureDetector(
                                          onTap: () async {
                                            DateTime resp= await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate:
                                                    DateTime(1970, 01, 01),
                                                lastDate:
                                                    DateTime(2030, 12, 31));

                                            if (resp != null) {
                                              setState(() {
                                                _fechaDesde = resp;
                                                //APLICAR FILTRO
                                                filtrarMovimientos(_fechaDesde, _fechaHasta, typeTransaction, _filtroPorRecibido?1:0);
                                              });
                                            }
                                          },
                                          child:Container(
                                            width: ResponsiveFlutter.of(context).wp(45),
                                            padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(5)),
                                            decoration: BoxDecoration(
                                              border: Border.all(width: 0.5,color: Colors.grey[500]),
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(_fechaDesde==null?"Fecha desde":dformat.format(_fechaDesde),style: TextStyle(color: Colors.grey[600]),),
                                                  Icon(Icons.keyboard_arrow_down,color: Colors.grey[600],)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.calendar_today,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.028,
                                                color: Colors.grey[500]),
                                            SizedBox(width: 3.5),
                                            Text(_newFechaHasta!=null?_newFechaHasta:"",
                                                style: TextStyle(
                                                    color: Color(0xfc979797),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.018))
                                          ]),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .wp(3),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .hp(1)),
                                        child: GestureDetector(
                                          onTap: () async {
                                            DateTime resp = await showDatePicker(
                                                context: context,
                                                initialDate:DateTime.now(),
                                                firstDate:
                                                    DateTime(1970, 01, 01),
                                                lastDate:
                                                    DateTime(2030, 12, 31));

                                            if(resp!=null){
                                              setState(() {
                                                _fechaHasta=resp;
                                                //APLICAR FILTRO
                                                filtrarMovimientos(_fechaDesde, _fechaHasta, typeTransaction,_filtroPorRecibido?1:0);
                                              });

                                            }

                                          },
                                          child:Container(
                                            width: ResponsiveFlutter.of(context).wp(45),
                                            padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(5)),
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5,color: Colors.grey[500]),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child:  Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(_fechaHasta==null?"Fecha hasta":dformat.format(_fechaHasta),style: TextStyle(color: Colors.grey[600])),
                                                  Icon(Icons.keyboard_arrow_down,color: Colors.grey[600],)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                    ),
                    Expanded(
                      flex: _filtroPorFecha? 3:3,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.grey[400],width: 0.5)
                        ),
                        elevation: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.087,
                          width: MediaQuery.of(context).size.width * 0.93,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: ResponsiveFlutter.of(context).wp(5),
                                bottom: ResponsiveFlutter.of(context).hp(1),
                                top: ResponsiveFlutter.of(context).hp(1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Total movimientos',
                                    style: TextStyle(color: Color(0xff1b96d2))),
                                Text(utils.format(totMovements),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff1b96d2)))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: ResponsiveFlutter.of(context).hp(0),
                          top: ResponsiveFlutter.of(context).verticalScale(2),
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            ButtonOptionMovement(
                              icono: Icon(Icons.payment,
                                  color: typeTransaction==0
                                      ? Color(0xff1b96d2)
                                      : Colors.grey[400]),
                              titulo: Text('Pagos',
                                  style: TextStyle(
                                      color: typeTransaction==0
                                          ? Color(0xff1b96d2)
                                          : Colors.grey[400])),
                              onTap: () {
                                  setState(() {
                                    typeTransaction=0;
                                  });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.019),
                            ButtonOptionMovement(
                              icono: Icon(Icons.business_center,
                                  color: typeTransaction==1
                                      ? Color(0xff1b96d2)
                                      : Colors.grey[400]),
                              titulo: Text('Regalos',
                                  style: TextStyle(
                                      color: typeTransaction==1
                                          ? Color(0xff1b96d2)
                                          : Colors.grey[400])),
                              onTap: () {
                                setState(() {
                                  typeTransaction=1;
                                });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.019),
                            ButtonOptionMovement(
                              icono: Icon(Icons.face,
                                  color: typeTransaction==2
                                      ? Color(0xff1b96d2)
                                      : Colors.grey[400]),
                              titulo: Text('Prestamos',
                                  style: TextStyle(
                                      color: typeTransaction==2
                                          ? Color(0xff1b96d2)
                                          : Colors.grey[400])),
                              onTap: () {
                                setState(() {
                                  typeTransaction=2;
                                });
                              },
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.019),
                            ButtonOptionMovement(
                              icono: Icon(Icons.file_download,
                                  color: typeTransaction==3
                                      ? Color(0xff1b96d2)
                                      : Colors.grey[400]),
                              titulo: Text('Solicitado',
                                  style: TextStyle(
                                      color: typeTransaction==3
                                          ? Color(0xff1b96d2)
                                          : Colors.grey[400])),
                              onTap: () {
                                setState(() {
                                  typeTransaction=3;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex:2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveFlutter.of(context).hp(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ButtonTypeMovement(
                                icono: Transform.rotate(
                                    angle: 3.5,
                                    child:Icon(LineIcons.locationArrow,
                                    color: _filtroPorRecibido
                                        ? Color.fromARGB(255, 1, 90, 136)
                                        : Colors.grey[400])),
                                titulo: Text('Recibidos',
                                    style: TextStyle(
                                        color: _filtroPorRecibido
                                            ? Color.fromARGB(255, 1, 90, 136)
                                            : Colors.grey[500],fontWeight: FontWeight.w400)),
                                onTap: () {
                                  setState(() {
                                    _filtroPorRecibido =
                                        _filtroPorRecibido ? false : true;
                                    _filtroPorEnviado = false;
                                  });
                                  },
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15),
                              ButtonTypeMovement(
                                icono: Transform.rotate(
                                  angle: 0.5,
                                  child: Icon(LineIcons.locationArrow,
                                      color: _filtroPorEnviado
                                          ? Color.fromARGB(255, 1, 90, 136)
                                          : Colors.grey[400]),
                                ),
                                titulo: Text('Enviados',
                                    style: TextStyle(
                                        color: _filtroPorEnviado
                                            ? Color.fromARGB(255, 1, 90, 136)
                                            : Colors.grey[500],fontWeight:  FontWeight.w400)),
                                onTap: () {
                                  setState(() {
                                    _filtroPorEnviado =
                                        _filtroPorEnviado ? false : true;

                                    _filtroPorRecibido = false;
                                  });


                                },
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          ),
          Expanded(
              flex: 12,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).hp(2.5),
                      horizontal: ResponsiveFlutter.of(context).wp(3)),
                  child: lshow!=null && lshow.length>0 ?ListView.builder(
                                itemCount: lfechas.length,
                                itemBuilder: (Context, int index) => Column(
                                      children: [
                                        Padding(
                                          padding:EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            lfechas[index],
                                              style: TextStyle(
                                                  color: Colors.grey[600])),
                                        ),
                                        Column(
                                            children: lshow
                                                .where((m) =>
                                            dformat.format( new DateTime.fromMillisecondsSinceEpoch(m.createdAt))==
                                               lfechas[index])
                                                .map((item) => Slidable(
                                                      key: ValueKey(item.id),
                                                      actionPane:
                                                          SlidableDrawerActionPane(),
                                                      actionExtentRatio: 0.2,
                                                      closeOnScroll: false,

                                                      child: Container(
                                                        height:90,

                                                        margin: EdgeInsets.symmetric(
                                                            vertical:
                                                                ResponsiveFlutter.of(
                                                                        context)
                                                                    .hp(0.6),
                                                            horizontal:
                                                                ResponsiveFlutter.of(
                                                                        context)
                                                                    .wp(0)),

                                                        child: Row(
                                                          children: <Widget>[
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                               Padding(
                                                                 padding: const EdgeInsets.only(left:10.0),
                                                                 child: CircleAvatar(
                                                                      radius: 32,
                                                                      backgroundImage:
                                                                      NetworkImage(item.avatarReceiver)
                                                                  ),
                                                               ),


                                                              ],
                                                            ),
                                                            Expanded(

                                                              child: Padding(
                                                                padding:EdgeInsets.only(left: 15),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[

                                                                        Row(


                                                                            children: [
                                                                              Icon(
                                                                                  Icons
                                                                                      .account_balance_wallet,
                                                                                  color: item.transactionType ==1

                                                                                      ? Colors.purple
                                                                                      : Color.fromARGB(255, 1, 90, 136),size: 19,),
                                                                              SizedBox(
                                                                                  width:
                                                                                  5.0),
                                                                              Text(

                                                                                  '${item.typeWoinerInTransaction==0?"Recibido":"Enviado"} ',
                                                                                  style: TextStyle(
                                                                                      color: item.transactionType == 1
                                                                                          ? Colors.purple
                                                                                          : Color.fromARGB(255, 1, 90, 136)))
                                                                            ]),


                                                                    Row(
                                                                      children: <Widget>[
                                                                        Text(item.emailReceiver,style: TextStyle(color: Colors.grey[500],fontSize: 12),),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding:EdgeInsets.only(right: 10),
                                                                  child: Text(
                                                                      utils.format(item.amount),
                                                                      style: TextStyle(
                                                                        fontSize: 16,
                                                                          fontWeight: FontWeight.w600,
                                                                          color: item.transactionType ==1
                                                                              ? Colors
                                                                              .purple
                                                                              : Color.fromARGB(255, 1, 90, 136)),),
                                                                )
                                                              ],
                                                            ),
                                                          ],



                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                        border: Border.all(width: 1,color: Colors.grey[300])),
                                                      ),
                                                      secondaryActions: <
                                                          Widget>[
                                                        Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical:
                                                                  ResponsiveFlutter.of(
                                                                          context)
                                                                      .hp(2),
                                                              horizontal:
                                                                  ResponsiveFlutter.of(
                                                                          context)
                                                                      .wp(0)),
                                                          child:
                                                              IconSlideAction(
                                                            caption: 'Eliminar',
                                                            color: Colors
                                                                .transparent,
                                                            foregroundColor:
                                                                Colors
                                                                    .pinkAccent,
                                                            icon: Icons
                                                                .delete_outline,
                                                            onTap: () =>
                                                                _showSnackBar(
                                                                    context,
                                                                    'Delete'),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                .toList())
                                      ],
                                    ),)
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Usted no ha realizado transacciones",style: TextStyle(color: Colors.grey[600]),)
                              ],
                            ),
                      ),
          ),
        ],
      ),
      /*floatingActionButton: movementsDataDelete.length > 1
          ? FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.delete, color: Colors.white),
              onPressed: () {
               print(movementsDataDelete.length);

                int deletes = movementsDataDelete.length;

                for (MovementsByDate mDelete in movementsDataDelete) {
                  for (MovementsByDate mData in movements) {
                    if (mData.movimientos.first.user.id ==
                        mDelete.movimientos.first.user.id) {
                      setState(() {
                        movements.remove(mData);
                        movementsDataDelete.remove(mDelete);
                      });
                    }
                  }
                }

                _showSnackBar(context,
                    ' Eliminados : ' + deletes.toString() + ' movimientos');
              },
            )
          : null,*/
    );
  }
}

class ButtonOptionMovement extends StatelessWidget {
  final Widget icono;
  final Widget titulo;
  final Function onTap;

  ButtonOptionMovement({Key key, this.icono, this.titulo, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: ResponsiveFlutter.of(context).wp(34),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveFlutter.of(context).wp(1.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [this.icono,SizedBox(width: ResponsiveFlutter.of(context).scale(5),),this.titulo]),
            ),
          ),
        ),
        onTap: this.onTap);
  }
}

class ButtonTypeMovement extends StatelessWidget {
  final Widget icono;
  final Widget titulo;
  final Function onTap;

  ButtonTypeMovement({Key key, this.icono, this.titulo, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveFlutter.of(context).wp(1.9),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [this.icono, this.titulo]),
          ),
        ),
        onTap: this.onTap);
  }
}
