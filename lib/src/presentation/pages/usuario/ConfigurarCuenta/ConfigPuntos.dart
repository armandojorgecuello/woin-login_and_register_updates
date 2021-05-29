import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';

class ConfigPuntos extends StatefulWidget {
  @override
  _ConfigPuntosState createState() => _ConfigPuntosState();
}

class _ConfigPuntosState extends State<ConfigPuntos> {
  int visiblec = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //KeyboardVisibilityNotification().addNewListener(onChange: (bool visible)
    //{
    //  //print("ACA CARE VERGA");
    //  setState(() {
    //    visiblec = visible ? 0 : 1;
    //    //print(visiblec);
    //  });
    //});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Configurar regalar puntos",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 17),),
        leading: Container(
          width: 30,
          child:InkWell(

            onTap: () {
              Navigator.of(context).pop();

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
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 18,
              child:DefaultTabController(

                  length: 2,
                child: Column(
                  children: <Widget>[
                    TabBar(
                      labelColor: Color(0xff1ba6d2),
                      tabs: [
                        Tab(text: "Botón pagar",),
                        Tab(text: "Botón regalar",),

                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Column(
                            children: <Widget>[
                             visiblec==1? Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                      child: Text("Establezca el porcentaje para regalar puntos",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),)
                                ],
                              ):SizedBox.shrink(),
                              visiblec==1?Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: "Cuando un usuario utilice el botón pagar con puntos, la aplicacion viene predeterminada para regalar mínimo el cinco por ciento(5%) en puntos por compras menores a un millón (1.000.000) y el"+
                                          " dos por ciento(2%) por compras superiores a un millón (1.000.000) hasta diez millones (10.000.000), usted puede modificar dicha condición y agregar un máximo de 5 condiciones o parámetrod siempre y cuando"+
                                          "incremente el porcentaje a regalar",style: TextStyle(color: Colors.grey[400],fontSize: 12)),

                                    ],
                                  ),
                                ),
                              ):SizedBox.shrink(),
                              SizedBox(height: 40,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Porcentaje a regalar %",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Compras mínimas",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Compras máximas",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              visiblec==1?  Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: 'Cuando un usuario realice pagos en ',style: TextStyle(color: Colors.grey[400],fontSize: 12)),
                                      TextSpan(text: 'Efectivo', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[400],fontSize: 12),),
                                      TextSpan(text: ', no es obligatorio regalar puntos, por ende es voluntario si usted considera viable establecer una o mas condiciones para regalar puntos por compras en efectivo',style: TextStyle(color: Colors.grey[400],fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ):SizedBox.shrink(),
                              SizedBox(height: 30,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Porcentaje a regalar %",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Compras mínimas",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child:  TextFormField(

                                        maxLength: 12,
                                        maxLines: 1,
                                        //controller: codigoController,
                                        style: TextStyle(
                                            color: Color(0xfc979797),
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.018),
                                        keyboardType: TextInputType.number,
                                        autocorrect: true,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          labelText: "Compras máximas",
                                          isDense: true,
                                          //suffixIcon: Icon(Icons.help,color: Colors.grey[400],),
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.red[600])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          errorStyle: TextStyle(
                                              fontSize: ResponsiveFlutter.of(
                                                  context)
                                                  .fontSize(1.5)),
                                          contentPadding: EdgeInsets.all(10),



                                          // fillColor: Colors.white,
                                          labelStyle: TextStyle(
                                              color: Color(0xfc979797)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),
                                          focusedBorder: new OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[500])
                                            // borderSide: new BorderSide(color: Colors.teal)
                                          ),

                                          // labelText: 'Correo'
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
          Expanded(
              flex: visiblec==1?2:3,
              child:Container(
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
                                  'Cerrar',
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context)=>TabMain(),
                                  )
                              );

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
                                  'Guardar',
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

//BOTON PAGAR************
//PORCENTAJE A REGALAR
//COMPRAS MINIMAS
//COMPRAS MAXIMAS

/* BOTON PAGAR
*Cuando un usuario utilice el botón pagar con puntos, la aplicacion viene predeterminada para regalar mínimo el cinco por ciento(5%) en puntos por compras menores a un millón (1.000.000) y el
* dos por ciento(2%) por compras superiores a un millón (1.000.000) hasta diez millones (10.000.000), usted puede modificar dicha condición y agregar un máximo de 5 condiciones o parámetrod siempre y cuando
* incremente el porcentaje a regalar
 */

/* BOTON REGALAR
*Cuando un usuario realice pagos en Efectivo, no es obligatorio regalar puntos, por ende es voluntario si usted considera viable establecer una o mas condiciones
* para regalar puntos por compras en efectivo
 */