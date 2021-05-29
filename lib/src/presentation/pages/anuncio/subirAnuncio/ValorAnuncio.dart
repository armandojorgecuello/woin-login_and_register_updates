import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
class ValorAnuncio extends StatefulWidget {

  final precioOferta valorOferta;
  ValorAnuncio({@required this.valorOferta});
  @override
  _ValorAnuncioState createState() => _ValorAnuncioState();
}

class _ValorAnuncioState extends State<ValorAnuncio> {
  int visiblec=1;
  TextEditingController precioController;
  TextEditingController precioFinalController;
  TextEditingController descuentoController;
  TextEditingController valordescuentoController;
  TextEditingController regaloController;
  TextEditingController valorregaloController;
  TextEditingController unidadesController;
  double valordescuento=0;
  double precioFinal=0;
  double valorRegalo=0;
  bool errdescuento=false;
  bool errregalo=false;
  bool errprecio=false;
  bool errunidades=false;
  String text;
  String text1;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    precioController=TextEditingController();
    precioFinalController=TextEditingController();
    descuentoController=TextEditingController();
    valordescuentoController=TextEditingController();
    regaloController=TextEditingController();
    valorregaloController=TextEditingController();
    unidadesController=TextEditingController();
    if(widget.valorOferta!=null){
      precioController.text=widget.valorOferta.precio.toString();
      descuentoController.text=widget.valorOferta.descuento==0?"":widget.valorOferta.descuento.toString();
      regaloController.text=widget.valorOferta.regalo==0?"":widget.valorOferta.regalo.toString();
      unidadesController.text=widget.valorOferta.disponible.toString();
      precioFinal=widget.valorOferta.precioFinal;
      valorRegalo=widget.valorOferta.vregalo;
      valordescuento=widget.valorOferta.vdescuento;
    }
    
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {

      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
      // print(MediaQuery.of(context).size.height);
    });
  }

  int expandError(){
   int r=0;
   if(errprecio){
     r++;
   }
   if(errregalo){
     r++;
   }

   if(errdescuento){
     r++;
   }

   if(errunidades){
     r++;
   }
   return r;
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    descuentoController.dispose();
    regaloController.dispose();
    unidadesController.dispose();
    precioController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "precioOferta",
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
            Expanded(flex: visiblec==1? 18:18,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: visiblec==1? errunidades|| errprecio || errregalo || errdescuento? 6+expandError() :5:15,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(color: Colors.grey[300],width: 0.7)
                        ),
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Row(

                                    children: <Widget>[
                                      Text("Precio",style: TextStyle(color: Colors.grey[600]),),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child:  TextFormField(
                                            controller: precioController,
                                            onChanged: (val){

                                              if(val==""){
                                                valorRegalo=0;
                                                valorregaloController.text="Valor regalo";
                                                valordescuento=0;
                                                precioFinal=0;
                                                precioFinalController.text="Precio Final";
                                                valordescuentoController.text="Valor descuento";
                                                setState(() {   });
                                              }else{
                                                precioFinal=double.parse(val.trim());
                                                precioFinalController.text=precioFinal.toString();
                                                setState(() {

                                                });
                                              }
                                              int r=0;
                                              if(regaloController.text!=""){
                                                valorRegalo=double.parse(regaloController.text.trim())*double.parse(val.trim())/100;
                                                valorregaloController.text=valorRegalo.toString();
                                                r=1;
                                              }
                                              if(descuentoController.text!=""){
                                                valordescuento=double.parse(descuentoController.text.trim())*double.parse(val.trim())/100;
                                                valordescuentoController.text=valordescuento.toString();
                                                precioFinal=double.parse(precioController.text.trim())-valordescuento;
                                                precioFinalController.text=precioFinal.toString();
                                                r=1;
                                              }
                                              if(r==1){

                                                setState(() {   });
                                              }


                                            },

                                            validator: (val) {
                                              if(val=="" || val==null){
                                                errprecio=true;
                                                setState(() { });
                                                return "valor del artículo es requerido";

                                              }else if(val.length<2){
                                                errprecio=true;
                                                setState(() { });
                                                return "valor del artículo demasiado corto";
                                              }else if(val.startsWith("0")){
                                                errprecio=true;
                                                setState(() { });
                                                return "Precio del artículo incorrecto";
                                              }else{
                                                errprecio=false;
                                                setState(() { });
                                                return null;
                                              }

                                            },
                                            maxLength: 20,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    .018),
                                            keyboardType: TextInputType.number,
                                            autocorrect: true,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              counterText: "",
                                              contentPadding: EdgeInsets.all(10),

                                              hintText: "Precio del artículo",

                                              // fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize:
                                                  MediaQuery.of(context).size.height *
                                                      .018),
                                              enabledBorder: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide:
                                                  BorderSide(color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                              ),
                                              focusedBorder: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide:
                                                  BorderSide(color: Colors.grey[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                              ),
                                              errorBorder: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide:
                                                  BorderSide(color: Colors.red[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                              ),
                                              focusedErrorBorder: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)),
                                                  borderSide:
                                                  BorderSide(color: Colors.red[500])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                              ),

                                              // labelText: 'Correo'
                                            ),
                                          ),

                                          
                                        
                                      ),


                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Row(

                                    children: <Widget>[
                                    Expanded(
                                      child: Text("% Descuento",style: TextStyle(color: Colors.grey[600]),),
                                    ),
                                      SizedBox(
                                        width: ResponsiveFlutter.of(context).scale(15),
                                      ),
                                      Expanded(
                                        child: Text("Valor Descuento",style: TextStyle(color: Colors.grey[600]),),
                                      ),



                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        //height:ResponsiveFlutter.of(context).verticalScale(36),
                                        child: TextFormField(
                                          controller: descuentoController,
                                          onChanged: (val){
                                            if(val==""){
                                              val="0";
                                            }
                                            double valor=double.parse(val.trim());
                                            if(valor<=100){
                                              text1=val;
                                              if(text1=="0"){
                                                precioFinal=double.parse(precioController.text);
                                                precioFinalController.text=precioFinal.toString();
                                                valordescuento=0;
                                                valordescuentoController.text="Valor descuento";
                                                setState(() {

                                                });
                                              }else
                                              if(precioController.text!=""){
                                                valordescuento=double.parse(precioController.text.trim())*double.parse(val.trim())/100;
                                                valordescuentoController.text=valordescuento.toString();
                                                precioFinal=double.parse(precioController.text)-valordescuento;
                                                precioFinalController.text=precioFinal.toString();
                                                setState(() {

                                                });
                                              }

                                            }else{
                                             descuentoController.value = new TextEditingValue(
                                                  text: text1,
                                                  selection: new TextSelection(
                                                      baseOffset: text1.length,
                                                      extentOffset: text1.length,
                                                      affinity: TextAffinity.downstream,
                                                      isDirectional: false),
                                                  composing: new TextRange(start: 0, end: 0));

                                            }




                                          },

                                          validator: (val) {
                                            if(val.startsWith("0")){
                                              errdescuento=true;
                                              setState(() {

                                              });
                                              return "Descuento incorrecto";

                                            }else{
                                              errdescuento=false;
                                              setState(() {

                                              });
                                              return null;
                                            }

                                          },
                                          maxLength: 3,

                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  .018),
                                          keyboardType: TextInputType.number,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            counterText: "",

                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "% descuento ",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    .018),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[300])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            errorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedErrorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ResponsiveFlutter.of(context).scale(15),
                                      ),
                                      Expanded(
                                        child:Column(
                                          children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                              Expanded(
                                               child: TextFormField(






                                                  style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize:
                                                      MediaQuery.of(context).size.height *
                                                          .018),
                                                  keyboardType: TextInputType.number,
                                                  autocorrect: true,
                                                  autofocus: false,
                                                  enabled: false,


                                                  decoration: InputDecoration(
                                                    fillColor: Colors.grey[100],
                                                    filled: true,
                                                    isDense: true,
                                                    counterText: "",

                                                    contentPadding: EdgeInsets.all(10),

                                                    hintText: "Valor descuento ",
                                                    enabled: false,


                                                    // fillColor: Colors.white,
                                                    labelStyle: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize:
                                                        MediaQuery.of(context).size.height *
                                                            .018),
                                                    enabledBorder: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0)),
                                                        borderSide:
                                                        BorderSide(color: Colors.grey[300])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                    ),
                                                    disabledBorder: new OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                                  borderSide:
                                                  BorderSide(color: Colors.grey[300])
                                                // borderSide: new BorderSide(color: Colors.teal)
                                              ),
                                                    focusedBorder: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0)),
                                                        borderSide:
                                                        BorderSide(color: Colors.grey[500])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                    ),
                                                    errorBorder: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0)),
                                                        borderSide:
                                                        BorderSide(color: Colors.red[500])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                    ),
                                                    focusedErrorBorder: new OutlineInputBorder(
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(5.0)),
                                                        borderSide:
                                                        BorderSide(color: Colors.red[500])
                                                      // borderSide: new BorderSide(color: Colors.teal)
                                                    ),

                                                    // labelText: 'Correo'
                                                  ),

                                                 controller: valordescuentoController,
                                                 readOnly: true,
                                                ),
                                              ),
                                             ],
                                           ),
                                            errdescuento?SizedBox(height: 22,):SizedBox()
                                          ],
                                        ),

                                            
                                        
                                      ),


                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Precio final",style: TextStyle(color: Colors.grey[600]),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child:TextFormField(






                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  .018),
                                          keyboardType: TextInputType.number,
                                          autocorrect: true,
                                          autofocus: false,
                                          enabled: false,


                                          decoration: InputDecoration(
                                            fillColor: Colors.grey[100],
                                            filled: true,
                                            isDense: true,
                                            counterText: "",

                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Precio final",
                                            enabled: false,


                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    .018),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[300])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            disabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[300])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            errorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedErrorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),

                                            // labelText: 'Correo'
                                          ),

                                          controller: precioFinalController,
                                          readOnly: true,
                                        ),


                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Row(

                                    children: <Widget>[
                                      Expanded(
                                        child: Text("% Regalo",style: TextStyle(color: Colors.grey[600]),),
                                      ),
                                      SizedBox(
                                        width: ResponsiveFlutter.of(context).scale(15),
                                      ),
                                      Expanded(
                                        child: Text("Valor regalo",style: TextStyle(color: Colors.grey[600]),),
                                      ),



                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          controller: regaloController,
                                          onChanged: (val){
                                            if(val==""){
                                              val="0";
                                            }

                                            double valor=double.parse(val);
                                            if(valor<=100){
                                              text=val;
                                              if(val=="0"){
                                                valorRegalo=0;
                                                valorregaloController.text="Valor regalo";
                                                setState(() {

                                                });
                                              }else
                                              if(precioController.text!=""){
                                                valorRegalo=double.parse(precioController.text.trim())*double.parse(val.trim())/100;
                                                valorregaloController.text= valorRegalo.toString();
                                                setState(() {

                                                });
                                              }
                                            }else{
                                              regaloController.value = new TextEditingValue(
                                                  text: text,
                                                  selection: new TextSelection(
                                                      baseOffset: text.length,
                                                      extentOffset: text.length,
                                                      affinity: TextAffinity.downstream,
                                                      isDirectional: false),
                                                  composing: new TextRange(start: 0, end: 0));
                                            }
                                           

                                          },

                                          validator: (val) {
                                            if(val.startsWith("0")){
                                              errregalo=true;
                                              setState(() {

                                              });
                                              return "% requerido";
                                            }else{
                                              errregalo=false;
                                              setState(() {

                                              });
                                              return null;
                                            }

                                          },
                                          maxLength: 3,

                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  .018),
                                          keyboardType: TextInputType.number,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            counterText: "",

                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "% regalo",

                                            // fillColor: Colors.white,
                                            labelStyle: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize:
                                                MediaQuery.of(context).size.height *
                                                    .018),
                                            enabledBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[300])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.grey[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            errorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),
                                            focusedErrorBorder: new OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0)),
                                                borderSide:
                                                BorderSide(color: Colors.red[500])
                                              // borderSide: new BorderSide(color: Colors.teal)
                                            ),

                                            // labelText: 'Correo'
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: ResponsiveFlutter.of(context).scale(15),
                                      ),
                                      Expanded(
                                        child:Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child:  TextFormField(
                                                    controller: valorregaloController,
                                                    readOnly: true,







                                                    style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize:
                                                        MediaQuery.of(context).size.height *
                                                            .018),
                                                    keyboardType: TextInputType.number,
                                                    autocorrect: true,
                                                    autofocus: false,
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[100],
                                                      enabled: false,
                                                      isDense: true,
                                                      counterText: "",

                                                      contentPadding: EdgeInsets.all(10),

                                                      hintText: "Valor regalo",

                                                      // fillColor: Colors.white,
                                                      labelStyle: TextStyle(
                                                          color: Colors.grey[400],
                                                          fontSize:
                                                          MediaQuery.of(context).size.height *
                                                              .018),
                                                      enabledBorder: new OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)),
                                                          borderSide:
                                                          BorderSide(color: Colors.grey[300])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                      focusedBorder: new OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)),
                                                          borderSide:
                                                          BorderSide(color: Colors.grey[500])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                      errorBorder: new OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)),
                                                          borderSide:
                                                          BorderSide(color: Colors.red[500])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                      disabledBorder:  new OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)),
                                                          borderSide:
                                                          BorderSide(color: Colors.grey[300])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                      ),
                                                      focusedErrorBorder: new OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)),
                                                          borderSide:
                                                          BorderSide(color: Colors.red[500])
                                                        // borderSide: new BorderSide(color: Colors.teal)
                                                      ),

                                                      // labelText: 'Correo'
                                                    ),

                                                  ),
                                                ),
                                              ],
                                            ),
                                            errregalo?SizedBox(height: 22,):SizedBox()
                                          ],
                                        ),



                                      ),


                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: visiblec==1?3:0,child: SizedBox(),)
                  ],
                ),
              ),


            ),
            Expanded(
              flex: visiblec == 1 ? 2 : 3,
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
                              var form=_formKey.currentState;

                              if(form.validate()){

                               // Navigator.of(context).pop(infoO);
                                precioOferta po=precioOferta(
                                  descuento: descuentoController.text!=""?double.parse(descuentoController.text):0,
                                  disponible: 0,
                                  precio: double.parse(precioController.text),
                                  precioFinal: precioFinal,
                                  regalo: regaloController.text!=""?double.parse(regaloController.text):0,
                                  vdescuento: valordescuento,
                                  vregalo: valorRegalo
                                );
                                Navigator.of(context).pop(po);
                              }else{
                                closeModal(){
                                  Navigator.of(context).pop();
                                }
                                showAlerts(context, "Los campos son requeridos", false, closeModal,null, "Aceptar", "",null);
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
