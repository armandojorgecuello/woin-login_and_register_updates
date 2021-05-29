import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AdOrientation {
  static const int horizontal = 0;
  static const int vertical = 1;
}

class CardAd extends StatefulWidget {
  final Ad ad;
  final Widget logo;
  final Widget image;
  final int orientation;

  @override
  _CardAdState createState() => _CardAdState();

  CardAd(this.ad, this.logo, this.image, {this.orientation = AdOrientation.horizontal, Key key}) : super(key: key);
}

class _CardAdState extends State<CardAd> {
  bool _like = false;
  void onpressLike(){
    setState(() {
      _like = !_like;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final Color gris = const Color(0XFF9E9E9E);
    final Color azul = const Color.fromRGBO(0,117,177, 1);
    final TextStyle styleTitleAd = new TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold);
    final TextStyle styleProductValue = new TextStyle(fontWeight: FontWeight.bold);
    final TextStyle stylePreviousPrice = new TextStyle(
      color: gris,
      decoration: TextDecoration.lineThrough,
      decorationStyle: TextDecorationStyle.wavy
    );

    Widget logo = Container(width: mediaQuery.width * 0.3, child: widget.logo);
    Widget favorite = _like ? Icon(Icons.favorite, color: azul): Icon(Icons.favorite_border, color: gris);
    Widget adsImage = Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          height: mediaQuery.height * 1,
          width: mediaQuery.width * 1,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              children: <Widget>[
                Container(
                  height: mediaQuery.height * 0.9,
                  width: mediaQuery.width * 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(mediaQuery.height * 0.03)),
                    child: widget.image
                  )
                ),
                  Container(
                    height: mediaQuery.height * 0.12,
                    width: mediaQuery.width * 2,
                    // margin: EdgeInsets.all(mediaQuery.width * 0.05),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(232, 227, 226, 70),
                      borderRadius: BorderRadius.circular(mediaQuery.height * 0.03)
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(height: mediaQuery.height * 0.05,),
                        Container(
                          height: mediaQuery.height * 0.15,
                          width: mediaQuery.width * 0.25,
                        // color: Colors.green,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.card_giftcard, color: azul, size: 10.0,),
                          ),
                        ),
                        Container(
                          height: mediaQuery.height * 0.15,
                          width: mediaQuery.width * 0.3,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            child: Text('${widget.ad.giftPercentage}%', style: TextStyle(color: azul, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Container(
                          height: mediaQuery.height * 0.15,
                          width: mediaQuery.width * 1.3,
                          child: FittedBox(
                            alignment: Alignment.centerRight,
                            child: Text('W${FlutterMoneyFormatter(amount: widget.ad.price*(widget.ad.giftPercentage)/100).output.nonSymbol}', style: TextStyle(color: azul, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ),
              ],
            ),
          )
        ),
      ),
    );
    
    Widget adsDescription = Flexible(
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: widget.orientation == AdOrientation.horizontal ? 1 : 0.9,
        child: Container(
          height: mediaQuery.height * 1,
          width: mediaQuery.width * 1,
          // margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: FittedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                logo,
                Container(
                  height: mediaQuery.height * 0.13,
                  width: mediaQuery.width * 2,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                    child: Text('${widget.ad.nameCompany.toUpperCase()}', overflow: TextOverflow.ellipsis,style: styleTitleAd ),
                  ),
                ),
                SizedBox(height: mediaQuery.height * 0.05),
                Container(
                  height: mediaQuery.height * 0.15,
                  width: mediaQuery.width * 2.5,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.fitHeight,
                    child: Text(widget.ad.title, overflow: TextOverflow.ellipsis,),
                  ),
                ),
                SizedBox(height: mediaQuery.height * 0.015),
                Container(
                  height: mediaQuery.height * 0.1,
                  width: mediaQuery.width * 2.5,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'W${FlutterMoneyFormatter(amount: widget.ad.price).output.nonSymbol}',
                          style: stylePreviousPrice
                        ),
                        SizedBox(width: mediaQuery.width * 0.01,),
                        Text('Off-${widget.ad.discountPercentage}%', style: TextStyle(color: gris),),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: mediaQuery.height * 0.15,
                  width: mediaQuery.width * 2.5,
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    child: Text('W ${FlutterMoneyFormatter(amount: widget.ad.price-(widget.ad.price*(widget.ad.discountPercentage/100))).output.nonSymbol}', style: styleProductValue,)
                  ),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.008,
                ),
                Container(
                  width: mediaQuery.width * 2.5,
                  child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: mediaQuery.height * 0.1,
                      width: mediaQuery.width * 1,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: RatingBarIndicator(
                          itemSize: 24.0,
                          rating: 0.0,
                          direction: Axis.horizontal,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber
                          ),
                        ),
                      )
                    ),
                    Container(
                      height: mediaQuery.height * 0.1,
                      width: mediaQuery.width * 0.7,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Chip(
                          backgroundColor: Colors.amber,
                          labelStyle: TextStyle(color: Colors.white, fontSize: 30.0 ),
                          label: FittedBox(
                            child: Text('0.0'),
                          ),
                        ),
                      )
                    ),
                    Container(
                      height: mediaQuery.height * 0.14,
                      width: mediaQuery.width * 0.8,
                      child: FittedBox(
                        alignment: widget.orientation == AdOrientation.horizontal ? Alignment.centerRight : Alignment.centerRight,
                        child: GestureDetector(child: favorite,
                          onTap: onpressLike,
                        ),
                      )
                    )
                  ],
                ),
                )
              ],
            ),
          ),
        )
      ),
    );
    
    return Container(
      height: mediaQuery.height * 1,
      padding: widget.orientation == AdOrientation.horizontal ? EdgeInsets.all(mediaQuery.height * 0.005) : EdgeInsets.all(mediaQuery.height * 0.01),
      child: widget.orientation == AdOrientation.vertical ? Column(
        children: <Widget>[
          adsImage,
          SizedBox(width: mediaQuery.width * 0.05,),
          adsDescription
        ],
      ) : 
        Row(
          children: <Widget>[
          adsImage,
          SizedBox(width: mediaQuery.width * 0.05,),
          adsDescription
        ],
      ),
    );
  }
}