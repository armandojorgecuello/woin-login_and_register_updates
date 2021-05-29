/*
import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:woin/src/presentation/providers/TransactionProvider.dart';
import 'package:woin/src/presentation/widgets/pin.dart';
import 'package:woin/src/presentation/pages/transactions/searchWoiner.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';
import 'package:woin/src/presentation/widgets/cardWoin.dart';
import 'package:woin/src/presentation/widgets/inputValueKeyboard.dart';
import 'package:woin/src/presentation/widgets/listWoiners.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:woin/src/services/TransactionService.dart';

class Transfers extends StatefulWidget {
  // final Widget cardBody;
  // final int action;
  // final List<Woiner> woiners;
  Transfers({Key key}) : super(key: key);

  @override
  _TransfersState createState() => _TransfersState();
}
enum Opcqr { camera, gallery }
class _TransfersState extends State<Transfers> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final _controller = TextEditingController();
  String _nota = '', title;
  bool action;
  List<Woiner> woiners = [];
  Container cardBody;
  Color colorIcon;
  String actionText;
  int actionSelected = 0;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String barcode = '';
  double woins = 0;
  int percentageGift = 0;

  @override
  void initState() {
    // TODO: implement initState
    getWallet();
    super.initState();
    this.title = 'Acción a realizar';
    this.action = false;
    this.colorIcon = Colors.transparent;
    this.actionText = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getWallet() async {
    double woin = await transactionService.getWallet();
    setState(() {
      this.woins = woin;
    });
  }

  Future _scanCamera() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
  }

  Future _scanGallery() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }

  void _showAlertDialog() {
      showDialog(
        context: context,
        builder: (context) {
          Opcqr _opc;
          return StatefulBuilder(
            builder: (context, setState){
              return AlertDialog(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Escanear QR"),
                    InkWell(
                      child: Icon(Icons.clear),
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  child:Column(
                    children: <Widget>[
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.camera_alt),
                            SizedBox(width: 5.0,),
                            Text('Camara'),
                          ],
                        ),
                        leading: Radio(
                          value: Opcqr.camera,
                          groupValue: _opc,
                          onChanged: (Opcqr value) {
                            print(value);
                            setState(() { _opc = value; });
                            _scanCamera();
                          },
                        ),
                      ),
                      ListTile(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.photo),
                            SizedBox(width: 5.0,),
                            Text('Galeria'),
                          ],
                        ),
                        leading: Radio(
                          value: Opcqr.gallery,
                          groupValue: _opc,
                          onChanged: (Opcqr value) {
                            print(value);
                            setState(() { _opc = value; });
                            _scanGallery();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          );
        }
      );
    }

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final keyboardProvider= Provider.of<KeyboardProvider>(context);
    final woinerProvider = Provider.of<WoinerProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final textColorCard = TextStyle(color: Color.fromRGBO(0, 117, 177, 1));
    showDialogo(){
      _controller.text = this._nota;
      return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      // backgroundColor: Colors.transparent,
      elevation: 30.0,
      child: Container(
        padding: EdgeInsets.all(20.0),
        height: size.height * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Text('Nota', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0), textAlign: TextAlign.start),
            ),
            // SizedBox(height: 10.0,),
            Container(
              height: size.height * 0.15,
              // height: 100.0,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextField(
                style: TextStyle(
                  color: Colors.grey[600]
                ),
                controller: _controller,
                onChanged: (text){
                  this._nota = text;
                  transactionProvider.changeNota(text);
                  // _controller.text = text;
                },
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                  hintText: 'Agregar Nota',
                  hintStyle: TextStyle(color: Colors.blue),
                  contentPadding: EdgeInsets.all(10.0)
                ),         
                maxLines: 7,                                   
                maxLength: 255,
                keyboardType: TextInputType.multiline,
                
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: ButtonTheme(
                    height: 35.0,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: FittedBox(child: Center(child: Text('x Cerrar', style: TextStyle(color: Colors.blue, fontSize: 20.0),))),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(
                          color: Colors.grey[600]
                        )
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                // SizedBox(width: 10.0,),
                // Expanded(
                //   child: ButtonTheme(
                //     height: 45.0,
                //     child: RaisedButton(
                //       padding: EdgeInsets.all(0.0),
                //       onPressed: (){},
                //       child: FittedBox(child: Center(child: Text('Continuar', style: TextStyle(color: Colors.white, fontSize: 20.0),))),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(50.0),
                //       ),
                //       color: Colors.blue,
                //     ),
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
    }
    
    
    String message(){
    return woinerProvider.woinerSelected==null?"woiners ${woinerProvider.listWoiner.length}":"woiner ${woinerProvider.woinerSelected.person.name}";
  }
    double cashWoin(){
      double price = 0;
      if(woinerProvider.checkTodo){
        price = double.parse(keyboardProvider.getPriceWoin) * transactionProvider.listTransactions.length;
      }else{
        transactionProvider.listTransactions.forEach((tran)=>price += tran.amount);
      }
      return price;
    }
    Container bodyCard = Container(
      height: size.height *0.375,
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
                  Container(
                    height: size.height*0.125,
                    child: FittedBox(
                      // child:  Text('Total pago Woin', style: TextStyle(color: Colors.grey),)
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(text: 'Total pago ', style: TextStyle(color: Colors.grey)),
                            TextSpan(text: 'Woin', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: 'arial-rounded')),
                          ]
                        ),
                      ),
                    )
                  ),
                  Container(height: size.height*0.2, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: cashWoin()).output.nonSymbol}', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
                ],
              ),
            ),
          ),
          this.actionSelected==1?
          Container(
            width: 5.0,
            height: double.maxFinite,
            color: Colors.grey,
            margin: EdgeInsets.symmetric(horizontal: 20.0),
          ):Container(),
          this.actionSelected==1?Expanded(
            child: Container(
              // color: Colors.green,
              height: size.height*1,
              // alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: size.height*0.125, child: FittedBox(child: Text('Total a pagar efectivo', style: TextStyle(color: Colors.grey),))),
                  Container(height: size.height*0.2, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: double.parse(keyboardProvider.getPriceCash)).output.symbolOnLeft}', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),))),
                ],
              ),
            ),
          ):Container(),
        ],
      ),
    );
    cardBody = Container(
      height: size.height *1,
      width: size.width*4,
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(height: size.height*0.15, child: FittedBox(child: Text('Disponible', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)))),
          Container(height: size.height*0.25, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: this.woins).output.nonSymbol}', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
          // SizedBox(height: size.height * 0.05,),
          Container(height: size.height*0.125, child: FittedBox(child: Text(message(), style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
          // Text('Usuarios 3'),
          SizedBox(height: size.height * 0.05,),
          bodyCard
          // Container(height: size.height*0.25, child: FittedBox(child: Text('${FlutterMoneyFormatter(amount: double.parse(keyboardProvider.getPriceWoin)).output.nonSymbol}', style: TextStyle(color: textColorCard.color, fontWeight: FontWeight.bold),))),
        ],
      ),
    );
    Widget body = 
        Container(
          height: size.height * 0.8,
          width: size.width * 1,
          child: FittedBox(
            alignment: Alignment.topCenter,
            // fit: BoxFit.fill,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(left: 10.0),
                // margin: EdgeInsets.only(top: size.height*0.08),
                          height: size.height * 0.08,
                          width: size.width * 1.1,
                // padding: EdgeInsets.only(bo),
                child: ListWoiners(
                  woiners: woinerProvider.listWoiner,
                  direction: Axis.horizontal,
                  scaffoldKey: _scaffoldKey,
                  page: 'transfers',
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: size.height * 0.05,
                width: size.width * 1,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            
                          value: woinerProvider.checkTodo,
                            onChanged: woinerProvider.listWoiner.length == 0?null:(check){
                              setState(() {
                                if(check){
                                  woinerProvider.listWoiner.forEach((data)=>data.isSelected = true);
                                  woinerProvider.woinerSelected = null;
                                  keyboardProvider.changeControllerPrices(keyboardProvider.getPriceWoin);
                                  // keyboardProvider.clearPrice(keyboardProvider.getPriceWoin);
                                  if(keyboardProvider.getPriceWoin != '0') woinerProvider.listTransactions.forEach((t)=>t.amount = double.parse(keyboardProvider.getPriceWoin));
                                }else {
                                  woinerProvider.listWoiner.forEach((data)=>data.isSelected = false);
                                  // keyboardProvider.clearPrice();
                                }
                                woinerProvider.changeCheckTodo(check);
                              });
                              
                            }
                          ),
                          Text('Todos', style: TextStyle(color: woinerProvider.listWoiner.length == 0?Colors.grey:Colors.black),),
                        ],
                      ),
                    ),
                    //${woinerProvider.countListSelect()}/
                    Text('${woinerProvider.listWoiner.length}', textAlign: TextAlign.right,style: TextStyle(color: woinerProvider.listWoiner.length == 0?Colors.grey:Colors.black))
                  ],
                ),
                // color: Colors.green,
              ),
              Container(
                width: size.width * 1.1,
                // color: Colors.blue,
                height: size.height * 0.25,child: CardWoin(body:cardBody)),
              SizedBox(height: 10.0,),
              Container(
                height: size.height * 0.12,
                width: size.width * 1,
                margin: EdgeInsets.symmetric(horizontal: size.width*0.05),
                // color: Colors.deepPurple,
                // padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children:<Widget>[
                      Container(
                        width: size.width * (this.actionSelected==2?0.88:1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            InputValueKeyboard(
                              colorContainer: Colors.blue[100],
                              colorValue: textColorCard.color,
                              value: double.parse(keyboardProvider.getPriceWoin),//:woinerProvider.listTransactions.firstWhere((t)=>t.woinerReceiver==woinerProvider.woinerSelected.id).amount,
                              type: 1,
                              transactionType: this.actionSelected == 2?true:false,
                              // shadow: BoxShadow(blurRadius: 10.0, color: Colors.grey)
                            ),
                            // valueKeyboard(Colors.blue[100], textColorCard.color, double.parse(keyboardProvider.getPriceWoin), 1,keyboardProvider.getType==1?this.shadow:BoxShadow(color: Colors.transparent) ),
                            Padding(
                              padding: EdgeInsets.only(bottom: size.height * 0.015),
                            ),
                            this.action? InputValueKeyboard(
                              colorContainer: Colors.grey[100],
                              colorValue: Colors.grey,
                              value: double.parse(this.actionSelected==1?keyboardProvider.getPriceCash:keyboardProvider.getPriceGift),
                              type: this.actionSelected==1?2:3,
                              // shadow: BoxShadow(blurRadius: 10.0, color: Colors.grey)
                          ): Container(),
                        ],
                    ),
                      ),
                      if (this.actionSelected==2) Container(
                        width: size.width*0.1,
                        margin: EdgeInsets.only(left: size.width*0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                setState(() {
                                  this.percentageGift++;
                                });
                                keyboardProvider.setPercentageGift(this.percentageGift);
                              },
                              child: Container(
                                height: 20,
                                // color: Colors.green,
                                child: Icon(Icons.add),
                              ),
                            ),
                            Container(
                              height: 20,
                              margin: EdgeInsets.only(top: 10.0),
                              child: Text(this.percentageGift.toString(), textAlign: TextAlign.center),
                            ),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  this.percentageGift--;
                                });
                                keyboardProvider.setPercentageGift(this.percentageGift);
                              },
                              child: Container(
                                height: 20,
                                padding: EdgeInsets.only(bottom: 5.0),
                                child: Align(alignment: Alignment.topCenter, child: Icon(Icons.remove)),
                              ),
                            ),
                          ],
                        ),
                      ) else Container()
                    ]
                ),
              ),
            ],
          ),
        ),
      );
    
    Widget iconButton(IconData icon, String title, bool action, String actionText, int selected, int typeTransaction){
      return IconButton(icon: Icon(icon, size: 40, color: this.colorIcon,),onPressed: (){
        setState(() {
            this.title = title;
            this.action = action;
            this.actionText = actionText;
            this.actionSelected = selected;
            transactionProvider.changeType(typeTransaction);
            if (fabKey.currentState.isOpen) {
              fabKey.currentState.close();
            } else {
              fabKey.currentState.open();
            }
          });
      });
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this.title, style: TextStyle(color: Colors.blue),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.blue, //change your color here
        ),
        actions: <Widget>[
          Padding(
            padding:EdgeInsets.only(right: size.width*0.02),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              radius: 30,
              onTap: (){
                woinerProvider.clearWoinerSelected();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchWoiner()));
              },
              child: Icon(Icons.person_add, color: Colors.blue)
            ),
          ),
          Padding(
            padding:EdgeInsets.only(right: size.width*0.04),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: (){
                _showAlertDialog();
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>Qr()));
              },
              child: Icon(Icons.crop_free, color: Colors.blue)
            ),
          )
        ],
      ),
       body: SafeArea(
         child: body,
        // child: Container(
        //   width: size.width*1,
        //   color: Colors.green,
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.vertical,
        //     child: body
        //   ),
        // ),
      ),
       floatingActionButton: FabCircularMenu(
         key: fabKey,
            fabOpenIcon: Icon(Icons.import_export),
            ringColor: Colors.blue[200].withOpacity(0.7),
              // ringWidth: 250.0,
            // ringWidth: size.height * 0.4,
            fabCloseColor: Colors.blue,
            fabColor: Colors.red[300],
            ringDiameter: size.height*0.45,
              children: <Widget>[
                iconButton(Icons.account_balance_wallet, 'Pago',true,'pagar woin', 1, 2),
                iconButton(Icons.card_giftcard, 'Regalo',true,'regalar', 2, 3),
                iconButton(Icons.file_download, 'Solictar',false,'solicitar',3, 4),
                iconButton(Icons.import_export, 'Transferir',false,'transferir',4, 1),
              ],
              onDisplayChange: (bool open){
                setState(() {
                  this.colorIcon = open==true?Colors.grey:Colors.transparent;
                });
              },
            ),
       bottomNavigationBar: BottomAppBar(
         elevation: 0.0,
         color: Colors.transparent,
         child: Padding(
           padding: EdgeInsets.only(left: 15.0, bottom: 15.0, right: 15.0),
           child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                splashColor: Colors.blue,
                onTap: (){
                  _controller.text = _nota;
                  showDialog(
                    context: context,
                    builder: (_)=>showDialogo(),
                    barrierDismissible: false,
                  );
                },
                child: Container(
                  height: size.height*0.05,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    // color: Colors.pink,
                    border: Border.all(
                      color: Colors.blue,
                    )
                  ),
                  child: FittedBox(child: Center(child: Text('+ Nota'))),
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            Expanded(
              child: Container(
                height: size.height*0.05,
                child: RaisedButton(
                  
                  padding: EdgeInsets.all(0.0),
                  // onPressed: (this.woiners.length<1 && ) ll,
                  onPressed:
                    ((woinerProvider.woinerSelected != null || woinerProvider.listWoiner.length > 0) && woinerProvider.listTransactions.length > 0 && actionText != '' && transactionProvider.listTransactions.where((t)=>t.amount > 0).toList().length == transactionProvider.listTransactions.length)?
                    (){
                      if (woinerProvider.listWoiner.length > 2) {
                        showDialog(
                          context: context,
                          builder: (_){
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              // backgroundColor: Colors.transparent,
                              elevation: 30.0,
                              child: Container(
                                height: size.height * 0.6,
                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Text('Estos son los woiners que escogiste rectifica con detalle', textAlign: TextAlign.center,),
                                    Container(
                                      height: size.height * 0.4,
                                      child: ListView(
                                        children: List.generate(woinerProvider.listWoiner.length, (int index){
                                          return Container(
                                            padding: EdgeInsets.symmetric(horizontal: 5),
                                            margin: EdgeInsets.symmetric(vertical: 10.0),
                                            width: size.width *  0.95,
                                            height: size.height * 0.07,
                                            child: InputChip(
                                              padding: EdgeInsets.all(0.0),
                                              shadowColor: Colors.grey,
                                              elevation: 10.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50.0),
                                                ),
                                              backgroundColor: Colors.grey[200],
                                                // label: Text(widget.woiners[index].data.person.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                                label: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                      Text(woinerProvider.listWoiner[index].data.person.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                                      //FlutterMoneyFormatter(amount: 468000000000).output.nonSymbol
                                                      Text('${FlutterMoneyFormatter(amount: transactionProvider.listTransactions[index].amount).output.nonSymbol}')
                                                    ],
                                                  ),
                                                deleteIcon: InkWell(
                                                  borderRadius: BorderRadius.circular(50.0),
                                                  splashColor: Colors.red,
                                                  child: Icon(Icons.close, color: Colors.red,size: 17.0,),
                                                ),
                                                deleteIconColor: Colors.red,
                                                avatar: CircleAvatar(
                                                  radius: 20,
                                                  backgroundImage: AssetImage('assets/images/casa.jpg'),
                                                ),
                                                onDeleted: (){},
                                                // isEnabled: true,
                                                selected: true,
                                              ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: ButtonTheme(
                                            height: 45.0,
                                            child: RaisedButton(
                                              padding: EdgeInsets.all(0.0),
                                              onPressed: (){
                                                Navigator.pop(context);
                                              },
                                              child: FittedBox(child: Center(child: Text('x Cerrar', style: TextStyle(color: Colors.red, fontSize: 20.0),))),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50.0),
                                                side: BorderSide(
                                                  color: Colors.red[800]
                                                )
                                              ),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10.0,),
                                        Expanded(
                                          child: ButtonTheme(
                                            height: 45.0,
                                            child: RaisedButton(
                                              padding: EdgeInsets.all(0.0),
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Pin(page: 'transfers',)));
                                              },
                                              child: FittedBox(child: Center(child: Text('Continuar', style: TextStyle(color: Colors.white, fontSize: 20.0),))),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(50.0),
                                              ),
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ),
                            );
                          },
                          barrierDismissible: false,
                        );
                      }else {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Pin(page: 'transfers',)));
                      }
                      
                    }:null,
                  child: FittedBox(child: Center(child: Text('Continuar', style: TextStyle(color: Colors.white, fontSize: 20.0),))),
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
}*/
