import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:woin/src/presentation/widgets/ItemList.dart';

class OptionGateway extends StatelessWidget {
  const OptionGateway({Key key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    // const url = 'https://flutter.dev';
    bool laun = await canLaunch(url);
    if (laun) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<OptionItem> list = [
      OptionItem(
        startIcon: null,
        title: Image(
          image: AssetImage('assets/images/pasarelas/payulogo.png',),
          height: size.height*0.05,
          alignment: Alignment.center,
        ),
        description: null,
        endIcon: Container(width: size.width*0.05,child: Icon(Icons.arrow_forward_ios, size: 16,),),
        alignContent: CrossAxisAlignment.center,
        onTap: ()=>_launchURL('https://www.payulatam.com/co/bienvenido-comprador-vendedor/'),
      ),
      OptionItem(
        startIcon: null,
        title: Image(
          image: AssetImage('assets/images/epaycologo.png',),
          height: size.height*0.05,
          alignment: Alignment.center,
        ),
        description: null,
        endIcon: Container(width: size.width*0.05,child: Icon(Icons.arrow_forward_ios, size: 16,),),
        alignContent: CrossAxisAlignment.center,
        onTap: ()=>_launchURL('https://dashboard.epayco.co/login#registro'),
      ),
      OptionItem(
        startIcon: null,
        title: Image(
          image: AssetImage('assets/images/paypallogo.png',),
          height: size.height*0.05,
          alignment: Alignment.centerLeft,
        ),
        description: null,
        endIcon: Container(width: size.width*0.05,child: Icon(Icons.arrow_forward_ios, size: 16,),),
        alignContent: CrossAxisAlignment.center,
        onTap: ()=>_launchURL('https://www.paypal.com/co/webapps/mpp/account-selection'),
      )
    ];
    final List<OptionItemList> listView = [
      OptionItemList(list: list)
    ];
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.card_giftcard, color: Colors.white,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
              onPressed:()=>Navigator.pop(context)
            );
          },
        ),
      ),
      body: SafeArea(
        child: ItemList(
          header: Column(
            children: <Widget>[
              Text('Pasarelas de Pagos para recargar puntos', style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              SizedBox(height: 10.0,),
              Text('Utilice la pasarela donde tenga cuenta registrada, de lo contrario registrese con los mismo datos personales almacenados en su cuenta woin', textAlign: TextAlign.center),
              Divider(height: 5.0,)
            ],
          ),
          optionsItems: listView
        ),
      ),
    );
  }
}