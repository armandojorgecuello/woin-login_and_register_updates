import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';

class InfoAnuncio extends StatefulWidget {
  InfoAnuncio({@required this.information});
  infoOferta information;

  @override
  _InfoAnuncioState createState() => _InfoAnuncioState();
}

class _InfoAnuncioState extends State<InfoAnuncio> {
  int visiblec = 1;
  TextEditingController tituloController;
  TextEditingController descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {

      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
      // print(MediaQuery.of(context).size.height);
    });
    descriptionController=TextEditingController();
    tituloController=TextEditingController();
    if(widget.information!=null){
      tituloController.text=widget.information.titulo;
      descriptionController.text=widget.information.descripcion;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "infoOferta",
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
            Expanded(flex: visiblec==1? 18:16,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: visiblec==1? 5:12,
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
                                      Text("Título",style: TextStyle(color: Colors.grey[600]),),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          controller: tituloController,

                                          validator: (val) {
                                            if(val=="" || val==null){
                                              return "Título de la oferta es requerido";

                                            }else if(val.length<5){
                                              return "Título demasiado corto";
                                            }else{
                                              return null;
                                            }

                                          },
                                          maxLength: 35,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  .018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            counterText: "",
                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Título de la oferta",

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
                                      Text("Descripción",style: TextStyle(color: Colors.grey[600]),),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          controller: descriptionController,

                                          validator: (val) {
                                            if(val=="" || val==null){
                                              return "Descripción de la oferta es requerida";
                                            }else if(val.length<15 ){
                                              return "Descripción de la oferta demasiado corta";
                                            }else{
                                              return null;
                                            }

                                          },
                                          maxLength: 500,
                                          maxLines: 7,
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize:
                                              MediaQuery.of(context).size.height *
                                                  .018),
                                          keyboardType: TextInputType.text,
                                          autocorrect: true,
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            isDense: true,

                                            contentPadding: EdgeInsets.all(10),

                                            hintText: "Descripción de la oferta",

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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(flex: visiblec==1?5:1,child: SizedBox(),)
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
                            infoOferta infoO=infoOferta(descripcion: descriptionController.text.trim(),titulo: tituloController.text.trim());
                            Navigator.of(context).pop(infoO);
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
