
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/AnuncioList.dart';
import 'package:woin/src/entities/anuncio/keyValuesView.dart';
import 'package:woin/src/helpers/utils.dart';
import 'package:woin/src/presentation/FileIconsWoin/woin_icon.dart';
import 'package:woin/src/presentation/pages/Promociones/FavoriteProm/FavoriteProm.dart';
import 'package:woin/src/presentation/pages/Promociones/ShoppingCart/CartShopping.dart';
import 'package:woin/src/presentation/pages/Promociones/addPedido.dart';
import 'package:woin/src/presentation/pages/Promociones/cardPromocion.dart';
import 'package:woin/src/presentation/pages/Promociones/mainFavShopping.dart';
import 'package:woin/src/presentation/pages/Promociones/promo_page.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';


class detallePromocion extends StatefulWidget {
  final AnuncioAd anuncioDetalle;
  Function despliegueMenu;

  detallePromocion({this.anuncioDetalle,this.despliegueMenu});

  @override
  _detallePromocionState createState() => _detallePromocionState();
}

class _detallePromocionState extends State<detallePromocion> {
  String urlprincipal="https://picsum.photos/250?image=4";
  List<String >image=List();
  bool expand1=false;
  bool expand2=false;
  int indexImg=0;
  int selectedPageview=1;
  TextEditingController ctrlCantidad=TextEditingController();
  TextEditingController ctrlTalla=TextEditingController();
  Utilities utils=Utilities();
  List<KeyValuesView> caracteristicasProducto=List();
  int totalDisponible=0;
  double factorMultiplicativo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String img1="https://picsum.photos/250?image=1";
    String img2="https://picsum.photos/250?image=2";
    String img3="https://picsum.photos/250?image=3";
    String img4="";
    String img5="";
    String img6="https://picsum.photos/250?image=4";
    image.add(img1);
    image.add(img2);
    image.add(img3);
    image.add(img4);
    image.add(img5);
    image.add(img6);
    ctrlCantidad.text="0";
    ctrlTalla.text="0";
    obtenerCaracteristicas();
   // widget.despliegueMenu();

  }

   void obtenerCaracteristicas(){
    List<AdKeyValues> lkv=widget.anuncioDetalle.adKeyValues;
    List<AdKeyValues> lkvp=List();
    List<AdKeyValues> lkvh=List();
    if( lkv.length>0){
     for(AdKeyValues ak in lkv){

        if(ak.parentId==null){
          lkvp.add(ak);
        }else{
          lkvh.add(ak);
        }
     }

   }
    List<KeyValuesView> lc=List();
    for(AdKeyValues ak in lkvp){
      List<String>keys=List();
      List<String>values=List();
      keys.add(ak.key);
      values.add(ak.value);
      for(AdKeyValues akh in lkvh){
        if(akh.parentId==ak.id){
          keys.add(akh.key);
          values.add(akh.value);
        }
      }
      KeyValuesView kvn=KeyValuesView(keys: keys,cantidad: ak.total,values: values);
      totalDisponible+=ak.total;
      lc.add(kvn);

    }
    caracteristicasProducto=lc;
    factorMultiplicativo=caracteristicasProducto.length>0?caracteristicasProducto[0].values.length==1?2.0:caracteristicasProducto[0].values.length.toDouble():2;

  }


  @override
  Widget build(BuildContext context) {

    closeViewpage(){
      setState(() {
        selectedPageview=0;
      });
    }

    return WillPopScope(
      onWillPop: ()async {
        Navigator.of(context)
            .pushReplacement(CupertinoPageRoute(builder: (context) => TabMain(index: 0,)));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text("Promociones",style: TextStyle(color: Color(0xff1ba6d2),fontSize: 18),),
          elevation: 0,
          centerTitle: true,
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
                Navigator.of(context)
                    .pushReplacement(CupertinoPageRoute(builder: (context) => TabMain(index: 0,)));
              },
              child: Icon(
                Icons.chevron_left,
                size: 35,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
            ),
          ),
        ),
        body: Container(
                color: Colors.grey[100],

            padding: EdgeInsets.only(left:10,right: 10,top:5),
            child: ListView(
              padding: EdgeInsets.only(top: 5),
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[600],width: 0.2),

                      borderRadius: BorderRadius.vertical(top: Radius.circular(5),bottom: Radius.circular(5))
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.vertical(top: Radius.circular(5))
                        ),
                        height:selectedPageview==1? ResponsiveFlutter.of(context).hp(43): ResponsiveFlutter.of(context).hp(46),

                        child: Column(
                          mainAxisSize: MainAxisSize.max,

                          children: <Widget>[
                           InkWell(
                             onTap: (){
                               print("IR A PERFIL");
                             },
                             child:  Padding(
                               padding: EdgeInsets.all(12),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: <Widget>[
                                   CircleAvatar(
                                     radius: 28,
                                     backgroundImage: widget.anuncioDetalle.woinerMultimedia!=""?NetworkImage(widget.anuncioDetalle.woinerMultimedia):null,
                                   ),
                                   Column(
                                     mainAxisSize: MainAxisSize.max,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       Padding(
                                         padding: EdgeInsets.only(left: 10),
                                         child: Text(widget.anuncioDetalle.fullname, style: TextStyle(color: Colors.grey[800],fontSize: 13),),),

                                       Padding(
                                         padding: EdgeInsets.only(left: 10),
                                         child: Text(widget.anuncioDetalle.country+"/"+widget.anuncioDetalle.city, style: TextStyle(color: Colors.grey[800],fontSize: 13),),),
                                       //"
                                     ],
                                   ),
                                   SizedBox(
                                     width: ResponsiveFlutter.of(context).scale(50),
                                   ),
                                   Column(

                                     children: <Widget>[
                                       IconButton(
                                         icon: Icon(Icons.chevron_right),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                            if (selectedPageview==0) Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex:2,
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[0]&& image[0]!=""){
                                                setState(() {
                                                  urlprincipal=image[0];
                                                  indexImg=0;
                                                });
                                              }
                                            },
                                            child: fotoDetalle( url:"https://picsum.photos/250?image=1",marginV: 16),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[1]&& image[1]!=""){
                                                setState(() {
                                                  urlprincipal=image[1];
                                                  indexImg=1;
                                                });
                                              }
                                            },
                                            child: fotoDetalle( url:"https://picsum.photos/250?image=2",marginV: 16),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[2]&& image[2]!=""){
                                                setState(() {
                                                  urlprincipal=image[2];
                                                  indexImg=2;
                                                });
                                              }
                                            },
                                            child:  fotoDetalle( url:"https://picsum.photos/250?image=3",marginV: 16),
                                          ),

                                        ],
                                      )),
                                  Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(10)),
                                        child: Stack(

                                          children: <Widget>[
                                            Container(
                                              height:ResponsiveFlutter.of(context).hp(25) ,
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey[400],width: 0.5),
                                                borderRadius: BorderRadius.circular(5),
                                                image: DecorationImage(
                                                    image: NetworkImage(urlprincipal),
                                                    fit: BoxFit.fill
                                                ),

                                              ),
                                              child: null,
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: InkWell(
                                                onTap: (){
                                                  selectedPageview=1;
                                                  setState(() {     });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 5,top: 5),
                                                  width: 30,
                                                  height: 30,
                                                  child: Icon(Icons.remove_red_eye,color: Colors.grey[800],),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white.withOpacity(0.5)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(2)),
                                                  margin: EdgeInsets.only(left: 5,top: 5,right: 5,bottom: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white.withOpacity(0.5),
                                                      borderRadius: BorderRadius.circular(3)
                                                  ),
                                                  height: 30,
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text("1.000.000,00",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),),
                                                      Text("9.000",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),)
                                                    ],
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[3]&& image[3]!=""){
                                                setState(() {
                                                  urlprincipal=image[3];
                                                  indexImg=3;
                                                });
                                              }
                                            },
                                            child: fotoDetalle( marginV: 16),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[4]&& image[4]!=""){
                                                setState(() {
                                                  urlprincipal=image[4];
                                                  indexImg=4;
                                                });
                                              }
                                            },
                                            child: fotoDetalle( marginV: 16),
                                          ),
                                          GestureDetector(
                                            onTap:(){
                                              if(urlprincipal!=image[5]&& image[5]!=""){
                                                setState(() {
                                                  urlprincipal=image[5];
                                                  indexImg=5;
                                                });
                                              }
                                            },
                                            child: fotoDetalle(url:"https://picsum.photos/250?image=4", marginV: 16),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ) else Container(


                                height: ResponsiveFlutter.of(context).hp(30),
                                width: ResponsiveFlutter.of(context).wp(100),
                                child :  PageviewProduct(paddingVertical: 0.0,paddingHorizontal: 5.0,closePage: 1,onTap: closeViewpage,lmultimedias: widget.anuncioDetalle.multimedias,)),

                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))
                        ),
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(10)),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text( utils.formatInt(widget.anuncioDetalle.price)  ,style: TextStyle(fontSize: 20,color: Colors.grey[800]),),
                                   widget.anuncioDetalle.discountPercentage!=0? Text(widget.anuncioDetalle.discountPercentage.toString()+"%",style: TextStyle(fontSize: 9,color: Colors.blue[700]),):SizedBox()
                                  ],
                                ),
                                widget.anuncioDetalle.discountPercentage!=0? Row(
                                  children: <Widget>[
                                    Icon(Icons.card_giftcard,color:Colors.blue[700],size: 17 ,),
                                    Text(utils.formatInt(widget.anuncioDetalle.discountPrice),style: TextStyle(color: Colors.blue[700],fontSize: 16,),)
                                  ],
                                ):SizedBox()

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(10)),
                                      child: Text(widget.anuncioDetalle.description,style: TextStyle(color: Colors.grey[700],fontSize: 13),textAlign: TextAlign.justify,)),
                                )
                              ],
                            ),

                           /* Container(
                              height: ResponsiveFlutter.of(context).hp(1.5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text("Cantidad",style: TextStyle(fontSize: 10,color: Colors.grey[600]),),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ResponsiveFlutter.of(context).scale(20),
                                  ),
                                 Expanded(
                                    child: SizedBox() /*Center(
                                      child: Text("Talla",style: TextStyle(fontSize: 10,color: Colors.grey[600]),),*/


                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ResponsiveFlutter.of(context).verticalScale(4),),
                            Container(
                              height: ResponsiveFlutter.of(context).hp(4.5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex:1,
                                          child: GestureDetector(
                                            onTap: (){
                                              int val=int.parse(ctrlCantidad.text);
                                              val--;
                                              ctrlCantidad.text= val>=0?val.toString():"0";
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:  Border(
                                                  left: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                  top: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                  bottom: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                  right: BorderSide(color: Colors.grey[600] ,width: 0.5),


                                                ),
                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5)),


                                                //borderRadius: BorderRadius.all(Radius.circular(2))
                                              ),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[ Text("-",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),)]),
                                            ),
                                          ),),
                                        Expanded(
                                          flex:2,
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: ctrlCantidad,

                                            // controller: usernameController,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: MediaQuery.of(context).size.height * .018),
                                            keyboardType: TextInputType.number,
                                            autocorrect: true,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(10),



                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[700],
                                                      width: 0
                                                  )
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[700],
                                                      width: 0.0
                                                  )
                                              ),

                                              // labelText: 'Correo'
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex:1,
                                          child: GestureDetector(
                                            onTap: (){
                                              int val=int.parse(ctrlCantidad.text);
                                              val++;
                                              ctrlCantidad.text=val.toString();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(

                                                  border: Border(
                                                      right: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      top: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      bottom: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      left: BorderSide(color:Colors.grey[600],width: 0.5)

                                                  ),
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5))
                                              ),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children:[ Text("+",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(2.6)),),]),
                                            ),
                                          ),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: ResponsiveFlutter.of(context).scale(20),
                                  ),

                                  Expanded(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex:1,
                                            child: GestureDetector(
                                              onTap: (){
                                                int val=int.parse(ctrlTalla.text);
                                                val--;
                                                ctrlTalla.text= val>=0?val.toString():"0";
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border:  Border(
                                                      left: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      top: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      bottom: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                      right: BorderSide(color: Colors.grey[600] ,width: 0.5),


                                                    ),
                                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),topLeft: Radius.circular(5))
                                                  //borderRadius: BorderRadius.all(Radius.circular(2))
                                                ),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:[ Text("-",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(3.5)),)]),
                                              ),
                                            ),),
                                          Expanded(
                                            flex:2,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: ctrlTalla,

                                              // controller: usernameController,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: MediaQuery.of(context).size.height * .018),
                                              keyboardType: TextInputType.number,
                                              autocorrect: true,
                                              autofocus: false,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.all(10),



                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[700],
                                                        width: 0
                                                    )
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[700],
                                                        width: 0.0
                                                    )
                                                ),

                                                // labelText: 'Correo'
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex:1,
                                            child: GestureDetector(
                                              onTap: (){
                                                int val=int.parse(ctrlTalla.text);
                                                val++;
                                                ctrlTalla.text=val.toString();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(

                                                    border: Border(
                                                        right: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                        top: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                        bottom: BorderSide(color: Colors.grey[600] ,width: 0.5),
                                                        left: BorderSide(color:Colors.grey[600],width: 0.5)

                                                    ),
                                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5))
                                                ),
                                                child :Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children:[ Text("+",style: TextStyle(color: Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(2.6)),)]),
                                              ),
                                            ),),
                                        ],
                                      )
                                  ),

                                ],
                              ),
                            ),*/

                            Container(
                              height: ResponsiveFlutter.of(context).hp(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ResponsiveFlutter.of(context).wp(42),
                                    child:  Row(
                                      children: <Widget>[
                                        Padding(
                                            padding:EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(8)),
                                            child: Text("Unidades disponibles: "+totalDisponible.toString(),style: TextStyle( color: Colors.grey[600],fontSize: 12),)),
                                      ],
                                    ),/*Center(
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(4),
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.amber,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.purple,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueAccent,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),

                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.lightGreen,
                                                border: Border.all(color: Colors.grey[700],width: 0.2)
                                            ),
                                            width: ResponsiveFlutter.of(context).wp(5),
                                            // height: ResponsiveFlutter.of(context).hp(2.5),
                                            child: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ),

                                  Container(
                                    width: ResponsiveFlutter.of(context).wp(42),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context)=>MainFavoriteShopping(index: 0,)
                                            ));
                                          },

                                          child: Padding(
                                            child: Icon(Icons.favorite_border,color: Colors.grey[400]),
                                            padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(15), ),
                                          ),


                                        ),

                                        InkWell(
                                          onTap: (){
                                           Navigator.of(context).push(MaterialPageRoute(
                                             builder: (context)=>MainFavoriteShopping(index: 1,)
                                           ));
                                          },
                                          child: Padding(child: Icon(Icons.add_shopping_cart,color: Colors.grey[400]),
                                            padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(15), ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.grey[300],
                                          onTap: (){
                                            print("HUB");
                                          },
                                          child: Material(
                                            color: Colors.white,
                                            child: Padding(child: Icon(Icons.device_hub,color: Colors.grey[400],),
                                              padding: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(15), ),
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Divider(height:1,color: Colors.grey[600],),
                            GestureDetector(
                              onTap:(){
                                expand1=!expand1;
                                setState(() {

                                });
                              },
                              child: AnimatedContainer(
                                padding: EdgeInsets.only(top:ResponsiveFlutter.of(context).verticalScale(8)),
                                duration: Duration(milliseconds: 100),
                                height: caracteristicasProducto.length>0? expand1 && widget.anuncioDetalle.adsSimilaries.length>0 && !expand2?ResponsiveFlutter.of(context).hp(23.8)*factorMultiplicativo:  expand1 && widget.anuncioDetalle.adsSimilaries.length==0 && !expand2?ResponsiveFlutter.of(context).hp(21.8)*caracteristicasProducto[0].values.length :expand1 && expand2?  ResponsiveFlutter.of(context).hp(35.5)*caracteristicasProducto[0].values.length  :     ResponsiveFlutter.of(context).hp(6):ResponsiveFlutter.of(context).hp(40),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Column(
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap:(){
                                            expand1=!expand1;
                                            setState(() {

                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Características del producto",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
                                              Icon(Icons.keyboard_arrow_down,color: Colors.grey[800],)
                                            ],
                                          ),
                                        ),

                                        caracteristicasProducto.length>0?
                                              ViewCaracteristicas(caracteristicas:caracteristicasProducto):SizedBox(),
                                        expand1? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(widget.anuncioDetalle.title,style: TextStyle(color: Colors.grey[500]),),
                                            RatingBar.builder(
                                              initialRating: 3,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              tapOnlyMode: false,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: ResponsiveFlutter.of(context).hp(2.5),
                                              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Color(0xff1ba6d2),
                                              ),

                                            ),
                                            Text("3.0",style: TextStyle(color: Color(0xff1ba6d2)),)
                                          ],
                                        ):SizedBox(),
                                        expand1? Row(
                                          children: <Widget>[
                                            Padding(
                                              child: Text("Comentarios",style: TextStyle(color: Color(0xff1ba6d2),decoration: TextDecoration.underline,fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),),
                                              padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(10)),

                                            ),
                                          ],
                                        ):SizedBox(),
                                        expand1? ComentariosView(
                                          calif: 4,
                                          description: "Ropa de muy buena calidad, entregan el pedido a tiempo",
                                          nombre: "Jaime Daniel Barros",
                                        ):SizedBox(),
                                        expand1? ComentariosView(
                                          calif: 2.5,
                                          description: "Ropa de muy buena calidad, pero entregan el pedido a tiempo",
                                          nombre: "Catalina Mindiola",
                                        ):SizedBox(),

                                        expand1? Row(
                                          children: <Widget>[
                                            InkWell(
                                              onTap:(){
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (_){
                                                      return  ViewComentariosAll(idprom: 1,);
                                                    }
                                                ));

                                              },
                                              child: Padding(
                                                child: Text("Ver todos los comentarios",style: TextStyle(color: Color(0xff1ba6d2),decoration: TextDecoration.underline,fontSize: ResponsiveFlutter.of(context).fontSize(1.7)),),
                                                padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(10)),

                                              ),
                                            ),
                                          ],
                                        ):SizedBox(),
                                        expand1 && widget.anuncioDetalle.adsSimilaries.length>0?  Divider():SizedBox(),
                                        expand1 && widget.anuncioDetalle.adsSimilaries.length>0? InkWell(
                                          onTap: (){
                                            setState(() {
                                              expand2=!expand2;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text("Otras publicaciones",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),),
                                              Icon(Icons.keyboard_arrow_down,color: Colors.grey[800],)
                                            ],

                                          ),


                                        ):SizedBox(),


                                        expand2?Container(
                                          height: ResponsiveFlutter.of(context).hp(34),
                                          padding: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(10)),
                                          color: Colors.transparent,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: widget.anuncioDetalle.adsSimilaries.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context,int index){return Container(
                                                       height: ResponsiveFlutter.of(context).hp(20),
                                          width: ResponsiveFlutter.of(context).wp(42),

                                          decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          boxShadow: [
                                          new BoxShadow(
                                          color: Colors.grey[500],
                                          offset: new Offset(3.0, 3.0),
                                          blurRadius: 1.0,
                                          ),],),
                                          margin: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(4) ,right: ResponsiveFlutter.of(context).scale(4) ,bottom: ResponsiveFlutter.of(context).verticalScale(5),top:ResponsiveFlutter.of(context).verticalScale(3)),
                                          child: CardPromocion(anuncio: widget.anuncioDetalle.adsSimilaries[index],),
                                          );},

                                            /*children: <Widget>[

                                             Container(
                                                height: ResponsiveFlutter.of(context).hp(20),
                                                width: ResponsiveFlutter.of(context).wp(42),

                                                decoration: BoxDecoration(
                                                  color: Colors.grey[600],
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors.grey[500],
                                                      offset: new Offset(3.0, 3.0),
                                                      blurRadius: 1.0,
                                                    ),],),
                                                margin: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(4) ,right: ResponsiveFlutter.of(context).scale(4) ,bottom: ResponsiveFlutter.of(context).verticalScale(5),top:ResponsiveFlutter.of(context).verticalScale(3)),
                                                child: CardPromocion(),
                                              ),
                                              Container(
                                                height: ResponsiveFlutter.of(context).hp(20),
                                                width: ResponsiveFlutter.of(context).wp(42),

                                                decoration: BoxDecoration(
                                                  color: Colors.grey[600],
                                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors.grey[500],
                                                      offset: new Offset(3.0, 3.0),
                                                      blurRadius: 1.0,
                                                    ),],),
                                                margin: EdgeInsets.only(left: ResponsiveFlutter.of(context).scale(4) ,right: ResponsiveFlutter.of(context).scale(4) ,bottom: ResponsiveFlutter.of(context).verticalScale(5),top:ResponsiveFlutter.of(context).verticalScale(3)),
                                                child: CardPromocion(),
                                              ),




                                            ],*/
                                          ),
                                        ):SizedBox()

                                      ],


                                    ),
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveFlutter.of(context).hp(2),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(_)=> addPedido()
                    ),);
                  },
                  child: Container(
                    height:ResponsiveFlutter.of(context).hp(8.5),

                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[500],width: 0.2)

                    ),
                    child:Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Información opcional para realizar su pedido",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.grey[800]),),
                            Icon(Icons.chevron_right,color: Colors.grey[800],)
                          ],
                        ),
                    )
                  ),
                ),
                SizedBox(height: ResponsiveFlutter.of(context).hp(2),),
                /*GestureDetector(
                  onTap: (){},
                  child: Container(
                    height:ResponsiveFlutter.of(context).hp(8.5),
                    margin: EdgeInsets.only(bottom: ResponsiveFlutter.of(context).verticalScale(12)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[500],width: 0.2)

                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Seleccione lugar de domicilio",style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.6),color: Colors.grey[800]),),
                          Icon(Icons.chevron_right,color: Colors.grey[800],)
                        ],
                      ),
                    ),
                  ),
                ),*/


              ],
            ),
          ),




      ),
    );
  }
}

