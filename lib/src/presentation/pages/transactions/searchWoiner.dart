/*


import 'package:woin/src/entities/woiner/Woiner.dart';
import 'package:woin/src/presentation/widgets/listWoiners.dart';
import 'package:woin/src/services/woinerService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woin/src/presentation/providers/woinerProvider.dart';

class SearchWoiner extends StatefulWidget {
  SearchWoiner({Key key}) : super(key: key);

  @override
  _SearchWoinerState createState() => _SearchWoinerState();
}

class _SearchWoinerState extends State<SearchWoiner> {
  final lista = ['Mi red', 'Cliwoin', 'Emwoin', 'Friend'];
  int selectedContact = -1;
  bool allContact = false;
  final TextEditingController _searchText = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String search;
  int type = 1;
  @override
  void initState() {
    super.initState();
    this.search = '';
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final woinerProvider = Provider.of<WoinerProvider>(context);
    final size = MediaQuery.of(context).size;

    Widget textSearch = Container(
      padding: EdgeInsets.only(left: 3.0),
      margin: EdgeInsets.only(
          left: size.width * 0.05,
          right: size.width *
              0.05), //top: 0.14, left: 40 en true // top:0, left: 20 en false
      width: size.width * 1, // 0.77 en true // 1 en false
      height: size.height * 0.05,
      decoration: BoxDecoration(
          color: Color.fromRGBO(171, 197, 222, 1),
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        onChanged: (text) {
          setState(() {
            if (text.length > 3) {
              this.search = text;
            }
          });
        },
        controller: _searchText,
        onSubmitted: (String t) {
          Navigator.pop(context);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            size: 16.0,
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(bottom: 1.0),
            icon: Icon(
              Icons.cancel,
              color: Colors.grey[700],
              size: 16.0,
            ),
            onPressed: () {
              setState(() {
                _searchText.clear();
              });
            },
          ),
          hintText: 'Buscar nombre, correo, cuenta, cédula',
          hintStyle: TextStyle(fontSize: 15.0),
          // contentPadding: EdgeInsets.only(left: -13, top: -10.0),
        ),
      ),
    );

    Widget listContact = Container(
      margin: EdgeInsets.only(left: 10.0),
      height: MediaQuery.of(context).size.width * 0.1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(1.0),
        children: List.generate(lista.length, (int index) {
          return GestureDetector(
            onTap: () async {
              setState(() {
                this.selectedContact =
                    this.selectedContact == index ? -1 : index;
                if (this.selectedContact == 0) {
                  this.search = '';
                  this.type = 0;
                } else {
                  print('aja y que');
                  this.type = 1;
                }
              });
            },
            onDoubleTap: () {
              setState(() {
                this.selectedContact = -1;
              });
            },
            child: Card(
                margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                    top: 1.5,
                    left: 3.0,
                    bottom: 3.0),
                elevation: 4.0,
                color: this.selectedContact == index
                    ? Color.fromRGBO(171, 197, 222, 1)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Center(
                    child: Text(
                      lista[index],
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
          );
        }),
      ),
    );
    Widget addWoinerDialog(dContext) {
      bool validate = true;
      return StatefulBuilder(builder: (dcontext, setState) {
        return Dialog(
            backgroundColor: Color.fromRGBO(171, 197, 222, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: size.height * 0.55,
              // decoration: BoxDecoration(
              //   color: Color.fromRGBO(171, 197, 222, 1),
              //   borderRadius: BorderRadius.circular(20.0)
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: size.height * 0.15,
                    child: FittedBox(
                        child: Image.asset(
                      'assets/images/addNoWoiner.png',
                      fit: BoxFit.fill,
                    )),
                  ),
                  Text(
                    'Quieres enviar puntos a usuariós no registrados?',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Ingresa el correo del usuario no registrado, una vez se registre, los punots se veran reflejados en la cuenta.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      height: size.height * (validate ? 0.06 : 0.09),
                      // width: size.width * 0.9,
                      // padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        // color: type==0? colorContainer: color,
                        // color: Colors.white,
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon:
                              Icon(Icons.person_add, color: Colors.grey[600]),
                          labelText: 'Correo electronico',
                          // fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.grey[600]),
                          border: new OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            // borderSide: new BorderSide(color: Colors.teal)
                          ),
                          // labelText: 'Correo'
                        ),
                        validator: (email) {
                          if (email.isEmpty)
                            return 'El campo Email no puede estar vacío!';
                          // Regex para validación de email
                          String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                              "\\@" +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                              "(" +
                              "\\." +
                              "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                              ")+";
                          RegExp regExp = new RegExp(p);
                          if (regExp.hasMatch(email)) return null;
                          return 'El Email suministrado no es válido. Intente otro correo electrónico';
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              side: BorderSide(color: Colors.grey)),
                          color: Colors.transparent,
                          elevation: 0.0,
                          child: Text('X Cerrar'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            color: Colors.grey[600],
                            child: Text('Agregar'),
                            onPressed: () {
                              print(_formKey.currentState.validate());
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  validate = true;
                                });
                                // Si el formulario es válido, queremos mostrar un Snackbar
                                Scaffold.of(dcontext).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                              } else {
                                setState(() {
                                  validate = false;
                                });
                              }
                            }),
                      )
                    ],
                  )
                ],
              ),
            ));
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // listWoiners([]),
            /*   FutureBuilder<List<Woiner>>(
              future: woinerService.search(this.search, type: this.type),
              builder: (context, snapshot){          
                List<ListWoinerSelected<Woiner>> woiners = [];
                if (snapshot.hasData) {
                  // return listWoiners(snapshot.data);
                  for (Woiner woiner in snapshot.data) {
                    woiners.add(ListWoinerSelected(woiner));
                    print(woiner.person.name);
                  }
                  return Container(
                    height: size.height * 1,
                    color: Color.fromRGBO(246, 250, 254, 1),
                    padding: EdgeInsets.only(bottom: size.height * 0.003, top: size.height * (woinerProvider.listWoiner.length != 0?0.38:0.3)),
                    child: ListWoiners(woiners: woiners, direction: Axis.vertical, height: true,scaffoldKey: this._scaffoldKey,page: 'searchWoiner',)
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // Por defecto, muestra un loading spinner
                return  Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
            */
            Container(
              height: size.height *
                  (woinerProvider.listWoiner.length == 0
                      ? 0.28
                      : 0.35), //0.2 => si no hay y 0.27 => si hay
              // height: size.height * 0.2,
              color: Colors.transparent,
              child: Card(
                margin: EdgeInsets.all(0.0),
                elevation: 10.0,
                child: Column(
                  children: <Widget>[
                    woinerProvider.listWoiner.length == 0
                        ? Container(
                            margin: EdgeInsets.only(top: size.height * 0.08),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: size.height * 0.08),
                            height: size.height * 0.08,
                            width: size.width * 1,
                            // color: Colors.green,
                            child: ListWoiners(
                              woiners: woinerProvider.listWoiner,
                              direction: Axis.horizontal,
                              scaffoldKey: _scaffoldKey,
                              page: 'searchWoiner',
                            ),
                          ),
                    SizedBox(
                      height: 10.0,
                    ),
                    textSearch,
                    SizedBox(height: 10.0),
                    listContact,
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
                                    value: allContact,
                                    onChanged: (check) {
                                      setState(() {
                                        allContact = !allContact;
                                      });
                                    }),
                                Text(
                                  'Todos',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.blue, //change your color here
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text('Buscar Woiner',
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'arial-rounded',
                        fontWeight: FontWeight.bold)),
                centerTitle: true,
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.055),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (dContext) =>
                                    addWoinerDialog(dContext),
                                barrierDismissible: false);
                            print(woinerProvider.listWoiner.length);
                          },
                          child: Icon(
                            Icons.person_add,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${woinerProvider.listWoiner.length}',
                          style: TextStyle(color: Colors.blue),
                        )
                        // GestureDetector(
                        //   child: Icon(Icons.center_focus_strong, color: Colors.blue, size: 30.0),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
