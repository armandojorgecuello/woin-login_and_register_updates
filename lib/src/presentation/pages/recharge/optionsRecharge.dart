import 'package:flutter/material.dart';
import 'package:woin/src/presentation/pages/recharge/optionsGateway.dart';
import 'package:woin/src/presentation/widgets/ItemList.dart';

class OptionsRecharge extends StatelessWidget {
  OptionsRecharge({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<OptionItem> list = [
      OptionItem(
        startIcon: Container(
          width: size.width * 0.1,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Icon(Icons.pin_drop),
          ),
        ),
        title: Text('Puntos Fisicos Autorizados', style: TextStyle(fontWeight: FontWeight.bold)),
        description: Text('Encuentra información y ubicación de los puntos fisicos autorizados.', style: TextStyle(color: Colors.grey,fontSize: 14.0)),
        endIcon: Icon(Icons.arrow_forward_ios),
        onTap: null
      ),
      OptionItem(
        startIcon: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.account_balance),
        ),
        title: Text('Transferencias Bancarias', style: TextStyle(fontWeight: FontWeight.bold)),
        description: Text('Seleccione la información bancaria para realizar transaferencias.', style: TextStyle(color: Colors.grey,fontSize: 14.0)),
        endIcon: Icon(Icons.arrow_forward_ios),
        onTap: null
      ),
      OptionItem(
        startIcon: CircleAvatar(
          backgroundColor: Colors.greenAccent,
          child: Icon(Icons.devices),
        ),
        title: Text('Pasarelas de Pagos', style: TextStyle(fontWeight: FontWeight.bold)),
        description: Text('Utilice la pasarela donde tenga cuenta registrada, de lo contrario registrese.', style: TextStyle(color: Colors.grey,fontSize: 14.0)),
        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>OptionGateway())),
        endIcon: Icon(Icons.arrow_forward_ios),
      ),
    ];
    
    final List<OptionItemList> listView = [
      OptionItemList(list: list, title: Text(
            'Canales para recargar puntos en su cuenta woin',
            style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Recargar', style: TextStyle(color: Colors.blue),),
        centerTitle: true,
        leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
                onPressed:()=> Navigator.pop(context)
              );
            },
          ),
      ),
      body: SafeArea(
        child: ItemList(
          optionsItems: listView,
        ),
      ),
    );
  }
}