/*

import 'package:woin/src/entities/Persons/Person.dart';
import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/widgets/cardWoin.dart';
import 'package:woin/src/presentation/widgets/inputValueKeyboard.dart';
import 'package:woin/src/presentation/widgets/keyboard.dart';
import 'package:woin/src/presentation/widgets/listWoiners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class Pay extends StatefulWidget {
  Pay({Key key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  List<Woiner> woiners = [
                        Woiner(codewoiner: 'dffsffss', id: 1, person: Person(birthdate: 0,firstName: 'Kenneth', firstLastName: 'Mendoza',secondLastName: 'Lopez', gender: 1)),
                        // Woiner(codewoiner: 'dffsffss', id: 1, person: Person(birthdate: 0,firstName: 'Kenneth', secondName: 'Raul', firstLastName: 'Mendoza',secondLastName: 'Lopez', gender: 1))
                      ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    final textColorCard = TextStyle(color: Color.fromRGBO(0, 117, 177, 1));
    Widget cardBody = Container(
      height: size.height *1,
      // width: size.width*4,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: size.height*0.15, child: FittedBox(child: Text('Mis Woins', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold)))),
          Container(height: size.height*0.2, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: 468000000000).output.nonSymbol}', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
          SizedBox(height: size.height * 0.075,),
          Container(height: size.height*0.1, child: FittedBox(child: Text('Woiners 0', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
          SizedBox(height: size.height*0.075),
          // Container(height: size.height*0.1, child: FittedBox(child: Text('Usuarios 1', style: textColorCard,))),
          // Text('Usuarios 3'),
          SizedBox(height: size.height * 0.05,),
          Container(
            height: size.height *0.3,
            width: size.width * 4,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    height: size.height*1,
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: size.height*0.1, child: FittedBox(child: Text('Total a pagar Woin', style: textColorCard,))),
                        Container(height: size.height*0.2, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: double.parse(keyboardProvider.getPriceWoin)).output.nonSymbol}', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 5.0,
                  height: double.maxFinite,
                  color: Colors.grey,
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                ),
                Expanded(
                  child: Container(
                    // color: Colors.green,
                    height: size.height*1,
                    // alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: size.height*0.1, child: FittedBox(child: Text('Total a pagar efectivo', style: TextStyle(color: Colors.grey),))),
                        Container(height: size.height*0.2, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: double.parse(keyboardProvider.getPriceCash)).output.symbolOnLeft}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Transfers(cardBody: cardBody, woiners: woiners, action: 1,);
  }
}*/
