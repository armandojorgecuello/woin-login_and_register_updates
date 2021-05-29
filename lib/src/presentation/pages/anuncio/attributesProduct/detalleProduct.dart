import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:woin/src/entities/anuncio/Colors.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/ColoresSelection.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/services/Anuncio/ColorService.dart';

class detalleProductP extends StatefulWidget {
  final  List<atributosProducto> atributos;
  final  List<valorAtributos> latrib;
  final int editmode;
  final valorAtributos valoresEdit;
  detalleProductP({this.atributos,this.editmode=0,this.valoresEdit=null,this.latrib=null});
  @override
  _detalleProductPState createState() => _detalleProductPState();
}

class _detalleProductPState extends State<detalleProductP> {
  List<TextEditingController> controllers;
  TextEditingController cantidadController;
  List<atributosProducto> atributosText;
  ColorsD coloresSelected;
  bool existColor=false;
  int len;
  int idxc=0;
  int visiblec=1;

  ColorsD obtenerColor(String nombre){
  List<ColorsD> lc=colorService.colores;
  for(ColorsD c in lc){
    if(c.nombre.toLowerCase()==nombre.toLowerCase()){
      return c;
    }
  }
  return null;
  }


  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    controllers=List();
    atributosText=List();

    KeyboardVisibilityNotification().addNewListener(
        onChange: (bool visible) {
          //print("ACA CARE VERGA");
          setState(() {
            visiblec = visible ? 0 : 1;
            //print(visiblec);
          });
          // print(MediaQuery.of(context).size.height);
        });
    for(atributosProducto a in widget.atributos){
      if(a.titulo.toLowerCase().contains("color")){
        existColor=true;
      }
      if(!a.titulo.toLowerCase().contains("color")){
        atributosText.add(a);
      }
    }
    bool colorsExist=false;
    cantidadController=TextEditingController();

    if(widget.atributos.length>0){

      for(atributosProducto a in widget.atributos){
        if(a.titulo.toLowerCase().contains("color")){
          colorsExist=true;
          break;
        }
      }
   len=colorsExist?widget.atributos.length-1:widget.atributos.length;
      print(len);
      for(int i=0; i<len;i++){
        TextEditingController t=TextEditingController();
        controllers.add(t);
      }
    }

