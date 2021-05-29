import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';

class AddAttribute extends StatefulWidget {
  final  List<atributosProducto> atributos;
  AddAttribute({this.atributos});
  @override
  _AddAttributeState createState() => _AddAttributeState();
}

class _AddAttributeState extends State<AddAttribute> {
  TextEditingController atributoController;
  List<atributosProducto> atributos;
  int visiblec=1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    atributoController=TextEditingController();
    atributos=List();
    KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          //print("ACA CARE VERGA");
          setState(() {
            visiblec = visible ? 0 : 1;
            //print(visiblec);
          });
          // print(MediaQuery.of(context).size.height);
        });
    if(widget.atributos.length>0){
     for(atributosProducto ap in widget.atributos){
       atributosProducto a=atributosProducto(titulo: ap.titulo);
       atributos.add(a);
     }

    }

  }

  void deleteAttribute(atributosProducto atr){
    if(atributos.length>0){
      for(atributosProducto a in atributos){
        if(a.titulo==atr.titulo){
          atributos.remove(a);
          break;
        }
      }
    }
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        title: Text("Atributos",style: TextStyle(
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
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 18,
              child: Padding(
                padding: EdgeInsets.only(left: 10,bottom:1,right: 10,top: 10 ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Nombre del atributo",style: TextStyle(color: Colors.grey[600]),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(10)),
                        child: TextField(
                          controller: atributoController,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: MediaQuery.of(context).size.height * .018),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: true,
                          autofocus: false,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            isDense: true,

                           // prefixIcon:  Icon(Icons.person_outline, color: Colors.grey[500]),
                            hintText: 'Nombre del atributo',

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

                            // labelText: 'Correo'
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              width: ResponsiveFlutter.of(context).wp(36),
                              child: RaisedButton(


                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.add_circle_outline,color: Color(0xff1ba6d2),),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Agregar',
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          color: Color(0xff1ba6d2),
                                          fontSize: ResponsiveFlutter.of(context)
                                              .fontSize(1.75),
                                        ),
                                      ),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(color: Color(0xff1ba6d2))),
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * .01,
                                      bottom:
                                      MediaQuery.of(context).size.height * .01),
                                  color: Colors.white,
                                  elevation: 0,
                                  onPressed: () {
                                    if(atributoController.text!="" && atributoController.text!=null){
                                      atributosProducto at=atributosProducto(titulo: atributoController.text);
                                      atributos.add(at);
                                      atributoController.text="";
                                      setState(() {

                                      });
                                    }
                                    else{
                                      closeModal(){
                                        Navigator.of(context).pop();
                                      }
                                      showAlerts(context, "Ingrese nombre del atributo", false, closeModal,null, "Aceptar", "", null);
                                    }


                                  }),
                            ),
                          ],
                        ),
                      ),
                     Padding(
                       padding: EdgeInsets.only(top: 5,bottom: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           Text("Atributos agregados",style: TextStyle(color: Colors.grey[600]),),
                         ],
                       ),
                     ),
                   atributos.length>0? Container(
                      alignment:Alignment.centerLeft,
                      child: Wrap(
                               direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,

                              children: atributos.map((a){return Container(

                                margin:EdgeInsets.only(right: 12,bottom: 15,left: 0),
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child:Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(a.titulo,style: TextStyle(color: Colors.grey[700]),),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                       onTap: (){
                                         deleteAttribute(a);
                                       },
                                        child: Icon(Icons.cancel,size:20,color: Colors.grey[700],))
                                  ],
                                ),);}).toList()
                            ),
                    ):Padding(
                     padding: EdgeInsets.only(top: 15),
                      child: Row(
                       children: <Widget>[
                         Icon(Icons.info_outline,color: Colors.grey[600],),
                         SizedBox(width: 10,),
                         Text("No se ha agregado atributos a su producto",style: TextStyle(color: Colors.grey[600]),),
                       ],
                   ),
                    ),


                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: visiblec==0? 3:2,
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

                              if(atributos.length==0){
                                closeModal() {
                                  Navigator.of(context).pop();
                                }
                                showAlerts( context, "Agregue atributos a su producto", false,closeModal, null,"Aceptar","", null);
                              }else{
                                print(atributos.length);
                                Navigator.of(context).pop(atributos);
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
        ),
      ),
    );
  }
}
