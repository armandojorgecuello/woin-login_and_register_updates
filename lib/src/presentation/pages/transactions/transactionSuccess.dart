/*
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:woin/src/presentation/pages/drawer.dart';
import 'package:woin/src/presentation/providers/TransactionProvider.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionSuccess extends StatelessWidget {
  final double price = 0;
  const TransactionSuccess({Key key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final woinerProvider = Provider.of<WoinerProvider>(context);
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
     double priceTotal(){
       double price = 0;
      transactionProvider.listTransactions.forEach((tran)=>price += tran.amount);
      return price;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Woin', style: TextStyle(color: Colors.blue, fontSize: 45.0),),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              height: size.height*0.3,
              child: Center(
                child: Image.asset('assets/images/success.png',fit: BoxFit.fill,),
              ),
            ),
            Container(height: size.height*0.06,child: FittedBox(child: Text("Transacción exitosa", style: TextStyle(fontWeight: FontWeight.bold ),))),
            Container(height: size.height*0.05,child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: priceTotal()).output.nonSymbol}'))),
            SizedBox(height: size.height*0.01,),
            Container(height: size.height*0.03,child: FittedBox(child: Text("Enviado a ${transactionProvider.listTransactions.length} woiners", style: TextStyle(color: Colors.grey)))),
            SizedBox(height: size.height*0.02,),
            Container(
              height: size.height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(transactionProvider.listTransactions.length, (int index){
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    height: size.height * 0.1,
                    child: FittedBox(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/casa.jpg'),
                      ),
                    ),
                  );
                }
              ),
              ),
            ),
            SizedBox(height: size.height*0.03,),
            Container(
              height: size.height * 0.2,
              width: double.infinity,
              child: Text('Nota: ${transactionProvider.note}', textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Container(
          width: size.width*0.5,
          margin: EdgeInsets.symmetric(horizontal: size.width*0.25),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          color: Colors.grey[600],
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
              woinerProvider.clearWoinersSelected();
              transactionProvider.clearTransactions();
              keyboardProvider.clearControllerPrices();
            },
            child: Text('Ir a inicio'),
          ),
        )
      ),
    );
  }
}*/