class ViewCaracteristicas extends StatelessWidget{
  final List<KeyValuesView> caracteristicas;
  ViewCaracteristicas({this.caracteristicas});
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
      child: Column(
        children: <Widget>[
          for(KeyValuesView c in caracteristicas)
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(0.0)),
                child: Column(
                  children: <Widget>[
                    for(int i=0;i<c.keys.length;i++)
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(c.keys[i],style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.w400,fontSize: 12), ),
                         Text(c.values[i],style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w400,fontSize: 12),)
                       ],
                     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Cantidad",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.w500,fontSize: 12),),
                        Container(
                          padding:EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(1),vertical: ScreenUtil().setHeight(1)),
                          width: c.cantidad.toString().length==1?ScreenUtil().setWidth(20): c.cantidad.toString().length*ScreenUtil().setWidth(10),
                            height: ScreenUtil().setWidth(22),
                            decoration: BoxDecoration(
                              color: Color(0xff1ba6d2),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(

                                child: Text(c.cantidad.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12))))
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
            ),
        ],

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
      height: ResponsiveFlutter.of(context).hp(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        
        border: Border.all(color: Colors.grey[400],width: 0.5),
        image:  url!=""?DecorationImage(
            image: NetworkImage(url),
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
              padding: EdgeInsets.only(right: ResponsiveFlutter.of(context).scale(12)),
              child: Icon(
                WoinIcon.woin1,
                color: Colors.grey[300],
                size: ResponsiveFlutter.of(context).scale(24),
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

class ComentariosView extends StatelessWidget {

  final String urlProfile;
  final String description;
  final double calif;
  final String nombre;
  ComentariosView({this.urlProfile="",this.description,this.nombre,this.calif});

  @override
  Widget build(BuildContext context) {
    return   Container(
        padding: EdgeInsets.only(top:  ResponsiveFlutter.of(context).verticalScale(10)),
        height: ResponsiveFlutter.of(context).hp(10),
        child: Column(
          children: <Widget>[
            Row(

              children: <Widget>[

                CircleAvatar(
                  backgroundImage: urlProfile!=""?NetworkImage(urlProfile):null,

                  child: urlProfile==""? Center(child: Text(nombre[0]),):null,
                  radius: ResponsiveFlutter.of(context).scale(15),
                ),
                SizedBox(
                  width: ResponsiveFlutter.of(context).scale(15),
                ),
                Flexible(child: RichText(
                  textAlign: TextAlign.justify,

                  text: TextSpan(
                    text: '${nombre}/ ',
                    style: TextStyle(fontWeight: FontWeight.w400,color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(1.6)),
                    children: <TextSpan>[
                      TextSpan(

                          text: description, style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w300)),

                    ],
                  ),
                ),
                ),

              ],
            ),
            SizedBox(
              height: ResponsiveFlutter.of(context).scale(7),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(41)),
              child: Row(
                children: <Widget>[
                  RatingBar.builder(
                    initialRating: calif,
                    minRating: 1,
                    direction: Axis.horizontal,
                    tapOnlyMode: false,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: ResponsiveFlutter.of(context).hp(1.8),
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Color(0xff1ba6d2),
                    ),

                  ),
                  Text(calif.toString(),style: TextStyle(color:Color(0xff1ba6d2)),)
                ],
              ),
            ),



          ],


        ),

    );
  }
}

