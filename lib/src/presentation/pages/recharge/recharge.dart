import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Recharge extends StatefulWidget {
  Recharge({Key key}) : super(key: key);

  @override
  _RechargeState createState() => _RechargeState();
}


class _RechargeState extends State<Recharge> {
  bool transfer_bank = true;
  Future<void> _launchURL(String url) async {
    // const url = 'https://flutter.dev';
    bool laun = await canLaunch(url);
    if (laun) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget transfers_banck(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          MaterialButton(
            onPressed: (){},
            height: 30.0,
            color: Colors.white,
            minWidth: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Colombia', style: TextStyle(fontSize: 12.0),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          // SizedBox(width: 5.0,),
          MaterialButton(
            onPressed: (){},
            height: 30.0,
            color: Colors.white,
            minWidth: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Brasil', style: TextStyle(fontSize: 12.0),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          MaterialButton(
            onPressed: (){},
            height: 30.0,
            color: Colors.white,
            minWidth: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('España', style: TextStyle(fontSize: 12.0),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          MaterialButton(
            onPressed: (){},
            height: 30.0,
            color: Colors.white,
            minWidth: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('EE.UU', style: TextStyle(fontSize: 12.0),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
        ],
      ),
              
      Text('Ciudad donde se registro la Cuenta', style: TextStyle(color: Colors.grey),),
      Text('Valledupar', style: TextStyle(fontWeight: FontWeight.bold),),
      Text('Nombre Entidad Bancaria', style: TextStyle(color: Colors.grey),),
      Text('Bancolombia', style: TextStyle(fontWeight: FontWeight.bold),),
      Text('Número de Cuenta Bancaria', style: TextStyle(color: Colors.grey),),
      Text('3680 2014 399916', style: TextStyle(fontWeight: FontWeight.bold),),
      Text('Nombre Títular de la Cuenta', style: TextStyle(color: Colors.grey),),
      Text('WoinS.A.S', style: TextStyle(fontWeight: FontWeight.bold),),
      Text('Identificación Títular de la Cuenta', style: TextStyle(color: Colors.grey),),
      Text('72741215', style: TextStyle(fontWeight: FontWeight.bold),),
      SizedBox(height: 10.0,),
      Text('Si la aplicación Bancaria le permite colocar notas, por favor escriba RECARGA.', textAlign: TextAlign.center,)
    ],
  );
}

  Widget pasarela_pago(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Para ingresar los datos hacer click en uno de los siguientes botones'),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MaterialButton(
              child: Text('PayU'),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              onPressed: ()=>_launchURL('https://www.payulatam.com/co/bienvenido-comprador-vendedor/'),
            ),
            MaterialButton(
              child: Text('ePayco'),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              onPressed: ()=>_launchURL('https://dashboard.epayco.co/login#registro'),
            )
          ],
        ),
        MaterialButton(
          child: Text('PayPal'),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          onPressed: ()=>_launchURL('https://www.paypal.com/co/webapps/mpp/account-selection'),
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Recargar Puntos', style: TextStyle(color: Colors.blue),),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
                onPressed:()=> Navigator.pop(context)
              );
            },
          ),
      ),
      body: SafeArea(

        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Recarge puntos para que realice compras en promoción en establecimientos aliados y sume puntos a su vida.', style: TextStyle(color:Colors.grey),),
              SizedBox(height: 10.0,),
              Text('Los datos personales y bancarios registrados en Woin, deben ser los mismos datos de su cuenta bancaria, de lo contrario le recomendamos actualizar los Datos Bancarios', style: TextStyle(color:Colors.grey),),
              SizedBox(height: 10.0,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          transfer_bank = true;
                        });
                      },
                      height: 30.0,
                      color: transfer_bank?Colors.blue:Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.backup, color: Colors.white,),
                          Text('Transferencia bancaria', style: TextStyle(fontSize: 12.0),),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: MaterialButton(
                      onPressed: (){
                        setState(() {
                          transfer_bank = false;
                        });
                      },
                      height: 30.0,
                      color: transfer_bank?Colors.white:Colors.blue,
                      child: Text('Pasarela de pago', style: TextStyle(fontSize: 12.0),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0,),
              Text('Para realizar transferencia Bancaria seleccione el país con la información de su preferencia, para que ingrese a su banco y realice la transferencia', textAlign: TextAlign.center,style: TextStyle(color: Colors.grey)),
              Container(
                child: transfer_bank?transfers_banck():pasarela_pago()
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
         elevation: 0.0,
         color: Colors.transparent,
         child: Padding(
           padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
           child: Row(
          children: <Widget>[
            // Expanded(
            //   child: InkWell(
            //     splashColor: Colors.blue,
            //     child: Container(
            //       height: size.height*0.05,
            //       padding: EdgeInsets.symmetric(vertical: 5.0),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(50.0),
            //         // color: Colors.pink,
            //         border: Border.all(
            //           color: Colors.blue,
            //         )
            //       ),
            //       child: FittedBox(child: Center(child: Text('+ Nota'))),
            //     ),
            //   ),
            // ),
            // SizedBox(width: 10.0,),
            Expanded(
              child: Container(
                height: size.height*0.05,
                child: RaisedButton(
                  
                  padding: EdgeInsets.all(0.0),
                  // onPressed: (this.woiners.length<1 && ) ll,
                  onPressed:(){},
                  child: FittedBox(child: Center(child: Text('Datos bancarios', style: TextStyle(color: Colors.white, fontSize: 20.0),))),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    // side: BorderSide(
                    //   color: 
                    // )
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}