import 'package:woin/src/entities/Ads/Ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BannerDesign extends StatefulWidget {
  final Ad ad;
  BannerDesign(this.ad, {Key key}) : super(key: key);

  @override
  _BannerDesignState createState() => _BannerDesignState();
}

class _BannerDesignState extends State<BannerDesign> {
  bool _like = false;
  void onpressLike() {
    setState(() {
      _like = !_like;
      print(_like);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color gris = const Color(0XFF9E9E9E);
    final Color azul = const Color.fromRGBO(0, 117, 177, 1);
    final TextStyle styleTitleAd =
        new TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold);
    final TextStyle styleProductValue =
        new TextStyle(fontWeight: FontWeight.bold);
    final TextStyle stylePreviousPrice = new TextStyle(
        color: gris,
        decoration: TextDecoration.lineThrough,
        decorationStyle: TextDecorationStyle.wavy);
    final mediaQuery = MediaQuery.of(context).size;
    Widget logo = Container(
      width: mediaQuery.width * 2.5,
      child: Row(children: <Widget>[
        Container(
            alignment: Alignment.centerLeft,
            // height: mediaQuery.height * 0.15,
            width: mediaQuery.width * 0.3,
            // Image.asset('assets/images/logo.png',fit: BoxFit.fitHeight
            child: Image.asset('assets/images/logo.png', fit: BoxFit.fill)),
        true
            ? Container(
                height: mediaQuery.height * 0.21,
                width: mediaQuery.width * 2.2,
                child: FittedBox(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Icon(Icons.remove_red_eye,
                        color: Theme.of(context).primaryColor),
                    onTap: () {
                      print('object');
                    },
                  ),
                ),
              )
            : Container(
                height: mediaQuery.height * 0.21,
                width: mediaQuery.width * 2.2,
              ),
      ]),
    );
    Widget favorite = _like
        ? Icon(Icons.favorite, color: azul)
        : Icon(Icons.favorite_border, color: gris);
    Widget adsImage = Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
            height: mediaQuery.height * 1,
            width: mediaQuery.width * 1,
            child: FittedBox(
              // fit: BoxFit.fill,
              child: Column(
                children: <Widget>[
                  Container(
                      height: mediaQuery.height * 0.9,
                      width: mediaQuery.width * 2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(mediaQuery.height * 0.03)),
                        child: Image.asset(
                          'assets/images/casa.jpg',
                          fit: BoxFit.fill,
                        ),
                      )),
                  // Positioned(
                  // bottom: 0,
                  Container(
                      height: mediaQuery.height * 0.12,
                      width: mediaQuery.width * 1.9,
                      // margin: EdgeInsets.all(mediaQuery.width * 0.05),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(232, 227, 226, 70),
                          borderRadius:
                              BorderRadius.circular(mediaQuery.height * 0.03)),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: mediaQuery.width * 0.05,
                          ),
                          Container(
                            height: mediaQuery.height * 0.15,
                            width: mediaQuery.width * 0.25,
                            // color: Colors.green,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.card_giftcard,
                                color: azul,
                                size: 10.0,
                              ),
                            ),
                          ),
                          Container(
                            height: mediaQuery.height * 0.15,
                            width: mediaQuery.width * 0.3,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Text('${widget.ad.giftPercentage}%',
                                  style: TextStyle(
                                      color: azul,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            height: mediaQuery.height * 0.15,
                            width: mediaQuery.width * 1.3,
                            child: FittedBox(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  '${FlutterMoneyFormatter(amount: widget.ad.price * (widget.ad.giftPercentage)).output.nonSymbol}',
                                  style: TextStyle(
                                      color: azul,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )),
                  // )
                ],
              ),
            )),
      ),
    );
    Widget adsDescription = Flexible(
      child: FractionallySizedBox(
          widthFactor: 1.2,
          child: Container(
            width: mediaQuery.width * 2.5,
            child: FittedBox(
              child: Column(
                children: <Widget>[
                  logo,
                  Container(
                    height: mediaQuery.height * 0.13,
                    width: mediaQuery.width * 2.5,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      child: Text('${widget.ad.nameCompany.toUpperCase()}',
                          overflow: TextOverflow.ellipsis, style: styleTitleAd),
                    ),
                  ),
                  SizedBox(height: mediaQuery.height * 0.05),
                  Container(
                    height: mediaQuery.height * 0.15,
                    width: mediaQuery.width * 2.5,
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.fitHeight,
                      child: Text(
                        widget.ad.title,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                              '${FlutterMoneyFormatter(amount: widget.ad.price).output.nonSymbol}',
                              style: stylePreviousPrice),
                          SizedBox(
                            width: mediaQuery.width * 0.01,
                          ),
                          Text(
                            'Off-${widget.ad.discountPercentage}%',
                            style: TextStyle(color: gris),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: mediaQuery.height * 0.15,
                    width: mediaQuery.width * 2.5,
                    child: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${FlutterMoneyFormatter(amount: widget.ad.price - (widget.ad.price * (widget.ad.discountPercentage / 100))).output.nonSymbol}',
                          style: styleProductValue,
                        )),
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
                                rating: 3,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                unratedColor: Colors.grey[400],
                                itemBuilder: (context, _) => Icon(Icons.star,
                                    color: Theme.of(context).primaryColor),
                              ),
                            )),
                        Container(
                            height: mediaQuery.height * 0.1,
                            width: mediaQuery.width * 0.7,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(3.0)),
                                child: Text(
                                  ' 2.5 ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    // backgroundColor: Colors.grey[600],
                                  ),
                                ),
                              ),
                            )),
                        Container(
                            height: mediaQuery.height * 0.14,
                            width: mediaQuery.width * 0.8,
                            child: FittedBox(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: favorite,
                                onTap: onpressLike,
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
    return Container(
      height: mediaQuery.height * 1,
      padding: EdgeInsets.all(mediaQuery.height * 0.005),
      child: Row(
        children: <Widget>[
          adsImage,
          SizedBox(width: mediaQuery.width * 0.05),
          adsDescription
        ],
      ),
    );
  }
}
