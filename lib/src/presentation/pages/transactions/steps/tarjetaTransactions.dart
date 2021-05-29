import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Cartera/Franquicia.dart';
import 'package:woin/src/services/CarteraService/carteraService.dart';
class addTarjeta extends StatefulWidget {
  final int editmode;

  addTarjeta({this.editmode=0});
  @override
  _addTarjetaState createState() => _addTarjetaState();
}

class _addTarjetaState extends State<addTarjeta> {
  TextEditingController nombreController;
  TextEditingController numeroTarjetaController;
  TextEditingController valorController;
  String fechaVencimiento;

  DateFormat dt=DateFormat("dd-MM-yyyy");
  int visiblec=1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombreController=TextEditingController();
    numeroTarjetaController=TextEditingController();
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      //print("ACA CARE VERGA");
      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
      // print(MediaQuery.of(context).size.height);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nombreController.dispose();
    fechaVencimiento=null;
    numeroTarjetaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar",style: Theme.of(context).textTheme.title,),
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
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            flex: visiblec ==1?18:20,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: ResponsiveFlutter.of(context).verticalScale(15)),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                   Padding(
                     padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(10)),
                     child: Row(
                       children: <Widget>[
                         Expanded(
                         flex:1,
                         child: Text("+ Agregar tarjeta", style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
                       ),],
                     ),
                   ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(18),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 36,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400],width: 0.5),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Seleccione país de procedencia de su tarjeta",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                                Icon(Icons.chevron_right,color: Colors.grey[600],size: ResponsiveFlutter.of(context).scale(25),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(15),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 36,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400],width: 0.5),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Seleccione banco de su tarjeta",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                                Icon(Icons.chevron_right,size: ResponsiveFlutter.of(context).scale(25),color: Colors.grey[600],)
                              ],
                            ),

                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(18),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(10)),
                      child: Row(
                        children: <Widget>[
                          Text("Seleccione franquicia",style: TextStyle(color:Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.9)),),
                        ],
                      ),
                    ),

                        Container(
                            padding: EdgeInsets.only(left: 5),
                          height: ResponsiveFlutter.of(context).verticalScale(100),
                          child: StreamBuilder(
                            stream: CarteraService.FranquiciaList,
                            builder: (BuildContext context,AsyncSnapshot<List<Franquicia>> snapshot){
                              return snapshot.hasData?
                              ListView.builder(
                                padding: EdgeInsets.only(left: 5),
                                itemCount: snapshot.data.length,
                                itemBuilder:(_,int index){
                                  return InkWell(
                                    onTap: (){
                                      CarteraService.selectedFranquicia.add(snapshot.data[index]);

                                    },
                                    child: Card(
                                      margin: EdgeInsets.only(right: 15,bottom: 15,top: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(color: snapshot.data[index].selected==1?Color(0xff1ba6d2):Colors.white,width: 0.8)
                                      ),

                                      elevation: 3,
                                      child:
                                         Padding(
                                           padding: EdgeInsets.symmetric(horizontal: 18,vertical: 25),
                                           child: Container(

                                            width: ResponsiveFlutter.of(context).scale(50),
                                            decoration: BoxDecoration(
                                              image:DecorationImage(
                                                image: NetworkImage(snapshot.data[index].urlImg),
                                                fit: BoxFit.fill
                                              )
                                            ),
                                             child: SizedBox(),
                                        ),
                                         ),

                                    ),
                                  );
                                } ,
                                scrollDirection: Axis.horizontal,
                              ):Center(
                                child: CircularProgressIndicator(),
                              );
                            },

                          )

                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(10)),
                      child: Row(
                        children: <Widget>[
                          Text("Nombre como aparece en la tarjeta",style: TextStyle(color:Colors.grey[700],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(5),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 36,

                            child: TextFormField(
                              controller: nombreController,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: MediaQuery.of(context).size.height * .018),
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),

                                prefixIcon:
                                Icon(Icons.person_outline, color: Colors.grey[500]),
                                hintText: "Nombre del titular",
                                hintStyle:TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * .017
                                ) ,

                                // fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: MediaQuery.of(context).size.height * .018),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[300])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[500])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),

                                // labelText: 'Correo'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(10)),
                      child: Row(
                        children: <Widget>[
                          Text("Número de tarjeta de crédito",style: TextStyle(color:Colors.grey[700],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(5),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 36,

                            child: TextFormField(
                              controller: numeroTarjetaController,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: MediaQuery.of(context).size.height * .018),
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),

                                prefixIcon:
                                Icon(Icons.credit_card, color: Colors.grey[500]),
                                hintText: "Número de tarjeta",
                                hintStyle:TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * .017
                                ) ,

                                // fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: MediaQuery.of(context).size.height * .018),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[300])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[500])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),

                                // labelText: 'Correo'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(15),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(10)),
                      child: Row(
                        children: <Widget>[
                          Expanded( flex:4,child:
                          Row(
                            children: <Widget>[
                              Text("Fecha de Vencimiento",style: TextStyle(color:Colors.grey[700],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).scale(5),
                              ),
                              Icon(Icons.info,color: Colors.grey[500],size: ResponsiveFlutter.of(context).scale(20))
                            ],
                          ),
                          ),
                          Expanded( flex:2,child:
                          Row(
                            children: <Widget>[
                              Text("CVC",style: TextStyle(color:Colors.grey[700],fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).scale(5),
                              ),
                              Icon(Icons.info,color: Colors.grey[500],size: ResponsiveFlutter.of(context).scale(20),)
                            ],
                          ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveFlutter.of(context).verticalScale(5),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex:5,
                          child: InkWell(
                            onTap: (){
                              showDatePicker(context: context, initialDate:DateTime.now(), firstDate:DateTime(2020,12,12), lastDate: DateTime(2030,3,5)).then((fecha){
                                if(fecha!=null){
                                  fechaVencimiento=dt.format(fecha);
                                  setState(() {

                                  });
                                }
                              });
                            },
                            child: Container(
                              height: 36,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[400],width: 0.5),
                                    borderRadius: BorderRadius.circular(50)
                                ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(Icons.calendar_today,color: Colors.grey,size: 15,),
                                      SizedBox(width: ResponsiveFlutter.of(context).scale(5),),
                                      Text(fechaVencimiento==null?"Mes/Año":fechaVencimiento,style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),)
                                    ],
                                  ),
                                  Icon(Icons.keyboard_arrow_down,color: Colors.grey[600],)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveFlutter.of(context).scale(13),
                        ),
                        Expanded(
                          flex:3,
                          child: Container(
                            height: 36,

                            child: TextFormField(
                              controller: numeroTarjetaController,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: MediaQuery.of(context).size.height * .015),
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: false,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(0),

                                prefixIcon:
                                Icon(Icons.lock_outline, color: Colors.grey[500],size: 15,),
                               // suffixIcon: Icon(Icons.help,color: Colors.grey[500],size: 15,),
                                hintText: "3 dígitos",
                                hintStyle:TextStyle(
                                    fontSize: MediaQuery.of(context).size.height * .016
                                ) ,

                                // fillColor: Colors.white,
                                labelStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: MediaQuery.of(context).size.height * .018),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[300])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),
                                focusedBorder: new OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(color: Colors.grey[500])
                                  // borderSide: new BorderSide(color: Colors.teal)
                                ),

                                // labelText: 'Correo'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: visiblec ==1?2:4,
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
