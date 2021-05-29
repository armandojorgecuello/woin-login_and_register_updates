import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Cartera/Cartera.dart';
import 'package:woin/src/entities/Transactions/Transaccion.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/transactions/steps/confirmTransactions.dart';
import 'package:woin/src/presentation/pages/transactions/transactionPpal.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/empresaWoiner.dart';
import 'package:woin/src/services/CarteraService/carteraService.dart';
import 'package:woin/src/services/Transactions/TransactionsService.dart';

class MontoCartera extends StatefulWidget {
  final int opcion;
  final int editmode;
  final List<userTransactions> lu;
  final Cartera carteraEdit;
  MontoCartera({this.opcion,this.editmode,this.lu,this.carteraEdit});
  @override
  _MontoCarteraState createState() => _MontoCarteraState();
}

class _MontoCarteraState extends State<MontoCartera> {
  List<TextEditingController> lcontroller=[];
  final _formkey=GlobalKey<FormState>();
  Utilities utils=Utilities();
  TransctionsService ts=TransctionsService();
  int visiblec=1;
  List<Cartera>lc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final formatter = new NumberFormat("#,##0","es_AR");

    List<Cartera>lc= widget.opcion==1?CarteraService.carteraSelected():CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList();
    for(int i=0;i<lc.length;i++){
      TextEditingController controller=new TextEditingController();
      if(widget.editmode==1){
        String newText = formatter.format(widget.carteraEdit.montofinal );
        controller.text=newText;
      }
      lcontroller.add(controller);
    }
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      //print("ACA CARE VERGA");
      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
      // print(MediaQuery.of(context).size.height);
    });
  }




  double calcularMontoaTransferir(){
    double totalmonto=0;
    for(userTransactions u in widget.lu){
      totalmonto+=u.puntos;
    }
    return totalmonto;
  }

  double montoTotalCarteras(){
    double totalmonto=0;
   if(lc!=null) {
     for (Cartera c in lc) {
       totalmonto += c.valortransferir;
     }
   }
    return totalmonto;
  }
  
  double saldoDiferencia(){
    double valor=calcularMontoaTransferir()-montoTotalCarteras();
    return valor;
  }

  void limpiarCarteras(){
    if(lc!=null) {
      for (Cartera c in lc) {
        c.valortransferir=0;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(0),
              splashColor: Colors.white,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.chevron_left,
                size: 25,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
              onPressed: () {
               limpiarCarteras();

                Navigator.of(context).pop();

              },
            );
          }),
        ),
        title: Text(this.widget.editmode==0?this.widget.opcion==1?"Pagar":this.widget.opcion==2?"Regalar":this.widget.opcion==3?"Prestar":"Solicitar":"Monto cartera",style: TextStyle(color:Color(0xff1ba6d2),),),
      ),
      body: Column(
        children: <Widget>[

          Expanded(
            flex: 18,
            child:Column(
              children:<Widget>[
                Expanded(
                  flex: visiblec==0? 2:1,
                  child: Container(
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Color.fromRGBO(
                            21, 105, 162, 1),
                        child:Padding(
                            padding:EdgeInsets.symmetric(horizontal:12,vertical: 5),
                            child: Column(
                              children: <Widget>[
                                Expanded(flex:1,
                                  child: Row(

                                    children: <Widget>[
                                      Text("Valor total de transacción",style:TextStyle(color:Colors.white)),

                                    ],
                                  ),
                                ),
                                Expanded(flex:4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only( right: 8,  left: 0),
                                        child: InkWell(

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
                                                    () {
                                                  if (widget.opcion == 1) {
                                                    return Icons.account_balance_wallet;
                                                  } else if (widget.opcion == 2) {
                                                    return Icons.card_giftcard;
                                                  } else if (widget.opcion == 3) {
                                                    return Icons.send;
                                                  } else {
                                                    return Icons.reply_all;
                                                  }
                                                }(),
                                                color: Colors.white, size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text( utils.format( calcularMontoaTransferir()  ),style:TextStyle(color:Colors.white,fontSize: 28))
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(10),
                ),
                Divider(color: Colors.grey[500],),
                Expanded(
                  flex: 5,
                  child: Form(
                    key:_formkey ,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      itemCount: widget.opcion==1?CarteraService.carteraSelected().length+1:CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList().length+1,
                      itemBuilder: (context,int index){
                       lc= widget.opcion==1?CarteraService.carteraSelected():CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList();

                        if(index==0){
                          return Card(
                            elevation: 0,
                            margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(10)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                width: 0.5,
                                color: Color(0xff1ba6d2)
                              )
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Detalle transacción",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Monto total cartera",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300),),
                                      Text(widget.editmode==0?  utils.format(montoTotalCarteras()): utils.format(widget.carteraEdit.montofinal),style: TextStyle(color:Color.fromRGBO(21, 105, 162, 1),fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              widget.editmode==0?  Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Saldo diferencia",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300),),
                                      Text(utils.format(saldoDiferencia()),
                                        style: TextStyle(
                                          color: saldoDiferencia()==0? Colors.grey[500]:saldoDiferencia()>0?Colors.red[300]:Colors.purple[300]
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ):SizedBox(),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(10),
                                )
                              ],
                            ),
                          );
                        }
                       return  widget.editmode==0 || (widget.editmode==1 && widget.carteraEdit.type==lc[index-1].type)? Card(
                          margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(15)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                              color: Colors.grey[400],
                              width: 0.5
                            )
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text( lc[index-1].type==2 || lc[index-1].type==3?"Cartera "+lc[index-1].name: lc[index-1].name,style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                                        SizedBox(width: ResponsiveFlutter.of(context).scale(10),),
                                       InkWell(
                                            child: Icon(Icons.check_circle_outline,color: Color(0xff1ba6d2),
                                            ),
                                        ),
                                      ],
                                    ),
                                      widget.editmode==0?   InkWell(
                                      onTap: (){
                                          CarteraService.selectedCarter.add(lc[index-1]);
                                          setState(() {

                                          });
                                      },
                                          child: Icon(Icons.cancel,color: Colors.grey[400],),
                                      ):SizedBox(),
                                    ],
                                  ),
                                ),
                                lc[index-1].type==2 || lc[index-1].type==3? Row(
                                  children: <Widget>[
                                    Padding(
                                        padding:EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                        child: Text("Disponible",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w300),))
                                  ],
                                ):SizedBox(),
                                lc[index-1].type==2 || lc[index-1].type==3?   Row(
                                  children: <Widget>[
                                    Padding(
                                        padding:EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                        child: Text(utils.format(lc[index-1].saldoDisponible),style: TextStyle(color:Color.fromRGBO(
                                            21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).fontSize(3.5),fontWeight: FontWeight.w400),)),
                                  ],
                                ):SizedBox(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric( horizontal:   ResponsiveFlutter.of(context).wp(3),vertical: 10),
                                        child: Container(

                                          child: TextFormField(

                                            onChanged: (valor){
                                              valor=valor==""?"0":valor;
                                              if(valor!=""){
                                                valor=valor.replaceAll('.', '');
                                                lc[index-1].valortransferir=double.parse(valor);
                                                if(widget.editmode==1){
                                                  widget.carteraEdit.valortransferir=double.parse(valor);
                                                  widget.carteraEdit.montofinal=double.parse(valor);
                                                }

                                              }
                                              setState(() {
                                                
                                              });

                                            },
                                            maxLines: 1,
                                            maxLength: 12,

                                            validator: (valor){

                                              if(lc[index-1].type==2 || lc[index-1].type==3){
                                                valor=valor.replaceAll('.', '');
                                                if(valor==""|| valor=="0"|| valor.startsWith("0")){
                                                  return "monto incorrecto";

                                                }else if(double.parse(valor)>lc[index-1].saldoDisponible){
                                                  return "Monto supera el saldo de esta cartera";
                                                }else{
                                                  return null;
                                                }
                                              }else{
                                                return null;
                                              }

                                            },
                                            controller: lcontroller[index-1] ,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter.digitsOnly,

                                              CurrencyPtBrInputFormatter(maxDigits:12)
                                            ],
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: MediaQuery.of(context).size.height * .021),
                                            keyboardType: TextInputType.number,
                                            autocorrect: true,
                                            autofocus: false,

                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(10),

                                                prefixIcon:
                                                Icon(Icons.attach_money, color: Colors.grey[500]),
                                                counterText: "",
                                                isDense: true,


                                                // fillColor: Colors.white,

                                                labelStyle: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: MediaQuery.of(context).size.height * .018),
                                                enabledBorder: new OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                    borderSide: BorderSide(color: Colors.grey[300])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                                focusedBorder: new OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                    borderSide: BorderSide(color: Colors.grey[500])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                                errorBorder: new OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                    borderSide: BorderSide(color: Colors.red[300])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                ),
                                                focusedErrorBorder:  new OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                                    borderSide: BorderSide(color: Colors.red[300])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                ),

                                                hintText: lc[index-1].type==2 || lc[index-1].type==3? "valor a transferir":"Efectivo"
                                            ),


                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ):
                       SizedBox();
                      },
                    ),
                  ),
                ),

              ] ,
            ),

          ),
          Expanded(
            flex: visiblec==0?3: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
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
                          ),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            Navigator.pop(context);

                            // print(username);

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveFlutter.of(context).wp(3)),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
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
                                    ResponsiveFlutter.of(context).hp(2)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 8,
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
                           final form= _formkey.currentState;
                           if(form.validate()){
                             if(widget.editmode==0){
                               List<Cartera>lc= widget.opcion==1?CarteraService.carteraSelected():CarteraService.carteraSelected().where((car)=>car.type==2 || car.type==3).toList();
                               //MONTOS A TRANSFERIR
                               for(int i=0; i<lc.length;i++){
                                 String value=lcontroller[i].text.replaceAll('.', '');
                                 lc[i].valortransferir= double.parse(value);
                                 lc[i].montofinal= double.parse(value);
                               }

                               //VALIDAR MONTOS ASIGNADOS A CARTERAS
                               int r=1;
                               for(int i=0; i<lc.length;i++){
                                 if(lc[i].valortransferir==0){
                                   r=0;
                                   break;
                                 }
                               }
                               closeModal(){
                                 Navigator.of(context).pop();
                               }

                               if(r==1){
                                 //VALIDAR MONTO A TRANSFERIR
                                 double sd=saldoDiferencia();
                                 if(sd>0){
                                   showAlerts(context, "Monto de las carteras insuficiente para la transacción", false, closeModal, null, "Aceptar", "", null);
                                 }else if(sd<0){
                                   showAlerts(context, "El monto de las carteras supera al monto de la transacción", false, closeModal, null, "Aceptar", "", null);
                                 }else{



                                   /*  for(Transaccion t in ts.listaTransacciones){
                                   print(t.carteraOrigen.toString() +"-----"+t.carteraDestino.toString()+": MONTO=>"+t.monto.toString());
                                 }*/

                                   Navigator.of(context).push( CupertinoPageRoute( builder: (context)=> ConfirmTransactions(opcion: widget.opcion,editMode: 0,usuarios: widget.lu,)));

                                 }
                               }else{
                                 showAlerts(context, "Carteras con valor a transferir de 0, eliminela o asigne valor", false, closeModal, null, "Aceptar", "", null);

                               }

                             }else{
                               Navigator.of(context).pop(widget.carteraEdit);
                             }


                           }else{
                             print("ERRORES");
                           }

                          },
                        ),
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
