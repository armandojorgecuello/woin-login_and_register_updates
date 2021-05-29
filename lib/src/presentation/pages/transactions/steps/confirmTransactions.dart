import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Cartera/Cartera.dart';
import 'package:woin/src/entities/Transactions/Transaccion.dart';
import 'package:woin/src/entities/Transactions/transactionJsonPost.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/transactions/steps/transactionsMonto.dart';
import 'package:woin/src/presentation/pages/transactions/transactionPpal.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/services/CarteraService/carteraService.dart';
import 'package:woin/src/services/Transactions/TransactionsService.dart';
import 'package:woin/src/services/Transactions/TransactionsServiceList.dart';


class ConfirmTransactions extends StatefulWidget {

  final int editMode;
  final int opcion;
  final List<userTransactions> usuarios;

  ConfirmTransactions({@required this.editMode,@required this.opcion,@required this.usuarios});
  @override
  _ConfirmTransactionsState createState() => _ConfirmTransactionsState();
}

class _ConfirmTransactionsState extends State<ConfirmTransactions> {
  Utilities utils=Utilities();
  List<Cartera>lc;
  TransctionsService ts=TransctionsService();
  TransactionsService Tservice=TransactionsService();
  userdetalle sesion = new userdetalle();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lc=widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList():CarteraService.carteraSelected();
  }


  void deleteUserList(userTransactions user) {
    if (widget.usuarios.length > 0) {
      for (int i = 0; i < widget.usuarios.length; i++) {
        if (widget.usuarios[i].codewoiner == user.codewoiner) {
          widget.usuarios.removeAt(i);
          break;
        }
      }

      setState(() {});
    }
  }

  double montoCartera(){
    double valorfinal=0;
    for(Cartera c in lc){
      valorfinal+=c.montofinal;
    }
    return valorfinal;
  }

  double montofinalTransaccion(){
    double valorfinal=0;
    for(userTransactions u in widget.usuarios){
      valorfinal+=u.puntos;
    }
    return valorfinal;
  }

  void modificarMontoUsuario(userTransactions user){
    for(userTransactions u in widget.usuarios){
      if(user.codewoiner==u.codewoiner){
        u.puntos=user.puntos;
      }
    }
    setState(() {

    });
  }

  bool existCarteraCero(){
    lc=widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList():CarteraService.carteraSelected();
    for(Cartera c in lc){
      if(c.valortransferir==0){
        return true;
      }
    }
    return false;
  }
  asignarMontoTransaccionCartera(userTransactions u ) async{
    double mat=0;
    print("TIPO DE TRANSACCION=>"+widget.opcion.toString());
    //PAGAR 1
    //REGALAR 2
    //PRESTAR 3
    //SOLICITAR 4
    double valorfaltante=u.puntos;
    while(mat<u.puntos){
      int ic=0;
      //RECORRIENDO CARTERARS
      while(valorfaltante>0){
        print("MONTO TRANSFERIR CARTERA"+lc[ic].valortransferir.toString());
        print("IC=>"+ic.toString());

        if( lc[ic].valortransferir==0){
          ic++;
        }
        //CARTERA TIENE MAS MONTO A TRANSFERIR
        if(lc[ic].valortransferir-valorfaltante>0) {
          if(u.type==2 || u.type==3){
            Transaction tr=Transaction(
              state: 1,
              transactionType:widget.opcion==1?2:widget.opcion==2?3:widget.opcion==3?1:widget.opcion==4?7:1,
              detail: "TRANSACCIÓN DE PRUEBA",
              amount: valorfaltante.floor(),
              woinType: lc[ic].type,
              woinEmailGift: null,
              createdAt: null,
              updatedAt: null,
              id: null,
              isTransactionGift: null,
              userId: null,
              subType: null,
              email: null,
              walletReceiver: null,
              walletSender: null,
              token: sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm
            );
            transactionJson trj=transactionJson(
             woinerIdReceirve:  u.woinerId,
              walletType: 0,
              transaction: tr,
            );
            try{
              await Tservice.postTransaccion(trj);
              //print("TRANSACCION EXITOSA");
            }on Exception catch(e){
             // print("ERROR EN LA TRANSACCION");
            }
            ts.addTransaccion(trj);
          }else if(u.type==0){
            Transaction tr=Transaction(
                state: 1,
                transactionType: 8,
                detail: "TRANSACCIÓN DE DIFERIDO",
                amount: valorfaltante.floor(),
                woinType: lc[ic].type,
                woinEmailGift: null,
                createdAt: null,
                updatedAt: null,
                id: null,
                token: sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm,
                isTransactionGift: null,
                userId: null,
                subType: 0,
                email: u.email,
                walletReceiver: null,
                walletSender: null
            );
            transactionJson trj=transactionJson(
              woinerIdReceirve:  null,
              walletType: 0,
              transaction: tr,
            );
            try{
              await Tservice.postTransaccion(trj);
              //print("TRANSACCION EXITOSA REFERIDO");
            }on Exception catch(e){
              print("ERROR EN LA TRANSACCION");
            }
          }
          /*Transaccion t = new Transaccion(idMovimiento: "MOV1",codeWoinerEmisor: "YO", codeWoinerReceptor: u.codewoiner, monto: valorfaltante,
              carteraOrigen: lc[ic].type,
              carteraDestino: 2,
              ncarteraOrrigen: lc[ic].name,
              ncarteraDestino: "CLIWOIN");*/
          mat += valorfaltante;
          lc[ic].valortransferir -= valorfaltante;
          valorfaltante =0;
          /*print("VF1=>" + valorfaltante.toString());
                  print("mat1=>" + mat.toString());
                  print("1 TRANSFERENCIA");*/

          //CARTERA MENOR QUE  VALOR
        }else if(lc[ic].valortransferir-valorfaltante<=0){

          if(u.type==2 || u.type==3){
            Transaction tr=Transaction(
                state: 1,
                transactionType: widget.opcion==1?2:widget.opcion==2?3:widget.opcion==3?3:7,
                detail: "TRANSACCIÓN DE PRUEBA",
                amount: lc[ic].valortransferir.floor(),
                woinType: lc[ic].type,
                woinEmailGift: null,
                createdAt: null,
                updatedAt: null,
                id: null,
                isTransactionGift: null,
                userId: null,
                subType: null,
                email: null,
                walletReceiver: null,
                walletSender: null,
              token: sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm,
            );
            transactionJson trj=transactionJson(
                woinerIdReceirve:  u.woinerId,
                walletType: 0,
                transaction: tr,
            );
            try{
              await Tservice.postTransaccion(trj);
             // print("TRANSACCION EXITOSA");
            }on Exception catch(e){
              print("ERROR EN LA TRANSACCION");
            }
            ts.addTransaccion(trj);
          }else if(u.type==0){
            Transaction tr=Transaction(
                state: 1,
                transactionType: 8,
                detail: "TRANSACCIÓN DE DIFERIDO",
                amount: lc[ic].valortransferir.floor(),
                woinType: lc[ic].type,
                woinEmailGift: null,
                createdAt: null,
                updatedAt: null,
                id: null,
                isTransactionGift: null,
                userId: null,
                subType: null,
                email: u.email,
                walletReceiver: null,
                walletSender: null,
              token: sesion.getCuentaActiva == 2 ? sesion.getTokenCli : sesion.getTokenEm
            );
            transactionJson trj=transactionJson(
              woinerIdReceirve:  null,
              walletType: 0,
              transaction: tr,
            );
            try{
              await Tservice.postTransaccion(trj);
              //print("TRANSACCION EXITOSA REFERIDO");
            }on Exception catch(e){
              print("ERROR EN LA TRANSACCION");
            }

          }
          /*Transaccion t = new Transaccion(idMovimiento: "MOV1",codeWoinerEmisor: "YO", codeWoinerReceptor: u.codewoiner, monto: lc[ic].valortransferir,
              carteraOrigen: lc[ic].type,
              carteraDestino: 2,
              ncarteraOrrigen: lc[ic].name,
              ncarteraDestino: "CLIWOIN");*/
          mat += lc[ic].valortransferir;
          valorfaltante -= lc[ic].valortransferir;
          /*print("VF1=>" + valorfaltante.toString());
          print("mat1=>" + mat.toString());
          print("2 TRANSFERENCIA");*/
          lc[ic].valortransferir =0;
         // ts.addTransaccion(tr);
          ic++;
        }
      }

      /*print("mat=>"+mat.toString());
      print("TERMINADA TRANSACCIÓN");*/
    }
  }


  Widget _wlist(userTransactions user) {
    // print("ENTRA WLIST");
    List<userTransactions>lselected=List();
    lselected.add(user);
    return GestureDetector(
      onTap:(){
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context)=>ValorTransactionView(editMode: 1,userall:widget.usuarios ,userSelected:lselected ,opcion: widget.opcion,)
          )
        ).then((ledit){
          if(ledit!=null){
            for(userTransactions u in ledit){
              modificarMontoUsuario(u);
            }
            setState(() {

            });
          }else{
            print("LLEGÓ NULO");
          }

        });
      },
      child: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.symmetric(
            vertical: ResponsiveFlutter.of(context).verticalScale(1),
            horizontal: 0),
        width: widget.usuarios.length==2?ResponsiveFlutter.of(context).wp(45.2):ResponsiveFlutter.of(context).wp(46),
        // height: ResponsiveFlutter.of(context).hp(18),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[300], width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(

              vertical: ResponsiveFlutter.of(context).verticalScale(2)),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 7),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: ResponsiveFlutter.of(context).verticalScale(3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        radius: ResponsiveFlutter.of(context).hp(2.8),
                        backgroundColor: user.type == 2
                            ? Color.fromARGB(255, 27, 166, 210)
                            : Color.fromARGB(255, 222, 170, 1),
                        child: CircleAvatar(
                          radius: ResponsiveFlutter.of(context).hp(2.7),
                          backgroundImage: user.imagen != ""
                              ? NetworkImage(user.imagen)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //print("ELIMINAR");

                          if (widget.editMode == 0) {
                            deleteUserList(user);
                          }

                          setState(() {});
                        },
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Container(
                          alignment: Alignment.center,
                          width: ResponsiveFlutter.of(context).wp(8),
                          height: ResponsiveFlutter.of(context).wp(8),
                          child: Icon(
                            FontAwesome.times_circle,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveFlutter.of(context).verticalScale(8),
                  ),
                  Text(
                    user.fullname!=null? user.fullname.trim():"sin Nombre",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        fontFamily: "Roboto"),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: ResponsiveFlutter.of(context).verticalScale(5),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        utils.format(user.puntos),
                        style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 11,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.left,
                      ),
                      widget.opcion == 1
                          ? Text(
                        "\$" + utils.format(user.compras),
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.left,
                      )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveFlutter.of(context).verticalScale(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (() {
            print("OPCION=>"+widget.opcion.toString());
            if (widget.editMode == 0) {
              if (widget.opcion == 1) {
                return "Pagar";
              } else if (widget.opcion == 2) {
                return "Regalar";
              } else if (widget.opcion == 3) {
                return "Enviar";
              } else {
                return "Solicitar";
              }
            } else {
              return "Modificar monto";
            }
          }()),
          style: TextStyle(color: Color.fromARGB(255, 27, 166, 210)),
        ),
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(3),
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
        actions: <Widget>[
          widget.editMode == 1
              ? Padding(
            padding: EdgeInsets.only(right: 0, top: 15, bottom: 3),
            child: InkWell(
              onTap: () {

              },
              borderRadius: BorderRadius.all(Radius.circular(50)),
              child: Container(
                width: 35,
                padding: EdgeInsets.all(2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Center(
                  child: Icon(
                    Icons.person_add,
                    color: Color(
                      0xffbbbbbb,
                    ),
                    size: 24,
                  ),
                ),
              ),
            ),
          ):SizedBox(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 18,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.check_circle,color:Color.fromARGB(255, 27, 166, 210) ,size: ResponsiveFlutter.of(context).fontSize(2.6),),
                            SizedBox(width: ResponsiveFlutter.of(context).scale(10),),
                            Text("Usuarios a transferir",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ) ,
                    ),
                  ],
                ),
              ),

              widget.usuarios.length > 0
                  ? Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(
                      left: widget.usuarios.length==2?7: widget.usuarios.length==1?5: 9,
                      right: 1,
                      top: ResponsiveFlutter.of(context).verticalScale(3),
                      bottom: ResponsiveFlutter.of(context).verticalScale(8)),
                  child: widget.usuarios.length > 1
                      ? ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: 1, vertical: 3),
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.usuarios.length,
                      separatorBuilder: (context,index)=>SizedBox(width: 10,),
                      itemBuilder:(context,index)=>_wlist(widget.usuarios[index]),)
                      : widget.usuarios.length == 1
                      ? Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 0, vertical: 1),
                    margin: EdgeInsets.symmetric(
                        vertical: 1, horizontal: 0),
                    width: ResponsiveFlutter.of(context).wp(100),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.grey[300], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 1),
                      elevation: 1,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: CircleAvatar(
                                    radius: ResponsiveFlutter.of(
                                        context)
                                        .hp(2.8),
                                    backgroundColor:
                                    widget.usuarios[0].type == 2
                                        ? Color.fromARGB(
                                        255, 27, 166, 210)
                                        : Color.fromARGB(
                                        255, 222, 170, 1),
                                    child: CircleAvatar(
                                      radius: ResponsiveFlutter.of(
                                          context)
                                          .hp(2.7),
                                      backgroundImage:
                                      widget.usuarios[0].imagen !=
                                          ""
                                          ? NetworkImage(
                                          widget.usuarios[0]
                                              .imagen)
                                          : null,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                    //Navigator.of(context).pop(userSelectedT);
                                  },
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(50)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: ResponsiveFlutter.of(
                                        context)
                                        .wp(8),
                                    height: ResponsiveFlutter.of(
                                        context)
                                        .wp(8),
                                    child: Icon(
                                      FontAwesome.times_circle,
                                      color: Colors.grey[500],
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Text(
                                  widget.usuarios[0].fullname,
                                  style: TextStyle(
                                      color: Colors.grey[900],
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10,
                                      fontFamily: "Roboto"),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.usuarios[0]
                                      .puntos
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.left,
                                ),
                                widget.opcion == 1
                                    ? Text(
                                  "\$" +
                                      utils.format(widget.usuarios[0]
                                          .compras),
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 10,
                                      fontWeight:
                                      FontWeight.w800),
                                  textAlign: TextAlign.left,
                                )
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ):SizedBox()


                ),
              )
                  : SizedBox(),

              Expanded(
                flex: 14,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child:Padding(
                              padding:EdgeInsets.only(left: 10,right: 10,top: 8),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.check_circle,color:Color.fromARGB(255, 27, 166, 210),size: ResponsiveFlutter.of(context).fontSize(2.6)),
                                  SizedBox(width: ResponsiveFlutter.of(context).scale(10),),
                                  Text("Monto a transferir",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ) ,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(8),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                               color: Color.fromRGBO( 21, 105, 162, 1),
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(15)),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Valor a transferir",style: TextStyle(color: Colors.white),),
                                          Text( utils.format(montofinalTransaccion()),style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                      SizedBox(
                                        height: ResponsiveFlutter.of(context).verticalScale(10),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Monto Cartera",style: TextStyle(color: Colors.white),),
                                          Text(utils.format(montoCartera()),style: TextStyle(color: Colors.white),)
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                         Padding(
                              padding:EdgeInsets.only(left: 10,right: 10,top: 8),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.check_circle,color:Color.fromARGB(255, 27, 166, 210),size: ResponsiveFlutter.of(context).fontSize(2.6),),
                                  SizedBox(width: ResponsiveFlutter.of(context).scale(10),),
                                  Text("Carteras asociadas",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                                ],
                              ),
                          ),
                          lc!=null&& lc.length<=1?Padding(
                            padding:EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context)=>selectionWoiner(opcion: widget.opcion,user: widget.usuarios,editMode: 1,)
                                  )
                                ).then((lcar){
                                  if(lcar!=null){
                                    lc=widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList():CarteraService.carteraSelected();
                                    setState(() {

                                    });
                                  }

                                });
                              },
                              child: Card(
                                color:Colors.purple[700] ,
                                margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1,vertical: 1),
                                      child: Icon(Icons.add,color: Colors.white,size: ResponsiveFlutter.of(context).scale(20),))),
                            ),
                          ):SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(2),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList().length:CarteraService.carteraSelected().length,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemBuilder: (context,int index){
                            lc=widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList():CarteraService.carteraSelected();

                            return   Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(

                                      child: Text(lc[index].name+" disponible: "+lc[index].saldoDisponible.toString(),style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),),
                                      padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).verticalScale(10)),
                                    ),

                                  ],
                                ),
                                SizedBox(height: ResponsiveFlutter.of(context).verticalScale(10),),
                                Slidable(
                                  enabled: lc.length>1? true:false,
                                  closeOnScroll: false,
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  secondaryActions: <Widget>[
                                    SlideAction(
                                      child: Text("Eliminar",style: TextStyle(color: Colors.red[300],decoration: TextDecoration.underline),),
                                      onTap: (){
                                        CarteraService.selectedCartera(lc[index]);
                                        lc= lc=widget.opcion!=1?CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList():CarteraService.carteraSelected();

                                        setState(() {
                                          
                                        });

                                      },
                                    )
                                  ],
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (context)=>MontoCartera(
                                            opcion: widget.opcion,
                                            lu: widget.usuarios,
                                            editmode: 1,
                                            carteraEdit: lc[index],
                                          )
                                        )
                                      ).then((resp){
                                        if(resp!=null){
                                          setState(() {
                                          });
                                        }
                                      });
                                    },
                                    child: Card(

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        side: BorderSide(color: Colors.grey[500],width: 0.5)
                                      ),
                                      elevation: 0,
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(15)),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(

                                                  height: ResponsiveFlutter.of(context).verticalScale(20),
                                                  width: ResponsiveFlutter.of(context).verticalScale(20),
                                                  padding:EdgeInsets.only(right: lc[index].type!=2 || lc[index].type!=3?ResponsiveFlutter.of(context).verticalScale(0.5):0,bottom: lc[index].type!=2 || lc[index].type!=3?ResponsiveFlutter.of(context).verticalScale(0.5):0),
                                                  decoration: BoxDecoration(
                                                    color: lc[index].type==3?Color.fromRGBO(182, 104, 9, .6):lc[index].type==2?Color.fromRGBO(13, 183, 203, 1):Colors.grey[300],
                                                    shape: BoxShape.circle
                                                  ),
                                                  child: Center(
                                                    child: lc[index].type==2 || lc[index].type==3 ?Text(lc[index].type==2?"Cli":"Em",style: TextStyle(color: Colors.white,fontSize: ResponsiveFlutter.of(context).fontSize(1)),):Icon(Icons.credit_card,size: ResponsiveFlutter.of(context).wp(3.5),),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ResponsiveFlutter.of(context).scale(10),
                                                ),
                                                Text("Valor a transferir",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300,fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                                              ],
                                            ),
                                            Text(utils.format(lc[index].montofinal),style: TextStyle(color: Color.fromRGBO( 21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).fontSize(2.2),fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            );
                          },
                        ),
                      ),





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
                      top:BorderSide(width: 1,color:Colors.grey[300])
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ResponsiveFlutter.of(context).wp(3)),
                      child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.close,
                                  size: 20, color: Color(0xff1ba6d2)),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).wp(3),
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
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context)=>Login(),
                                )
                            );

                            // print(username);

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                          }),
                    ),
                  ),
                  SizedBox(width: ResponsiveFlutter.of(context).wp(3)),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveFlutter.of(context).wp(3)),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Confirmar',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.0195),
                              ),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).wp(1),
                              ),
                              Icon(
                                Icons.check_circle_outline,
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
                          onPressed: () async{

                            closeModal(){
                              Navigator.of(context).pop();
                            }

                            if(existCarteraCero()){
                              showAlerts(context,"Existen carteras con monto a transferir en 0, asigne un valor o eliminela",false,closeModal, null, "Aceptar", "",null);

                            }else {
                              showDialogV2(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CustomDialogLoading());
                              if (montofinalTransaccion() == montoCartera()) {
                                for (userTransactions u in widget.usuarios) {
                                  await asignarMontoTransaccionCartera(u);
                                }
                                Navigator.of(context).pop();

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context)=>transacctionExitosa(usuarios: widget.usuarios,total_transaccion: montofinalTransaccion(),)
                                  )
                                );
                              } else
                              if (montofinalTransaccion() > montoCartera()) {
                                //FALTA PUNTOS CARTERA
                                showAlerts(context,"Monto de las carteras insuficiente para la transacción",false,closeModal, null, "Aceptar", "",null);
                              } else {
                                //SUPERA EL MONTO LA CARTERA
                                showAlerts(
                                    context,
                                    "El monto de las carteras supera al monto de la transacción",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    "",
                                    null);
                              }
                            }
                          },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],


      ),
          ),
            ],
      ),

    );
  }
}
