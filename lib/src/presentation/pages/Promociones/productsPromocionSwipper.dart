import 'package:flutter/material.dart';
import 'package:woin/src/entities/Products/ProductsModel.dart';

import 'package:woin/src/services/ProductsCardBloc.dart';

class CardProductView extends StatelessWidget {
  Product producto;

  CardProductView(this.producto);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return // CARDS SUPERIOR
      Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(right: 11, left: 21, top: 2, bottom: 10),
        child: new Card(
          margin: EdgeInsets.all(0),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          //color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(producto.imgProducto),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(255, 255, 255, 0.6),
                                ),
                                height: MediaQuery.of(context).size.height *
                                    .26 *
                                    0.18,
                                width: MediaQuery.of(context).size.height *
                                    .25 *
                                    0.18,
                                child: Builder(builder: (BuildContext context) {
                                  return IconButton(
                                    padding: EdgeInsets.all(0),
                                    alignment: Alignment.center,
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      color: Color.fromRGBO(1, 117, 182, 1),
                                    ),
                                    iconSize: MediaQuery.of(context).size.height *
                                        .25 *
                                        0.13,
                                    onPressed: () {},
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Color.fromRGBO(255, 255, 255, 0.6),
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              producto.precioAnterior.toString(),
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  color:
                                                  Color.fromRGBO(88, 88, 88, 1),
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      .25 *
                                                      0.1,
                                                  decoration:
                                                  TextDecoration.lineThrough),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      .25 *
                                                      .012),
                                              child: Text(
                                                "-" +
                                                    producto.descuento.toString() +
                                                    "%",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                  Color.fromRGBO(88, 88, 88, 1),
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      .25 *
                                                      0.045,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            flex: 8,
                            child: Container(
                              //color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .93 *
                                                0.05,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                .22 *
                                                0.04),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      producto.imgTiend),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(50),
                                              ),
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  .22 *
                                                  .3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  .22 *
                                                  .3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                .size
                                                .width *
                                                .93 *
                                                0.05,
                                            top: MediaQuery.of(context)
                                                .size
                                                .height *
                                                .22 *
                                                0.015),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              producto.nombTiend,
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    210, 210, 210, 1),
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    .22 *
                                                    0.055,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: MediaQuery.of(context).size.height *
                                            .22 *
                                            0.075),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    .93 *
                                                    0.05,
                                                right: 0),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  producto.nombre,
                                                  style: TextStyle(
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        .22 *
                                                        0.07,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        210, 210, 210, 1),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  .93 *
                                                  0.04,
                                              top: 0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                producto.precioActual.toString(),
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height*.22 *

                                                      0.16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      90, 90, 90, 1),
                                                ),
                                              ),
                                              Text(
                                                producto.descuento.toString() +
                                                    "%",
                                                style: TextStyle(
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      .22 *
                                                      0.07,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      210, 210, 210, 1),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  .93 *
                                                  0.04,
                                              bottom: 0,
                                              top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  .22 *
                                                  0.005),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.card_giftcard,
                                                color: Color.fromRGBO(
                                                    21, 105, 162, 1),
                                                size: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    .22 *
                                                    0.11,
                                              ),
                                              Text(
                                                producto.valordescuento
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        21, 105, 162, 1),
                                                    fontSize:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        .22 *
                                                        0.12,
                                                    fontWeight: FontWeight.w400),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              //
                              //color: Colors.blueGrey,
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.all(0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Builder(builder: (BuildContext context) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: producto.like == 0
                                            ? Color.fromRGBO(214, 214, 214, 1)
                                            : Colors.redAccent,
                                        size: MediaQuery.of(context).size.height *
                                            .25 *
                                            0.13,
                                      ),
                                      iconSize: 10.0,
                                      hoverColor: Color.fromRGBO(1, 117, 182, 1),
                                      focusColor: Color.fromRGBO(1, 117, 182, 1),
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.topRight,
                                      onPressed: () {
                                        porductBloc.likeProduct.add(producto);
                                      },
                                    );
                                  }),
                                  Builder(builder: (BuildContext context) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.add_shopping_cart,
                                        color: Color.fromRGBO(214, 214, 214, 1),
                                      ),
                                      iconSize:
                                      MediaQuery.of(context).size.height *
                                          .22 *
                                          0.13,
                                      padding: EdgeInsets.all(0),
                                      alignment: Alignment.bottomRight,
                                      onPressed: () {},
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
  }
}
