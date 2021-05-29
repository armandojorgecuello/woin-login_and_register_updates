/*import 'package:flutter/material.dart';
import 'package:woin/src/entities/configuration/ConfigPoint.dart';
import 'package:woin/src/services/ConfigurationService.dart';

class ConfigPointsWoin extends StatefulWidget {
  ConfigPointsWoin({Key key}) : super(key: key);

  @override
  _ConfigPointsWoinState createState() => _ConfigPointsWoinState();
}

class _ConfigPointsWoinState extends State<ConfigPointsWoin> {
  bool btn_app;
  ConfigPoint configPoint = new ConfigPoint(gift: 12,maxPurshases: 2000000,minPurshases: 1000000,type: 1);
  ConfigPoint configCash = new ConfigPoint(gift: 0,maxPurshases: 0,minPurshases: 0,type: 2);
  final _formKey = GlobalKey<FormState>();
  String msgError = '';
  @override
  void initState() { 
    super.initState();
    this.btn_app = true;
    this.changeConfigPoint();
  }

  void changeConfigPoint() async{
    List<ConfigPoint> resp = await configurationService.getConfig();
    resp.forEach((config)=>{
      if(config.type==1) this.configPoint = config
      else this.configCash = config
    });
    setState(() {
      
    });
  }

  Row row_config_app(String text, int indexRow, String price, bool enabled){
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
            Container(
              width: 150,
              height: 30.0,
              decoration: BoxDecoration(
                color: enabled?Colors.grey[400]:Colors.grey,
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: TextField(
                enabled: enabled,
                keyboardType: TextInputType.number,
                  onChanged: (value){
                    if(value.isEmpty || value == ''){
                      setState(() {
                        switch (indexRow) {
                          case 1: this.configPoint.gift = 0; break;
                          case 2: this.configPoint.minPurshases = 0; break;
                          case 3: this.configPoint.maxPurshases = 0; break;
                          default:
                        }
                      });
                    }
                    setState(() {
                      switch (indexRow) {
                        case 1:
                          configPoint.gift = int.parse(value);
                          int _value = int.parse(value);
                          if (_value >=1 && _value<=100) {
                            this.msgError = '';
                            if (this.configPoint.minPurshases <= 1000000 && _value >=10) {
                              configPoint.gift = int.parse(value);
                              this.msgError = '';
                            }else  if(this.configPoint.minPurshases > 1000000 && _value >=2){
                              configPoint.gift = int.parse(value);
                              this.msgError = '';
                            }else{
                              this.msgError = 'Lea la nota que esta arriba por favor.';
                            }
                          } else {
                            this.msgError = 'El porcentaje de regalo debe estar entre 1 y 100';
                          }
                          
                          break;
                        case 2:
                          configPoint.minPurshases = double.parse(value);
                          break;
                        case 3:
                          configPoint.maxPurshases= double.parse(value);
                          break;
                        default:
                      }
                    });
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: price,
                  ),
                  textAlign: TextAlign.center,
                ),
                
            )
          ],
        );
  }
  Column config_app(){
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(text:'Cuando su cliente '),
              TextSpan(text: 'Pagos con Puntos,', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'la aplicación viene predeterminada para regalar minimo el diez pro ciento (10%) en puntos por compras menores a un millón (1.000.000 w) y el dos porciento (2%) por compras superiores a un millon de pesos (1.000.000 w).')
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        Text(this.msgError, style: TextStyle(color: Colors.red, fontSize: 16.0),),
        Text('Condición Predeterminada 1'),
        SizedBox(height: 10.0,),
        row_config_app('Porcentaje a Regalar %', 1,'10', false),
        SizedBox(height: 10.0,),
        row_config_app('Compras Mínimas', 2, '1000000', false),
        SizedBox(height: 10.0,),
        row_config_app('Compras Maximas', 3, '2000000', false),
        Text('Condición Predeterminada 2'),
        SizedBox(height: 10.0,),
        row_config_app('Porcentaje a Regalar %', 1, configPoint.gift.toString(), true),
        SizedBox(height: 10.0,),
        row_config_app('Compras Mínimas', 2, configPoint.minPurshases.toString(), true),
        SizedBox(height: 10.0,),
        row_config_app('Compras Maximas', 3, configPoint.maxPurshases.toString(), true),
        SizedBox(height: 10.0,),
        
      ],
    );
  }
  Row row_config_gif(String text, int indexRow, String price){
    return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
            Container(
              width: 150,
              height: 30.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.grey
                )
              ),
              child: TextFormField(
                onChanged: (value){
                  setState(() {
                    switch (indexRow) {
                      case 1:
                        this.configCash.gift = int.parse(value);
                        break;
                      case 2:
                        this.configCash.minPurshases = double.parse(value);
                        break;
                      case 3:
                        this.configCash.maxPurshases= double.parse(value);
                        break;
                      default:
                    }
                    price = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: price,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
  }
  Column config_regalar(){
    return Column(
      children: <Widget>[
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey),
            children: <TextSpan>[
              TextSpan(text:'Cuando su cliente '),
              TextSpan(text: 'Pague en Efectivo,', style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'no es obligatorio regalar puntos, por ende es voluntario si desea establecer condiciones en el botón regalar.')
            ]
          ),
        ),
        SizedBox(height: 10.0,),
        Text('Condición Predeterminada 1'),
        SizedBox(height: 10.0,),
        row_config_gif('Porcentaje a Regalar %', 1,this.configCash.gift.toString()),
        SizedBox(height: 10.0,),
        row_config_gif('Compras Mínimas',2, this.configCash.minPurshases.toString()),
        SizedBox(height: 10.0,),
        row_config_gif('Compras Maximas',3, this.configCash.maxPurshases.toString()),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurar puntos', style: TextStyle(color: Colors.blue)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor,),
              onPressed:()=>Navigator.pop(context)
            );
          },
        ),
      ),
       body: SafeArea(
         child: ListView(
           padding: EdgeInsets.symmetric(horizontal: 10.0),
           children: <Widget>[
             CircleAvatar(backgroundColor: Colors.blue, child: Icon(Icons.card_giftcard, color: Colors.white,), minRadius: 25,),
             Text('Establezca el porcentaje para regalar puntos', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
             Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          setState(() {
                            btn_app = true;
                          });
                        },
                        height: 30.0,
                        color: btn_app?Colors.blue:Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.backup, color: btn_app?Colors.white:Colors.blue,),
                            ),
                            Text('Aplicativo', style: TextStyle(fontSize: 12.0, color: btn_app?Colors.white:Colors.blue),),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          setState(() {
                            print('object');
                            btn_app = false;
                          });
                        },
                        height: 30.0,
                        color: btn_app?Colors.white:Colors.blue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Icons.card_giftcard, color: btn_app?Colors.blue:Colors.white,),
                            ),
                            Text('Boton regalar', style: TextStyle(fontSize: 12.0, color: btn_app?Colors.blue:Colors.white),),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                      ),
                    )
                  ],
                ),
             Divider(height: 10.0,),
             Container(
               child: this.btn_app?config_app():config_regalar(),
             )
           ],
         ),
       ),
       bottomNavigationBar: BottomAppBar(
         child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: MaterialButton(
            color: Colors.blue,
            child: Text('Enviar', style: TextStyle(color: Colors.white),),
            onPressed: ()async {
              if (this.btn_app) {
                if (this.configCash.gift != 10 && this.configCash.minPurshases != 1000000) {
                  this.configPoint.type = 1;
                  var resp = await configurationService.postConfigPoint(this.configPoint); 
                  print(resp); 
                }
                showDialog(
                  context: context,
                  builder: (_) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("Pin Incorrecto"),
                      content: new Text("Ingrese nuevamente"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("cerrar"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                this.configCash.type = 2;
                configurationService.postConfigPoint(this.configCash);
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
       ),
    );
  }
}*/
