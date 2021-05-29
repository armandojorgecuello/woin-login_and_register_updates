import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/AnuncioList.dart';
import 'dart:ui' as ui;
class CardPromocion extends StatelessWidget {
  final AnuncioAd anuncio;
  final int isBig;
  CardPromocion({this.anuncio,this.isBig=0});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        //color: Colors.blue
      ),

      child: Column(
        children: <Widget>[
         Expanded(
              flex: this.isBig==1?8:  6,
           child:Stack(
             children: <Widget>[
               Container(
                // padding: EdgeInsets.only(top: 1,left: 1,right: 1),
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.only( topRight: Radius.circular(4),topLeft: Radius.circular(4)),
                   image: DecorationImage(
                     image: NetworkImage(anuncio.multimedia),
                     fit: BoxFit.cover
                   )
                 ),
               ),
               Align(
                 alignment: Alignment.topCenter,
                 child: Container(
                   color: Colors.transparent,
                   height: ResponsiveFlutter.of(context).verticalScale(40),
                   padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(10)),


                     child: Row(
                       children: <Widget>[
                         CircleAvatar(
                           radius: ResponsiveFlutter.of(context).verticalScale(12),
                           backgroundImage: NetworkImage(anuncio.woinerMultimedia),
                         ),
                         SizedBox(
                           width: ResponsiveFlutter.of(context).scale(5),
                         ),
                         Container(
                         height: ResponsiveFlutter.of(context).verticalScale(40),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: <Widget>[

                              Container(
                                //color: Colors.green,
                                width: ResponsiveFlutter.of(context).wp(38)-ResponsiveFlutter.of(context).scale(38),
                                  child: Text(anuncio.fullname,style: TextStyle(color: Color.fromRGBO(
                                      21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).scale(10),

                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 5.0,
                                        color: Colors.black38,
                                      ),
                                      Shadow(
                                        offset: Offset(1.0, 1.0),
                                        blurRadius: 5.0,
                                        color: Colors.black38,
                                      ),
                                    ],

                                  ),overflow: TextOverflow.ellipsis, softWrap: false,)),
                               Container(
                                   width: ResponsiveFlutter.of(context).wp(38)-ResponsiveFlutter.of(context).scale(38),
                                   child: Text(anuncio.city+"/"+anuncio.country,style: TextStyle(color: Color.fromRGBO(
                                       21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).scale(10),
                                     shadows: <Shadow>[
                                       Shadow(
                                         offset: Offset(1.0, 1.0),
                                         blurRadius: 5.0,
                                         color: Colors.black38,
                                       ),
                                       Shadow(
                                         offset: Offset(1.0, 1.0),
                                         blurRadius: 5.0,
                                         color: Colors.black38,
                                       ),
                                     ],
                                   ),overflow: TextOverflow.ellipsis, softWrap: false,))

                             ],
                           ),
                         )
                       ],
                     ),

                 ),
               ),
               anuncio.discountPercentage!=0?     Align(
                 alignment: Alignment.bottomCenter,
                 child: Container(
                   color: Colors.white.withOpacity(.3
                   ),
                   margin: EdgeInsets.only(bottom:ResponsiveFlutter.of(context).verticalScale(2),right: ResponsiveFlutter.of(context).scale(3),left:ResponsiveFlutter.of(context).scale(3)  ),
                   height: ResponsiveFlutter.of(context).verticalScale(25),
                   child: Padding(
                     padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(2)),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text(anuncio.price.toString(),style: TextStyle(color: Color.fromRGBO(
    21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).fontSize(1.6),decoration: TextDecoration.lineThrough,
                           shadows: <Shadow>[
                             Shadow(
                               offset: Offset(1.0, 1.0),
                               blurRadius: 5.0,
                               color: Colors.black38,
                             ),
                             Shadow(
                               offset: Offset(1.0, 1.0),
                               blurRadius: 5.0,
                               color: Colors.black38,
                             ),
                           ],),),
                         Text(anuncio.discountPercentage.toString()+"% Dto",style: TextStyle(color: Color.fromRGBO(
    21, 105, 162, 1),fontSize: ResponsiveFlutter.of(context).fontSize(1.6),
                           shadows: <Shadow>[
                             Shadow(
                               offset: Offset(1.0, 1.0),
                               blurRadius: 5.0,
                               color: Colors.black38,
                             ),
                             Shadow(
                               offset: Offset(1.0, 1.0),
                               blurRadius: 5.0,
                               color: Colors.black38,
                             ),
                           ],
                         ),)
                       ],
                     ),
                   ),
                 ),
               ):SizedBox()
             ],
           )
          ),
          Expanded(
              flex: isBig==1?2:3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only( bottomLeft: Radius.circular(4),bottomRight: Radius.circular(4)),
                ),
                padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(5),vertical:ResponsiveFlutter.of(context).verticalScale(2) ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: <Widget>[
                       Container(
                         //color: Colors.green,
                         width: isBig==0?ResponsiveFlutter.of(context).wp(42)-ResponsiveFlutter.of(context).scale(31):ResponsiveFlutter.of(context).wp(85)-ResponsiveFlutter.of(context).scale(31),
                      child: Text(anuncio.title,style: TextStyle(fontSize: isBig==0?ResponsiveFlutter.of(context).hp(20)*0.08 : ResponsiveFlutter.of(context).hp(20)*0.09),overflow: TextOverflow.ellipsis,)
                       ),
                        InkWell(
                          onTap: (){

                          },
                            child: Icon(Icons.favorite_border,size: ResponsiveFlutter.of(context).hp(20)*.14,color: Colors.grey[400],)),
                       
                     ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(anuncio.discountPrice.toString(),style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 0.12*ResponsiveFlutter.of(context).hp(20))),
                       anuncio.discountPercentage>0? Text(anuncio.discountPercentage.toString(),style: TextStyle(fontSize: ResponsiveFlutter.of(context).hp(20)*.06,color: Color(0xff1ba6d2))):SizedBox()
                      ],
                    ),
                Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       Column(
                         children: <Widget>[
                           anuncio.discountPercentage>0?    Row(
                             children: <Widget>[
                               Icon(Icons.card_giftcard,size: 0.1*ResponsiveFlutter.of(context).hp(20),color: Color(0xff1ba6d2),),
                               SizedBox(width: ResponsiveFlutter.of(context).scale(5),),
                               Text(anuncio.discountPrice.toString(),style: TextStyle(fontSize: ResponsiveFlutter.of(context).hp(20)*.09,color: Color(0xff1ba6d2)))
                             ],
                           ):SizedBox()
                         ],
                       ),
                        InkWell(
                          onTap: (){},
                            child: Icon(Icons.add_shopping_cart,size:0.14* ResponsiveFlutter.of(context).hp(20)))
                      ],
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}


