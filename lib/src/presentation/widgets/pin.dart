/*


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:woin/src/presentation/pages/transactions/transactionSuccess.dart';
import 'package:woin/src/presentation/providers/TransactionProvider.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';
import 'package:woin/src/presentation/widgets/keyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woin/src/services/TransactionService.dart';

class Pin extends StatefulWidget {
  final String page;
  Pin({Key key, @required this.page}) : super(key: key);

  @override
  _PinState createState() => _PinState();

  
}

class _PinState extends State<Pin> {
  bool bandera = true, banderaIndicator = false;
  TransactionProvider transactionProvider;
  @override
  void initState() { 
    transactionProvider = Provider.of<TransactionProvider>(context,listen: false);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

void pinErronea() {
    // flutter defined function
      showDialog(
        context: context,
        builder: (_) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, setstate){
              return AlertDialog(
                title: new Text("Pin Incorrecto"),
                content: new Text("Ingrese nuevamente"),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  new FlatButton(
                    child: new Text("cerrar"),
                    onPressed: () {
                      setState(() {
                        this.bandera = true;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        },
      );
    }

  void success(){
    switch (widget.page) {
      case 'transfers':
        sendTransaction();
        break;
      default:
    }
  }
  void sendTransaction() async{
      var resp = await transactionService.postAll(transactionProvider.listTransactions);
      if (resp != null) {
        print('ok oda funciona');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionSuccess()));
        // keyboardProvider.clearAll();
      }else{
        print('jum nada que funciona');
      }
    }
    
  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final size = MediaQuery.of(context).size;
    
    
    Widget botonPin(int index, {Color color}){
      if (keyboardProvider.pin[3] != '_' && bandera){
        if (keyboardProvider.pin.join()=='0000' || keyboardProvider.huella) {
          setState(() {
            bandera = false;
          });
          success();
          
        } else {
          setState(() {
            bandera = false;
            this.banderaIndicator = true;
          });
          print(this.banderaIndicator);
          Timer(Duration(seconds: 3), (){
            pinErronea();
            keyboardProvider.clearAll();
            setState(() {
              this.banderaIndicator = false;
            });
          });
          print(this.banderaIndicator);
        }
      }else {
        
      }
      return Container(
        height: size.height * 0.04,
        width: size.height * 0.04,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: keyboardProvider.pin[index]!='_'?color:Colors.grey,
        ),
      );
    }
    return WillPopScope(
      onWillPop: () async {
        keyboardProvider.clearAll();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pon tu clave', style: TextStyle(color: Colors.blue),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.blue, //change your color here
          ),
        ),
        
        body: SafeArea(
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: size.height * 0.3,
                  child: Image.asset('assets/images/pin.png',fit: BoxFit.fill,),
                ),
                if(this.banderaIndicator)...[CircularProgressIndicator()],
                Text('Ingrese su PIN'),
                Container(
                  height: size.height * 0.04,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      keyboardProvider.pin[0]!='_'?Bounce(child: botonPin(0, color: Colors.yellow),):botonPin(0),
                      keyboardProvider.pin[1]!='_'?Bounce(child: botonPin(1, color: Colors.green),):botonPin(1),
                      keyboardProvider.pin[2]!='_'?Bounce(child: botonPin(2, color: Colors.blue),):botonPin(2),
                      keyboardProvider.pin[3]!='_'?Bounce(child: botonPin(3, color: Colors.pink),):botonPin(3),
                    ],
                  ),
                ),
                // SizedBox(height: size.height * 0.02,),
                Container(
                  height: size.height * 0.35,
                  child: Keyboard(),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}*/
