import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/AnuncioMain.dart';
import 'package:woin/src/presentation/pages/Promociones/promo_page.dart';


class PromDesign extends StatefulWidget {
  @override
  _PromDesignState createState() => _PromDesignState();
}

class _PromDesignState extends State<PromDesign> {

  PageController ctrlPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ctrlPage=PageController(viewportFraction:0.85);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context)=>PromoPage()
          ));
          return Future.value(false);

        },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Expanded(child: PageView.builder(
                  controller: ctrlPage,
                  itemBuilder: (context,index){

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: ResponsiveFlutter.of(context).verticalScale(55)),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300].withOpacity(.5),width: 1),
                    /*boxShadow:  [
                      new BoxShadow(
                        color: Colors.grey[200],
                        offset: new Offset(5.0, 1.0),
                        blurRadius: 1.0,
                      ),],*/
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(flex: 3,child: Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only( topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                                image: DecorationImage(
                                    image: NetworkImage("https://picsum.photos/250?image=1"),
                                    fit: BoxFit.fill
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.transparent,
                              height: ResponsiveFlutter.of(context).verticalScale(60),
                              padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(10)),


                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: ResponsiveFlutter.of(context).verticalScale(20),
                                  ),
                                  SizedBox(
                                    width: ResponsiveFlutter.of(context).scale(15),
                                  ),
                                  Container(
                                    height: ResponsiveFlutter.of(context).verticalScale(40),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[

                                        Container(
                                          //color: Colors.green,
                                            width: ResponsiveFlutter.of(context).wp(68)-ResponsiveFlutter.of(context).scale(50),
                                            child: Text("Kike moda y Estilo y algo más",style: TextStyle(color: Colors.white,fontSize: ResponsiveFlutter.of(context).scale(12),),overflow: TextOverflow.ellipsis, softWrap: false,)),
                                        Container(
                                            width: ResponsiveFlutter.of(context).wp(68)-ResponsiveFlutter.of(context).scale(50),
                                            child: Text("EEUU/Colombia SAS",style: TextStyle(color: Colors.white,fontSize: ResponsiveFlutter.of(context).scale(12),),overflow: TextOverflow.ellipsis, softWrap: false,))

                                      ],
                                    ),
                                  )
                                ],
                              ),

                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(

                              decoration:BoxDecoration(
                                color: Colors.white.withOpacity(.5),
                                borderRadius: BorderRadius.circular(3)
                              ),
                              margin: EdgeInsets.only(bottom:ResponsiveFlutter.of(context).verticalScale(4),right: ResponsiveFlutter.of(context).scale(3),left:ResponsiveFlutter.of(context).scale(3)  ),
                              height: ResponsiveFlutter.of(context).verticalScale(35),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(4)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("100000000",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(2.1),decoration: TextDecoration.lineThrough, ),),
                                    Text("10% Dto",style: TextStyle(color: Colors.grey[800],fontSize: ResponsiveFlutter.of(context).fontSize(2.1)),)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                      ),
                      Expanded(flex: 2,child:
                         Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only( bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: ResponsiveFlutter.of(context).scale(5),vertical:ResponsiveFlutter.of(context).verticalScale(2) ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(35),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[

                                    Container(
                                      //color: Colors.green,
                                        width: ResponsiveFlutter.of(context).wp(72)-ResponsiveFlutter.of(context).scale(20),
                                        child: Text("Blusas Damas Americanino",style: TextStyle(fontSize: ResponsiveFlutter.of(context).hp(30)*0.09),overflow: TextOverflow.ellipsis,)
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(25),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("90000.00",style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold,fontSize: 0.13*ResponsiveFlutter.of(context).hp(40))),
                                    Text("10%",style: TextStyle(fontSize: ResponsiveFlutter.of(context).hp(40)*.06,color: Color(0xff1ba6d2)))
                                  ],
                                ),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(5),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.card_giftcard,size: 0.1*ResponsiveFlutter.of(context).hp(40),color: Color(0xff1ba6d2),),
                                            SizedBox(width: ResponsiveFlutter.of(context).scale(5),),
                                            Text("9000.00",style: TextStyle(fontSize: ResponsiveFlutter.of(context).hp(40)*.09,color: Color(0xff1ba6d2)))
                                          ],
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context).verticalScale(24),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                        onTap: (){

                                        },
                                        child: Icon(Icons.favorite_border,size: ResponsiveFlutter.of(context).hp(30)*.14,color: Colors.grey[400],)),
                                    SizedBox(width: ResponsiveFlutter.of(context).scale(20),),
                                    InkWell(
                                        onTap: (){},
                                        child: Icon(Icons.add_shopping_cart,size:0.14* ResponsiveFlutter.of(context).hp(30)))
                                  ],
                                )
                              ],
                            ),
                          )
                      )
                    ],
                  ),
                );
              }),),
            ],
          ),
        ),
      ),
    );
  }
}