class ViewComentariosAll extends StatefulWidget {
  final int idprom;
  ViewComentariosAll({@required this.idprom});

  @override
  _ViewComentariosAllState createState() => _ViewComentariosAllState();
}

class _ViewComentariosAllState extends State<ViewComentariosAll> {

  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Comentarios",style: TextStyle(color: Color(0xff1ba6d2) ),),
        centerTitle: true,
         leading:Container(
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
               size: 35,
               color: Color(
                 0xffbbbbbb,
               ),
             ),
           ),
         ),
      ),

      body: Column(
        children: [
          Expanded(

            flex: 7,
            child: PageviewProduct (),
          ),
          Expanded(
            flex:1,
            child:Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 0.2,color: Colors.grey[400])
                  )
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(

                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.check_circle_outline),
                            SizedBox(
                              width: ResponsiveFlutter.of(context).scale(5),
                            ),
                            Text("Buenos"),
                          ],
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.error_outline),
                           SizedBox(
                             width: ResponsiveFlutter.of(context).scale(5),
                           ),
                            Text("Malos"),
                          ],
                        )
                    ),
                  )
                ],
              ),

            )
          ),

          Expanded(
            flex: 10,

          child :Container(
            padding: EdgeInsets.only(top: ResponsiveFlutter.of(context).verticalScale(1)),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),

            children: <Widget>[
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),
              Divider(),
              ComentariosView(nombre: "Juana de Arco",description: "Comentarios buenos o malos de la promocion",calif: 2.0,),

            ],
        ),
          ),
        ),
          Expanded(
            flex:2,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 0.3,color: Colors.grey[400])
                  )
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                      child:Container(

                        margin: EdgeInsets.only(left: 10,top: 10,bottom: 10,right: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400],
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(8),vertical: ResponsiveFlutter.of(context).verticalScale(10)),
                          child: Text("Agregar comentario...",style: TextStyle(color: Colors.grey[400]),),
                        )


                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(

                      child: FlatButton(
                        child: Icon(Icons.add_circle_outline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class PageviewProduct extends StatefulWidget {
  final double paddingVertical;
  final double paddingHorizontal;
  final int initialIndex;
  final int closePage;
  final Function onTap;
  final List<Multimedias> lmultimedias;
  PageviewProduct({this.paddingVertical=6, this.paddingHorizontal=8,this.initialIndex=0,this.closePage=0,this.onTap,this.lmultimedias});
  @override
  _PageviewProductState createState() => _PageviewProductState();
}

class _PageviewProductState extends State<PageviewProduct> {
  int index=0;


  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.symmetric(horizontal: this.widget.paddingHorizontal,vertical: this.widget.paddingVertical),
          child: Stack(
              children:[ PageView(
                
                onPageChanged: (i){
                  print(i);
                  setState(() {
                    index=i;
                  });
                },
                children: <Widget>[
                 for(Multimedias m in widget.lmultimedias)
                   Container(
                     padding: EdgeInsets.all(4),
                     child: Container(

                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(5),
                           border: Border.all(color: Colors.grey[500],width: 0.5),
                           image: DecorationImage(
                               image: NetworkImage(m.source),
                               fit: BoxFit.cover
                           )
                       ),
                     ),
                   )

                ],
              ),

          /*  this.widget.closePage==1 ?Positioned(
                  right: ResponsiveFlutter.of(context).scale(10),
                  top: ResponsiveFlutter.of(context).verticalScale(8),
                  child: InkWell(
                    onTap: this.widget.onTap,
                    child: Container(
                      width: ResponsiveFlutter.of(context).scale(25) ,
                      height: ResponsiveFlutter.of(context).scale(25) ,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        shape: BoxShape.circle
                      ),
                      child:Icon(Icons.clear)
                    ),
                  ),
                ) :SizedBox(),*/

           widget.lmultimedias.length>1? Align(

                  child: Container(
                      margin: EdgeInsets.only(bottom: 10),

                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for( int i=0;i< widget.lmultimedias.length;i++)
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 10,
                              height: 10,

                              decoration: BoxDecoration(
                                  color: index==i?Colors.blueAccent:Colors.white,
                                  shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[500],
                                  width: 0.2
                                )
                              ),
                            )
                        ]
                      )
                  ),
                  alignment: Alignment.bottomCenter,
                ):SizedBox()


              ]
          ),
    );

  }
}




