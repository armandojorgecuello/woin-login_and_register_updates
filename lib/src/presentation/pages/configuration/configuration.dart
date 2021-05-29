/*import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:woin/src/presentation/pages/configuration/config_points_woin.dart';

class Configuration extends KFDrawerContent {
  // Configuration({Key key}) : super(key: key);

  @override
  _ConfigurationState createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración', style: TextStyle(color: Colors.blue),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
              onPressed:widget.onMenuPressed
            );
          },
        ),
      ),
       body: SafeArea(
         child: ListView(
           children: <Widget>[
             ListTile(
               leading: Icon(Icons.settings),
               title: Text('Configurar puntos'),
               onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfigPointsWoin())),
               trailing: Icon(Icons.arrow_forward_ios, size: 14,)
             ),
             ListTile(
               leading: Icon(Icons.lock),
               title: Text('Configurar pin, huella'),
               onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfigPointsWoin())),
               trailing: Icon(Icons.arrow_forward_ios, size: 14,),
             ),
             ListTile(
               leading: Icon(Icons.account_balance),
               title: Text('Configurar cuenta bancaria'),
               onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfigPointsWoin())),
               trailing: Icon(Icons.arrow_forward_ios, size: 14,)
             ),
           ],
         ),
       ),
    );
  }
}*/
