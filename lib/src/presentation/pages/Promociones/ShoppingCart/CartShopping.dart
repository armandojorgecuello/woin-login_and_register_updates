import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return
     Column(
        children: <Widget>[
          Expanded(
            flex: 18,
            child:Container(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: screenSize.width * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: screenSize.width * 0.035,
                              right: screenSize.width * 0.035),
                          height: screenSize.height * 0.12,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              border: Border(
                                  top:
                                  BorderSide(color: Colors.grey[300], width: 1.5),
                                  left:
                                  BorderSide(color: Colors.grey[300], width: 1.5),
                                  right:
                                  BorderSide(color: Colors.grey[300], width: 1.5),
                                  bottom: BorderSide(
                                      color: Colors.grey[300], width: 1.5))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('Total articulos ',
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.034,
                                          color: Colors.grey[500])),
                                  Text('13',
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.035,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[500]))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Total a pagar ',
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.037,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[800])),
                                  Text('\$ 1.270.000',
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.039,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.grey[800]))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Ganar regalo ',
                                      style: TextStyle(
                                          fontSize: screenSize.width * 0.035,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff1ba6d2))),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(Icons.card_giftcard,
                                          color: Color(0xff1ba6d2),
                                          size: screenSize.height * 0.023),
                                      Text('\$117.000',
                                          style: TextStyle(
                                              fontSize: screenSize.width * 0.035,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff1ba6d2)))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('Articulos agregados a su carrito de compras',
                              style: TextStyle(
                                  fontSize: screenSize.width * 0.035,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[800])),
                        ),

                      ],
                    ),
                  ),
                  Expanded(
                    child:  ListView.builder(
                        itemCount: 7,
                        itemBuilder: (Context, int index) => ItemPay()),
                  )
                ],
              ),
            ),
          ),
        ],
      );

  }
}

class ItemPay extends StatelessWidget {
  const ItemPay({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(

      height: screenSize.height * 0.305,
      padding: EdgeInsets.symmetric(
        horizontal: screenSize.width * 0.02,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.032,
          vertical: screenSize.height * 0.01),
      decoration: BoxDecoration(color: Colors.white,
      border: Border.all(color: Colors.grey[400],width: 0.5),
        borderRadius: BorderRadius.circular(2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: screenSize.height * 0.01,
              bottom: screenSize.height * 0.005,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Ver detalle del pedido',
                    style: TextStyle(
                        fontSize: screenSize.width * 0.035,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[800])),
                Icon(Icons.keyboard_arrow_down, color: Colors.grey[800])
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Image.asset(
                        'assets/img/user3.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: screenSize.height * 0.005,
                            right: screenSize.height * 0.005,
                            bottom: screenSize.height * 0.006),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.height * 0.004,
                            vertical: screenSize.height * 0.001),
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(03)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('\$300.00',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: screenSize.height * 0.017)),
                            Text('10% Dto',
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: screenSize.height * 0.013)),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 5.0,
                        left: 5.0,
                        child: Container(
                          height: screenSize.height * 0.027,
                          width: screenSize.width * 0.047,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Color(0xff1ba0d1),
                            size: screenSize.height * 0.02,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: screenSize.width * 0.03),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: screenSize.height * 0.1,
                              width: screenSize.width * 0.1,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                AssetImage('assets/img/user4.jpg'),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Kike Moda y Estilo',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: screenSize.height * 0.0133)),
                              Text('EEUU / COLOMBIA S.A.S',
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: screenSize.height * 0.0133))
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.only(left: screenSize.width * 0.03),
                          child: Text('Blusa Damas Americana',
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: screenSize.height * 0.018)),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(left: screenSize.width * 0.03),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('\$90.000.00',
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w700,
                                      fontSize: screenSize.height * 0.023)),
                              Text('10%',
                                  style: TextStyle(
                                      color: Color(0xff1ba0d1),
                                      fontSize: screenSize.height * 0.0135))
                            ],
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.005),
                        Padding(
                          padding:
                          EdgeInsets.only(left: screenSize.width * 0.03),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.card_giftcard,
                                  color: Color(0xff1ba0d1),
                                  size: screenSize.height * 0.0235),
                              Text('\$9.000.00',
                                  style: TextStyle(
                                      color: Color(0xff1ba0d1),
                                      fontSize: screenSize.height * 0.02))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.favorite_border,
                      size: screenSize.height * 0.035),
                  color: Colors.red[300],
                  onPressed: () {}),
              SizedBox(width: screenSize.width * 0.023),
              IconButton(
                  icon: Icon(Icons.add_shopping_cart,
                      color: Color(0xff1ba0d1),
                      size: screenSize.height * 0.035),
                  onPressed: () {}),
              SizedBox(width: screenSize.width * 0.023),
              IconButton(
                  icon: Icon(Icons.share,
                      color: Colors.grey[400], size: screenSize.height * 0.035),
                  onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
