/*

import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:woin/src/presentation/providers/TransactionProvider.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:provider/provider.dart';

class ListWoiners extends StatefulWidget {
  final List<ListWoinerSelected<Woiner>> woiners;
  final Axis direction;
  final bool height;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String page;
  ListWoiners({Key key,@required this.woiners, @required this.direction, this.height = false, @required this.scaffoldKey, @required this.page}) : super(key: key);

  @override
  _ListWoinersState createState() => _ListWoinersState();
}

class _ListWoinersState extends State<ListWoiners> {
  SnackBar snackBar(String text){
    return SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          // Algo de código para ¡deshacer el cambio!
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final woinerProvider = Provider.of<WoinerProvider>(context);
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    final size = MediaQuery.of(context).size;
    return widget.woiners.length<1?Center(child: Text(widget.direction==Axis.vertical?'Busque un woiner por favor': 'No ha seleccionado ningún woiner')):
      ListView(
            scrollDirection: widget.direction,
            // padding: EdgeInsets.all(1.0),
            children: List.generate(widget.woiners.length, (int index){
              return widget.direction==Axis.horizontal?
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: (widget.woiners.length>1? 5: 0)),
                   width: size.width * (widget.woiners.length>1? 0.75: 1),
                   child: InputChip(
                     padding: EdgeInsets.all(0.0),
                    //  shadowColor: Colors.grey,
                    //  elevation: 10.0,
                    //  shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(50.0),
                    //   ),
                     backgroundColor: Colors.grey[200],
                      // label: Text(widget.woiners[index].data.person.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                      label: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(widget.woiners[index].data.person.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            //FlutterMoneyFormatter(amount: 468000000000).output.nonSymbol
                            Text('${FlutterMoneyFormatter(amount: transactionProvider.listTransactions[index].amount).output.nonSymbol}')
                          ],
                        ),
                      deleteIcon: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        splashColor: Colors.red,
                        child: Icon(Icons.close, color: Colors.red,size: 17.0,),
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (_){
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                title: Text('Eliminar woiner', textAlign: TextAlign.center,),
                                content: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.grey, fontSize: 20.0),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Desea eliminar a '),
                                      TextSpan(text: '${widget.woiners[index].data.person.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                                      TextSpan(text: ' de la lista ?')
                                    ]
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: (){
                                      bool resp = woinerProvider.deleteWoiner(index);
                                      print(resp);
                                      if (resp) {
                                        widget.scaffoldKey.currentState.showSnackBar(snackBar('Se eliminó de la lista'));
                                      }
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok')
                                  ),
                                  FlatButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancelar')
                                  )
                                ],
                              );
                            },
                            barrierDismissible: false,
                          );
                        },
                      ),
                      deleteIconColor: Colors.red,
                      avatar: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/casa.jpg'),
                      ),
                      onDeleted: (){},
                      // isEnabled: true,
                      selected: widget.woiners[index].isSelected,
                      
                      onPressed: woinerProvider.countListSelect()==widget.woiners.length || widget.page == 'searchWoiner'?null: (){
                        setState(() {
                          widget.woiners.firstWhere((t)=>t.data == woinerProvider.woinerSelected, orElse: ()=>null)?.isSelected=false;
                          widget.woiners[index].isSelected = !widget.woiners[index].isSelected;
                          List<ListWoinerSelected<Woiner>> woinersIsSelect = widget.woiners.where((t)=>t.isSelected).toList();
                          if(woinersIsSelect.length == 1){
                            woinerProvider.changeWoinerSelected(widget.woiners[index].data);
                          }else woinerProvider.clearWoinerSelected();
                          if(widget.woiners[index].isSelected){
                            // String price = woinerProvider.listTransactions.firstWhere((t)=>t.woinerReceiver==widget.woiners[index].data.id).amount.toString();
                            String price = transactionProvider.listTransactions.firstWhere((t)=>t.woinerReceiver==widget.woiners[index].data.id).amount.toString();
                            print('precio: $price');
                            keyboardProvider.changeControllerPrices(price);
                          }
                          woinerProvider.changeCheckTodo(widget.woiners[index].isSelected);
                          // woinerProvider.changeIsSelect(widget.woiners[index]);
                          // woinerProvider.changeCheckTodo(widget.woiners[index].isSelected);
                          // print(woinerProvider.countListSelect());
                          // if(woinerProvider.countListSelect()==1){
                          //   Woiner w = woinerProvider.listWoiner.firstWhere((woiner)=>woiner.isSelected == true)?.data??null;
                          //   woinerProvider.changeWoinerSelected(w);
                          // }else woinerProvider.changeWoinerSelected(null);
                        });
                      },
                    ),
                 )
              :
              Card(
                margin: EdgeInsets.fromLTRB(
                  size.width * 0.03,
                  index==0?-0:size.width * 0.03,
                  size.width * 0.03,
                  index==widget.woiners.length-1?MediaQuery.of(context).size.height * 0.03:0
                ),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  // alignment: Alignment.center,
                  height: widget.height?size.height*0.1: null,
                  width: size.width * 0.95,
                  // padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    // color: widget.woiners[index].isSelected?Colors.blue:Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                      onTap: (){
                        bool respWoiner = woinerProvider.addWoiner(widget.woiners[index].data);
                        if (respWoiner) transactionProvider.addTransaction(widget.woiners[index].data.id);
                        else widget.scaffoldKey.currentState.showSnackBar(snackBar('Ya seleccionó este woiner'));
                      },
                      title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(widget.woiners[index].data.person.name, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                            Text('email@email.com', style: TextStyle(color: Colors.grey,))
                          ],
                        ),
                      leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/casa.jpg'),
                        ),
                      trailing: Container(
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            gradient:widget.woiners[index].data.type=='2'?
                              LinearGradient(
                                colors: [Color.fromRGBO(0, 255, 229, 1), Color.fromRGBO(13, 183, 203, 1), Color.fromRGBO(0, 117, 177, 1)],
                                stops: [0.01,0.15,0.5],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft
                              ):
                              LinearGradient(
                                colors: [Color.fromRGBO(255, 238, 0, 1),Color.fromRGBO(194, 159, 0, 1),  Color.fromRGBO(128, 73, 0, 1)],
                                stops: [0.08,0.22, 0.8],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft
                              ),
                            // color: index == 0?Colors.blue[700]:Colors.amber[500],
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Text(widget.woiners[index].data.type=='2'?'cli':'em'),
                          ),
                        ),
                    )
                  ),
                )
              );
            }),
    );
  }
}
*/
