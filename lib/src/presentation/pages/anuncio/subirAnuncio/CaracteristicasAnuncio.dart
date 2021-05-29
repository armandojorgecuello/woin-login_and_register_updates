import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/Colors.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/FileIconsWoin/woin_icon.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/ColoresSelection.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/anuncio/attributesProduct/addAttribute.dart';
import 'package:woin/src/presentation/pages/anuncio/attributesProduct/detalleProduct.dart';
import 'package:woin/src/services/Anuncio/ColorService.dart';



class CaracteristicasAnuncio extends StatefulWidget {
  final CaracteristicasAn caracteristicas;
  CaracteristicasAnuncio({this.caracteristicas});
  @override
  _CaracteristicasAnuncioState createState() => _CaracteristicasAnuncioState();
}

class _CaracteristicasAnuncioState extends State<CaracteristicasAnuncio> {
  //IMAGENES
  String img1="";
  String img2="";
  String img3="";
  String img4="";
  String img5="";
  String img6="";
  File imf;
  TextEditingController nombreProductController;
  List<atributosProducto> atributosC;
  List<valorAtributos> detalleAtributosValor;
  FocusNode fn=FocusNode();

  eliminarDetalle(valorAtributos va){
    for(int i=0;i<detalleAtributosValor.length;i++){
      if(va.id==detalleAtributosValor[i].id){
        detalleAtributosValor.removeAt(i);
        break;
      }
    }

  }

  bool validImg(){

    if(img1!="" || img2!="" || img3!="" || img4!="" || img5!="" || img6!=""){
      return true;
    }

    return false;
  }



  /*int editAtributos(){
    List<bool> exist=List();
    for(atributosProducto va in atributosC){
      print(va.titulo);
      if(tieneLLave(va.titulo.toLowerCase().trim())){
        exist.add(true);
      }else{
        exist.add(false);
      }

    }
    if(exist.contains(false)){
      return 0;
    }else{
      return 1;
    }
  }*/

  bool tieneLLave(String llv){
    List<bool> contll=List();
    bool exist=false;
    for(valorAtributos va in detalleAtributosValor){
     for(String ll in va.llaves){
       print(ll.toLowerCase());
       print(llv.toLowerCase());
       if(ll.toLowerCase()==llv.toLowerCase()){
         exist=true;
       }
     }
     if(exist){
       contll.add(true);
     }else{
       contll.add(false);
     }
    }
    bool resp=contll.contains(false)?false:true;
    return resp;
  }

  String valorLLave(String llv,valorAtributos va){
    print("VALOR 0=>"+va.valores[0]);




      int idx=va.obtenerIndex(llv);
      if(idx>-1){

        return va.valores[idx];
      }else{
        return "";
      }


    }

    crearLLavesDetalle(){
      List<String>nllaves=List();



      //CREAR LLAVES
      for(atributosProducto at in atributosC) {
        nllaves.add(at.titulo.toLowerCase());
      }
      print("ACA=>"+nllaves.length.toString());


        for (int j=0;j<detalleAtributosValor.length;j++) {
          List<String>nValues=List();
          for(int i=0;i<nllaves.length;i++){
            nValues.add(valorLLave(nllaves[i].toLowerCase(),detalleAtributosValor[j]));
          }

          valorAtributos vnew=valorAtributos(
              id: detalleAtributosValor[j].id,
              llaves: nllaves,valores: nValues,cantidad: detalleAtributosValor[j].cantidad);
          detalleAtributosValor[j]=vnew;





        }





      setState(() {

      });

    }