    if(widget.editmode==1){
      for(int i=0; i<len;i++){
        controllers[i].text=widget.valoresEdit.valores[widget.valoresEdit.obtenerIndex(atributosText[i].titulo.toLowerCase())];
      }

      cantidadController.text=widget.valoresEdit.cantidad.toString();
      if(existColor){
        int index=widget.valoresEdit.obtenerIndex("color");
        if(index>-1){
          coloresSelected=obtenerColor(widget.valoresEdit.valores[index]);
        }

      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        title: Text("Detalle",style: TextStyle(
          fontFamily: "Roboto",
          fontSize: 17,
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
          Expanded(
            flex: 18,
            child:   atributosText.length>0?ListView(
              children: [

                for(int i=0;i<atributosText.length;i++)

                  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding:EdgeInsets.only(top: 10,bottom: 5),
            child: Row(
              children: <Widget>[
                Text(atributosText[i].titulo,style: TextStyle(color: Colors.grey[600]),)
              ],
            ),
          ),
          Row(
            children: <Widget>[
           Expanded(
             child: TextField(
               controller:controllers[i],
               style: TextStyle(
                   color: Colors.grey[600],
                   fontSize: MediaQuery.of(context).size.height * .018),
               keyboardType: TextInputType.text,
               autocorrect: true,
               autofocus: false,
               decoration: InputDecoration(
                 contentPadding: EdgeInsets.all(10),
                 isDense: true,

                 // prefixIcon:  Icon(Icons.person_outline, color: Colors.grey[500]),
                 hintText: "${atributosText[i].titulo} del producto",

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


            ],

          ),
          if(i==atributosText.length-1 && existColor)
            Padding(
              padding:EdgeInsets.only(top: 10,bottom: 5),
              child: Row(
                children: <Widget>[
                  Text("Color",style: TextStyle(color: Colors.grey[600]),)
                ],
              ),
            ),
          if(i==atributosText.length-1 && existColor)   Column(
                children: <Widget>[
                Row(
                children: <Widget>[
                Expanded(
                child: InkWell(
                onTap:() async{

                showDialogColor(context, coloresSelected).then((color){
                if(color!=null){
                setState(() {

                coloresSelected=color;
                print(coloresSelected.nombre);
                });
                }

                });


                },
                child:TextFormField(
                  //controller: addAtributoController,
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
                      fillColor: Colors.white,
                      enabled: false,
                      isDense: true,
                      counterText: "",

                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: coloresSelected!=null ?Icon( coloresSelected.color!=Colors.white?Icons.check_circle:FontAwesome5.circle,color:  coloresSelected.color!=Colors.white?coloresSelected.color:Colors.grey,size: 26,) :Icon(Icons.add_circle_outline,size: 28,color: Colors.grey[600],),

                      hintText: coloresSelected!=null?"Modificar color (${coloresSelected.nombre})":"Agregar color",

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
                      hintStyle: TextStyle(
                          color: Colors.grey[600]
                      )

                    // labelText: 'Correo'
                  ),

                ),
                ),
                ),
                ],
                ),
                ],
                ),

    if(i==atributosText.length-1)
            Padding(
              padding:EdgeInsets.only(top: 10,bottom: 5),
              child: Row(
                children: <Widget>[
                  Text("Cantidad",style: TextStyle(color: Colors.grey[600]),)
                ],
              ),
            ),
          if(i==atributosText.length-1 )
          Row(
            children: <Widget>[
              Expanded(
                  child: TextField(
                    controller:cantidadController,
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: MediaQuery.of(context).size.height * .018),
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,

                      // prefixIcon:  Icon(Icons.person_outline, color: Colors.grey[500]),
                      hintText: "Cantidad",

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
                  )

              ),
            ],

          ),
  // ignore: missing_return
  ])),



        ],
      ):ListView(
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[

                  Padding(
                    padding:EdgeInsets.only(top: 10,bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text("color",style: TextStyle(color: Colors.grey[600]),)
                      ],
                    ),
                  ),
                 Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap:() async{

                              showDialogColor(context, coloresSelected).then((color){
                                if(color!=null){
                                  setState(() {

                                    coloresSelected=color;
                                    print(coloresSelected.nombre);
                                  });
                                }

                              });


                            },
                            child: TextFormField(
                              //controller: addAtributoController,
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
                                  fillColor: Colors.white,
                                  enabled: false,
                                  isDense: true,
                                  counterText: "",

                                  contentPadding: EdgeInsets.all(10),
                                  prefixIcon: coloresSelected!=null ?Icon( coloresSelected.color!=Colors.white?Icons.check_circle:FontAwesome5.circle,color:  coloresSelected.color!=Colors.white?coloresSelected.color:Colors.grey,size: 26,) :Icon(Icons.add_circle_outline,size: 28,color: Colors.grey[600],),

                                  hintText: coloresSelected!=null?"Modificar color (${coloresSelected.nombre})":"Agregar color",

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
                                  hintStyle: TextStyle(
                                      color: Colors.grey[600]
                                  )


                                // labelText: 'Correo'
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),


                  Padding(
                    padding:EdgeInsets.only(top: 10,bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Text("Cantidad",style: TextStyle(color: Colors.grey[600]),)
                      ],
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                            controller:cantidadController,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: MediaQuery.of(context).size.height * .018),
                            keyboardType: TextInputType.number,
                            autocorrect: true,
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,

                              // prefixIcon:  Icon(Icons.person_outline, color: Colors.grey[500]),
                              hintText: "Cantidad",

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
                          )

                      ),
                    ],

                  ),
              ],
            ),



          ),
          Expanded(
            flex: visiblec==0?3:2,
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
                                widget.editmode==0?'Agregar detalle':"Actualizar",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.019),
                              ),
                          /*    SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.03,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),*/
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Color(0xff1ba6d2),
                          onPressed: () {
                            int validControllers=1;
                            print(len);
                            for(int i=0;i<len;i++){
                              if(controllers[i].text=="" || controllers[i].text==null){
                                validControllers=0;
                                break;
                              }
                            }
                            if(validControllers==0){


                              closeModal() {
                                Navigator.of(context).pop();
                              }
                              showAlerts( context, "Los campos son obligatorios", false,closeModal, null,"Aceptar","", null);

                            }else{
                              bool existecolor=false;
                              for(atributosProducto a in widget.atributos){
                                if(a.titulo.toLowerCase().contains("color")){
                                  existecolor=true;
                                  break;
                                }
                              }

                              if(existecolor && coloresSelected==null){
                                closeModal() {
                                  Navigator.of(context).pop();
                                }
                                showAlerts( context, "Seleccione un color para agregar detalle", false,closeModal, null,"Aceptar","", null);
                              }else{
                                if(cantidadController.text==""|| cantidadController.text==null){
                                  closeModal() {
                                    Navigator.of(context).pop();
                                  }
                                  showAlerts( context, "Ingrese cantidad de producto", false,closeModal, null,"Aceptar","", null);
                                }else{
                                  List<String> llaves=List();
                                  List<String> valores=List();
                                  int indexC=0;
                                  if(existecolor){
                                    llaves.add("color");
                                    valores.add(coloresSelected.nombre);
                                  }
                                  for(atributosProducto at in widget.atributos){
                                    if(!at.titulo.toLowerCase().contains("color")){
                                      llaves.add(at.titulo);
                                      valores.add(controllers[indexC].text.trim());
                                      indexC++;
                                    }

                                  }
                                 valorAtributos va=valorAtributos(
                                   id: widget.editmode==0?widget.latrib.length>0?widget.latrib[widget.latrib.length-1].id+1:0:widget.valoresEdit.id,
                                   cantidad: int.parse(cantidadController.text.trim()),
                                   llaves: llaves,
                                   valores: valores,
                                 );
                                 /* print("----------------------------------");
                                  for(int i=0;i<widget.atributos.length;i++){
                                    print(va.id);
                                    print(va.llaves[i]+"=>"+va.valores[i]);
                                  }
                                  print("Cantidad=>"+va.cantidad.toString());
                                  print("----------------------------------");*/

                                  Navigator.of(context).pop(va);
                                }
                              }
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
    );
  }
}
