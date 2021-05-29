/*
import 'package:woin/src/presentation/providers/TransactionProvider.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
// Color colorContainer, Color colorValue, double value, int type, BoxShadow shadow){
class InputValueKeyboard extends StatefulWidget {
  final int type;
  final Color colorContainer, colorValue;
  final double value;
  final bool transactionType;
  BoxShadow shadow;
  InputValueKeyboard({Key key, @required this.colorContainer, @required this.colorValue, @required this.value, @required this.type, this.shadow, this.transactionType}) : super(key: key);

  @override
  _InputValueKeyboardState createState() => _InputValueKeyboardState();
}

class _InputValueKeyboardState extends State<InputValueKeyboard> {
  BoxShadow _shadow ;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shadow = BoxShadow(color: Colors.grey, blurRadius: 10.0);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    //final woinerProvider = Provider.of<WoinerProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    TextEditingController getController(){
      TextEditingController controller;
      switch (widget.type) {
        case 1: controller = keyboardProvider.controllerPriceWoin; break;
        case 2: controller = keyboardProvider.controllerPriceCash; break;
        case 3: controller = keyboardProvider.controllerPriceGift; break;
        default:
      }
      return controller;
    }
      return Container(
        height: size.height * 0.05,
        // margin: EdgeInsets.only(left: size.width * 0.05,right: size.width * (widget.type==3?0.0:0.05)),
        width: size.width * 0.9,
        // padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          // color: type==0? colorContainer: color,
          color: widget.colorContainer,
          // boxShadow: [_shadow]
        ),
        child: TextField(
          controller: getController(),
          style: TextStyle(color: widget.colorValue),
          enabled: widget.type==3?false:true,
          onTap: (){
            keyboardProvider.setType(widget.type);

            // print('input: ${keyboardProvider.getType}');
            // keyboardProvider.changeShadow();
            // setState(() {
            //   _shadow = keyboardProvider.getShadow;
            //   print(this._shadow);
              // if (keyboardProvider.getType == 0) {
              //   _shadow = BoxShadow(
              //     color: Colors.transparent,
              //     blurRadius: 0.0,
              //     spreadRadius: 0.0
              //   );
              // } else {
              //   if (keyboardProvider.getType == 1) {
              //     _shadow = keyboardProvider.getShadow;
              //   } else {
              //     _shadow = keyboardProvider.getShadow;
              //   }
              // }
            // });
          },
          onChanged: (text){
            if (text != '' && text != null) {
             / if(woinerProvider.checkTodo){
                if (keyboardProvider.getType ==1) {
                  transactionProvider.listTransactions.forEach((t)=>t.amount = double.parse(text));
                }
                print('oe');
                keyboardProvider.changePrices(text, gift: widget.transactionType);
              }else {
              //  transactionProvider.changeAmount(woinerProvider.woinerSelected.id, double.parse(text));
              }
            }else{
              keyboardProvider.clearPrice();
            }
            // woinerProvider.changeAmount(double.parse(text));
            // FlutterMoneyFormatter(amount: type==1?priceWoin:priceCash).output;
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: widget.colorValue)
            ),
            labelStyle: TextStyle(color:widget.colorValue),
            border: InputBorder.none,
            // hintText: '${widget.type==1?priceWoin:priceCash}',
            hintText: '0',
            // labelText: '0',
            hintStyle: TextStyle(color: widget.colorValue),
          ),
        ),
      );
  }
}*/