  _openGallery(BuildContext context,int index) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imf = img;
      List<int> imageBytes = img.readAsBytesSync();
      switch(index){
        case 1:
          img1=base64Encode(imageBytes);

          break;
        case 2:
          img2=base64Encode(imageBytes);
          break;
        case 3:
          img3=base64Encode(imageBytes);
          break;
        case 4:
          img4=base64Encode(imageBytes);
          break;
        case 5:
          img5=base64Encode(imageBytes);
          break;
        case 6:
          img6=base64Encode(imageBytes);
          break;

      }


    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context,int index) async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imf = img;
      List<int> imageBytes = img.readAsBytesSync();
      switch(index){
        case 1:
          img1=base64Encode(imageBytes);
          break;
        case 2:
          img2=base64Encode(imageBytes);
          break;
        case 3:
          img3=base64Encode(imageBytes);
          break;
        case 4:
          img4=base64Encode(imageBytes);
          break;
        case 5:
          img5=base64Encode(imageBytes);
          break;
        case 6:
          img6=base64Encode(imageBytes);
          break;

      }
      // print("IMAGEN 1" + imagen);
    });
     Navigator.of(context).pop();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombreProductController=TextEditingController();
    atributosC=List();
    detalleAtributosValor=List();

    if(widget.caracteristicas!=null){
      nombreProductController.text=widget.caracteristicas.nombreProduct.trim();
      img1=widget.caracteristicas.img1;
      img2=widget.caracteristicas.img2;
      img3=widget.caracteristicas.img3;
      img4=widget.caracteristicas.img4;
      img5=widget.caracteristicas.img5;
      img6=widget.caracteristicas.img6;
     // print("LATRIB=>"+widget.caracteristicas.detalleProduct.length.toString());
      //print("LAVAL=>"+widget.caracteristicas.valores.length.toString());
      for(atributosProducto a in widget.caracteristicas.detalleProduct){
        atributosProducto ap=atributosProducto(titulo: a.titulo);
        atributosC.add(ap);
      }

      for(valorAtributos va in widget.caracteristicas.valores){
        valorAtributos av=valorAtributos(valores: va.valores,cantidad: va.cantidad,llaves: va.llaves,id: va.id);
        detalleAtributosValor.add(av);
      }

    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    nombreProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _openBotomModal(int index){
      showModalBottomSheet(context: context, builder: (context){
        return Container(


          height: ResponsiveFlutter.of(context).hp(20)+1,
          padding: EdgeInsets.only(top: 0),


          decoration: BoxDecoration(
            color: Color(0xFF737373),
            // borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),

          ),

          child: Container(

            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              //border: Border(top: BorderSide(width: 1,color: Colors.grey[400]))
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    _openCamera(context, index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 0),

                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: ResponsiveFlutter.of(context).hp(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.camera_alt,color: Colors.grey[700]),
                        SizedBox(
                          width: ResponsiveFlutter.of(context).wp(5),
                        ),
                        Text("Cámara",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.w400),)
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                InkWell(
                  onTap: (){
                    _openGallery(context, index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: ResponsiveFlutter.of(context).hp(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.image,color: Colors.grey[700]),
                        SizedBox(
                          width: ResponsiveFlutter.of(context).wp(5),
                        ),
                        Text("Galeria",style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.w400))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });

    }

    return Hero(
      tag: "caracteristicaArticulo",
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          brightness: Brightness.light,
          title: Text("Caracteristicas",style: TextStyle(
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
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,



              children: <Widget>[
           Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Row(

                              children: <Widget>[
                                Expanded(
                                  child: Text("Nombre producto",style: TextStyle(color: Colors.grey[600]),),
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
                                    controller: nombreProductController,
                                    focusNode: fn,
                                    onChanged: (val){


                                    },
                                    maxLength: 25,
                                    style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            .018
                                    ),
                                    keyboardType: TextInputType.text,
                                    autocorrect: true,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      counterText: "",

                                      contentPadding: EdgeInsets.all(10),

                                      hintText: "Nombre del producto",

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


                  Padding(
                    padding:EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 1),
                    child: Row(
                      children: <Widget>[
                        Text("Imágenes del producto",style: TextStyle(color: Colors.grey[600]),)
                      ],
                    ),
                  ) ,
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(5),
                ),

                Container(
                  height: ResponsiveFlutter.of(context).verticalScale(95),


                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child:  Row(

                              children: <Widget>[


                                              Expanded(
                                                child: GestureDetector(
                                                  onTap:(){
                                                   _openBotomModal( 1);
                                                  },
                                                  child: fotoDetalle( url:img1,marginV: 2),
                                                ),
                                              ),
                                              SizedBox(width: ResponsiveFlutter.of(context).scale(20),),
                                              Expanded(
                                                child:GestureDetector(
                                                onTap:(){
                                                  _openBotomModal( 2);

                                                },
                                                child: fotoDetalle( url:img2,marginV: 2),
                                              ),
                                              ),
                                              SizedBox(width: ResponsiveFlutter.of(context).scale(20),),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap:(){
                                                    _openBotomModal( 3);

                                                  },
                                                  child:  fotoDetalle( url:img3,marginV: 2),
                                                ),
                                              ),
                              ],
                    ),
                    ),
                ),

                Container(
                  height: ResponsiveFlutter.of(context).verticalScale(95),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      child:  Row(

                        children: <Widget>[


                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                _openBotomModal(4);

                              },
                              child: fotoDetalle( url:img4,marginV: 2),
                            ),
                          ),
                          SizedBox(width: ResponsiveFlutter.of(context).scale(20),),
                          Expanded(
                            child:GestureDetector(
                              onTap:(){
                                _openBotomModal( 5);

                              },
                              child: fotoDetalle( url:img5,marginV: 2),
                            ),
                          ),
                          SizedBox(width: ResponsiveFlutter.of(context).scale(20),),
                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                _openBotomModal( 6);

                              },
                              child:  fotoDetalle( url:img6,marginV: 2),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(10),
                ),
                SingleChildScrollView(
                  child: Column(
                      children: <Widget>[

                        Padding(
                          padding:EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap:() async{
                                    fn.unfocus();
                                    Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context)=>AddAttribute(atributos: atributosC,)
                                    )).then((atributos){
                                      if(atributos!=null ){
                                          atributosC=List();
                                          for(atributosProducto a in atributos){
                                            print("MODEL=>"+a.titulo);
                                            atributosProducto ap =atributosProducto(titulo: a.titulo.trim());
                                            atributosC.add(ap);

                                          }
                                          setState(() {

                                          });

                                            crearLLavesDetalle();



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
                                      prefixIcon: Icon(Icons.add_circle_outline,color: Colors.grey[600],size: 28,),

                                      hintText: atributosC.length==0?"Agregar atributos":"Actualizar atributos",

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
                        ),



                      ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
        atributosC.length>0? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[

                      Padding(
                        padding:EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InkWell(
                                onTap:() async{
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context)=>detalleProductP(atributos: atributosC,latrib: detalleAtributosValor,)
                                  )).then((va){
                                    if(va!=null){
                                      detalleAtributosValor.add(va);
                                      setState(() {

                                      });
                                    }
                                  });


                                },
                                child:  TextFormField(
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
                                      prefixIcon: Icon(Icons.add_circle_outline,color: Colors.grey[600],size: 28,),

                                      hintText: "Agregar detalle",

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
                      ),



                    ],
                  ),
                ):SizedBox(),
                SizedBox(
                  height: 15,
                ),

             detalleAtributosValor.length>0?   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Text("Detalle de producto generado",style: TextStyle(color: Colors.grey[600]),)
                    ],
                  ),
                ):SizedBox(),
                SizedBox(
                  height: 10,
                ),

                for(int i=0;i<detalleAtributosValor.length;i++)
               Container(
                 height: ResponsiveFlutter.of(context).hp(detalleAtributosValor[i].llaves.length+2*6.5),
                 margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                 width: 10,
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.grey[400]),
                   borderRadius: BorderRadius.circular(5)
                 ),
                 child: Column(
                   children: <Widget>[

                     for( int j=0;j<detalleAtributosValor[i].valores.length+2;j++)
                       if(j<detalleAtributosValor[i].valores.length)
                         Padding(
                           padding: EdgeInsets.only(left: 10,right:10,top:j==0?8:2),
                           child: Row(
                           children: <Widget>[
                             Text(detalleAtributosValor[i].llaves[j]+": ",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),),
                             Text(detalleAtributosValor[i].valores[j],style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300),),
                           ],
                       ),
                         )
                        else if(j==detalleAtributosValor[i].valores.length)
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 10,vertical:2),
                             child: Row(
                               children: <Widget>[
                                 Text("Cantidad: ",style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),),
                                 Text(detalleAtributosValor[i].cantidad.toString(),style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300),),
                               ],
                             ),
                           )else
                                Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical:5),
                                child:Row(
                               children: <Widget>[
                                 InkWell(
                                   onTap:(){
                                     Navigator.of(context).push(CupertinoPageRoute(
                                         builder: (context)=>detalleProductP(atributos: atributosC,editmode: 1,valoresEdit: detalleAtributosValor[i],)
                                     )).then((va){
                                       if(va!=null){
                                         for(int i=0;i<detalleAtributosValor.length;i++){

                                           if(detalleAtributosValor[i].id==va.id){
                                             detalleAtributosValor[i]=va;

                                           }
                                         }
                                         setState(() {

                                         });
                                       }
                                     });

                                   },


                                     child: Text("Editar",style: TextStyle(color: Colors.blue[300],decoration: TextDecoration.underline),)),
                                 SizedBox(width: 15,),
                                 InkWell(
                                     onTap: (){
                                       eliminarDetalle(detalleAtributosValor[i]);
                                       setState(() {

                                       });
                                     },
                                     child: Text("Eliminar",style: TextStyle(color: Colors.red[300],decoration: TextDecoration.underline),))
                               ],
                             ),),

                   ],
                 ),
               ),


              ],
            ),
            ),
            Expanded(
              flex: 2,
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
                              closeModal() {
                                Navigator.of(context).pop();
                              }

                              if(nombreProductController.text==""){

                                showAlerts( context, "Ingrese el nombre del producto ", false,closeModal, null,"Aceptar","", null);
                              }else if(atributosC.length==0){
                                showAlerts( context, "Agrege atributos a su producto ", false,closeModal, null,"Aceptar","", null);
                              }else if(detalleAtributosValor.length==0){
                                showAlerts( context, "Agrege detalle de su producto", false,closeModal, null,"Aceptar","", null);
                              }else if(!validImg()){
                                showAlerts( context, "Agrege por lo menos una foto de su producto", false,closeModal, null,"Aceptar","", null);
                              }else{

                                List<atributosProducto> atributosCn=List();
                                List<valorAtributos> detalleAtributosValorn=List();

                                for(atributosProducto at in atributosC){
                                  atributosProducto ap=atributosProducto(
                                    titulo: at.titulo
                                  );
                                  atributosCn.add(ap);
                                }
                                for(valorAtributos at in detalleAtributosValor){
                                  valorAtributos va=valorAtributos(
                                      id: at.id,
                                    llaves: at.llaves,
                                    cantidad: at.cantidad,
                                    valores: at.valores
                                  );
                                  detalleAtributosValorn.add(va);
                                }

                                //print("Todo bien");
                                CaracteristicasAn caract= new CaracteristicasAn(
                                  valores: detalleAtributosValorn,
                                  detalleProduct: atributosCn,

                                  img1: img1,
                                  img2: img2,
                                  img3: img3,
                                  img4: img4,
                                  img5: img5,
                                  img6: img6,
                                  nombreProduct: nombreProductController.text.trim()
                                );
                                print(caract.detalleProduct.length);
                                print(caract.valores.length);
                                Navigator.of(context).pop(caract);

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

class fotoDetalle extends StatelessWidget {
  final String url;
  final double marginV;
  fotoDetalle({this.url="",this.marginV});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: ResponsiveFlutter.of(context).hp(15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),

        border: Border.all(color: Colors.grey[400],width: 0.5),
        image:  url!=""?DecorationImage(
            image: MemoryImage(base64.decode(url)),
            fit: BoxFit.fill
        ):null,
      ),
      margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(marginV)),
      child: url!=""? null:
      Column(
        mainAxisSize: MainAxisSize.max,
        children:[ Expanded(
          child: Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.grey[400],
                  size: ResponsiveFlutter.of(context).scale(35),
                ),
              ),
            ),
          ),


        ),
        ],
      ),
    );
  }
}
