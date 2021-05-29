import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/presentation/pages/transactions/userSelected.dart';

class addNota extends StatefulWidget {
  List<userTransactions> luser;
  int editmodo;
  addNota({this.luser, this.editmodo});
  @override
  _addNotaState createState() => _addNotaState();
}

class _addNotaState extends State<addNota> {

  String format(double x) {
    List<String> parts = x.toString().split('.');
    RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

    parts[0] = parts[0].replaceAll(re, '.');
    if (parts.length == 1) {
      parts.add('00');
    } else {
      parts[1] = parts[1].padRight(2, '0').substring(0, 2);
    }
    return parts.join(',');
  }
  Widget _wlist(userTransactions user) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.symmetric(vertical: ResponsiveFlutter.of(context).verticalScale(1), horizontal: 0),
      width: widget.luser.length == 2
          ? ResponsiveFlutter.of(context).wp(50)
          : ResponsiveFlutter.of(context).wp(47),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.editmodo = 1;
            if (luserupdate != null) {
              if (luserupdate.length > 0) {
                luserupdate = null;
              }
            }
            userSelected = user;
            print(user.nota);
            notaController.text = userSelected != null
                ? userSelected.nota != "" ? userSelected.nota : ""
                : "";
            calificacion = user.calificacion;
          });
        },
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[300], width: 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: ResponsiveFlutter.of(context).verticalScale(2)),
          elevation: 1,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      radius: ResponsiveFlutter.of(context).hp(2.8),
                      backgroundColor: user.type == 2
                          ? Color.fromARGB(255, 27, 166, 210)
                          : Color.fromARGB(255, 222, 170, 1),
                      child: CircleAvatar(
                        radius: ResponsiveFlutter.of(context).hp(2.7),
                        backgroundImage: user.imagen != ""
                            ? NetworkImage(user.imagen)
                            : null,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("ELIMINAR");
                      },
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        alignment: Alignment.center,
                        width: ResponsiveFlutter.of(context).wp(8),
                        height: ResponsiveFlutter.of(context).wp(8),
                        child: Icon(
                          FontAwesome.times_circle,
                          color: Colors.grey[500],
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
            Text(
                    user.fullname,
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        fontFamily: "Roboto"),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      format(user.puntos),
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 11,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      "\$" + format(user.compras),
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController notaController;
  double calificacion;
  userTransactions userSelected;
  List<userTransactions> luserupdate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notaController = TextEditingController();
    calificacion = 0;
  }

  modificarNotaUser(userTransactions user) {
    for (userTransactions u in widget.luser) {
      if (u.codewoiner == user.codewoiner) {
        u.nota = user.nota;
        u.calificacion = user.calificacion;
      }
    }
  }

  modificarTodos(String nota) {
    for (userTransactions u in widget.luser) {
      u.calificacion = calificacion;
      u.nota = nota;
    }
  }

  seleccionarMoreUser() {
    for (userTransactions u in widget.luser) {
      if (u.codewoiner == userSelected.codewoiner) {
        u.selected = 1;
      } else {
        u.selected = 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Agregar nota",
          style: TextStyle(
            color: Color.fromARGB(255, 27, 166, 210),
          ),
        ),
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(0),
              splashColor: Colors.white,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.chevron_left,
                size: 25,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
              onPressed: () {
                if (widget.editmodo == 1) {
                  setState(() {
                    widget.editmodo = 0;
                    userSelected = null;
                    calificacion = 0;
                    notaController.text = "";
                  });
                } else {
                  Navigator.of(context).pop();
                }
              },
            );
          }),
        ),
        actions: <Widget>[
          Container(
            //color: Colors.blueAccent,
            margin: EdgeInsets.zero,
            width: 40,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Builder(
              builder: (context) => InkWell(
                onTap: () {},
                splashColor: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    onPressed: null,
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.search,
                      color: Color.fromRGBO(214, 214, 214, 1),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          widget.editmodo == 1
              ? Container(
                  //color: Colors.amber,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: 40,
                  child: Builder(
                    builder: (context) => InkWell(
                      onTap: () {
                        seleccionarMoreUser();
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => userTransacctionSlected(
                                      luserSelected: widget.luser,
                                      redirigirPage: 1,
                                    )))
                            .then((luser) {
                          setState(() {
                            luserupdate = luser;
                            userSelected = null;
                          });
                        });
                      },
                      splashColor: Colors.grey[100],
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: IconButton(
                          onPressed: null,
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.filter_list,
                            color: Color.fromRGBO(214, 214, 214, 1),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(
            width: 2,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          (() {
            if (widget.editmodo == 0) {
              if (widget.luser.length > 0) {
                return Expanded(
                  flex: 3,
                  child: widget.luser.length > 1
                      ? ListView(
                          shrinkWrap: true,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: ResponsiveFlutter.of(context).verticalScale(2)),
                          scrollDirection: Axis.horizontal,
                          children: widget.luser.map(_wlist).toList())
                      : widget.luser.length == 1
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 1),
                              margin: EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 0),
                              width: ResponsiveFlutter.of(context).wp(100),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey[300], width: 0.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                elevation: 1,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: ResponsiveFlutter.of(context).verticalScale(3),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: ResponsiveFlutter.of(context).hp(2.8),
                                            backgroundColor:
                                                widget.luser[0].type == 2
                                                    ? Color.fromARGB(
                                                        255, 27, 166, 210)
                                                    : Color.fromARGB(
                                                        255, 222, 170, 1),
                                            child: CircleAvatar(
                                              radius: ResponsiveFlutter.of(context).hp(2.7),
                                              backgroundImage: widget
                                                          .luser[0].imagen !=
                                                      ""
                                                  ? NetworkImage(
                                                      widget.luser[0].imagen)
                                                  : null,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(8),
                                              height:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(8),
                                              child: Icon(
                                                FontAwesome.times_circle,
                                                color: Colors.grey[500],
                                                size: 20,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                          widget.luser[0].fullname,
                                          style: TextStyle(
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.w300,
                                              fontSize: 10,
                                              fontFamily: "Roboto"),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget.luser[0].puntos.toString(),
                                            style: TextStyle(
                                                color: Colors.blue[700],
                                                fontSize: 11,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "\$" +
                                                widget.luser[0].compras
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ResponsiveFlutter.of(context).verticalScale(3),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),
                );
              } else {
                return SizedBox();
              }
            } else {
              if (luserupdate == null) {
                return Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                    width: ResponsiveFlutter.of(context).wp(100),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey[300], width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      elevation: 1,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: userSelected.type == 2
                                      ? Color.fromARGB(255, 27, 166, 210)
                                      : Color.fromARGB(255, 222, 170, 1),
                                  child: CircleAvatar(
                                    radius: 19,
                                    backgroundImage: userSelected.imagen != ""
                                        ? NetworkImage(userSelected.imagen)
                                        : null,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: ResponsiveFlutter.of(context).wp(8),
                                    height: ResponsiveFlutter.of(context).wp(8),
                                    child: Icon(
                                      FontAwesome.times_circle,
                                      color: Colors.grey[500],
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Flexible(
                              child: Text(
                                userSelected.fullname,
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10,
                                    fontFamily: "Roboto"),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  userSelected.puntos.toString(),
                                  style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "\$" + userSelected.compras.toString(),
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 10,
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                //LISTVIEW PARA REGISTRAR NOTAS A MULTIPLES USUARIOS

                return Expanded(
                  flex: 3,
                  child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      scrollDirection: Axis.horizontal,
                      children: luserupdate
                          .where((user) => user.selected == 1)
                          .map(_wlist)
                          .toList()),
                );
              }
            }
          }()),
          Expanded(
            flex: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  if (widget.editmodo == 1 && userSelected != null) {
                    print("MODIFICAR UNO");
                    userSelected.nota = value;
                    userSelected.calificacion = calificacion;
                    modificarNotaUser(userSelected);
                  }

                  if (widget.editmodo == 1 && luserupdate != null) {
                    print("MODIFICAR VARIOS");
                    for (userTransactions u in luserupdate) {
                      if (u.selected == 1) {
                        u.nota = value;
                        u.calificacion = calificacion;
                      }

                      modificarNotaUser(u);
                    }
                  } else if (widget.editmodo == 0 && widget.luser != null) {
                    print("MODIFICAR TODOS");
                    modificarTodos(value);
                  }
                  setState(() {});
                },
                validator: (val) {
                  if (val.length > 0 && val.length < 15) {
                    return "Nota minima con 15 caracteres";
                  }
                  return null;
                },
                maxLength: 500,
                maxLines: 10,
                controller: notaController,
                style: TextStyle(
                    color: Color(0xfc979797),
                    fontSize: MediaQuery.of(context).size.height * 0.018),
                keyboardType: TextInputType.text,
                autocorrect: true,
                autofocus: false,
                decoration: InputDecoration(
                  isDense: true,
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red[600])
                      // borderSide: new BorderSide(color: Colors.teal)
                      ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.red[600])
                      // borderSide: new BorderSide(color: Colors.teal)
                      ),
                  errorStyle: TextStyle(
                      fontSize: ResponsiveFlutter.of(context).fontSize(1.5)),
                  contentPadding: EdgeInsets.all(10),

                  hintText: userSelected != null
                      ? userSelected.nota != ""
                          ? "Escribe aquí una nota"
                          : "Escribe aquí una nota"
                      : "Escribe aquí una nota",

                  // fillColor: Colors.white,
                  labelStyle: TextStyle(color: Color(0xfc979797)),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey[300])
                      // borderSide: new BorderSide(color: Colors.teal)
                      ),
                  focusedBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey[500])
                      // borderSide: new BorderSide(color: Colors.teal)
                      ),

                  // labelText: 'Correo'
                ),
              ),
            ),
          ),
          widget.luser.length > 0
              ? Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Calificar usuario${widget.luser.length == 1 ? "" : "s"}",
                                style: TextStyle(
                                    color: Colors.grey[900],
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 8,
                                child: RatingBar.builder(
                                  initialRating: userSelected != null
                                      ? userSelected.calificacion==null?0
                                      : 0:0,
                                  itemSize: 30,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  unratedColor: Colors.grey[300],
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.only(right: 3),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),

                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      print(rating);
                                      calificacion = rating;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 40,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text(
                                      calificacion.toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(1, 90, 136, 1),
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ))
              : Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
          Expanded(
            flex: 5,
            child: SizedBox(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.close,
                                  size: 20, color: Color(0xff1ba6d2)),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).wp(1),
                              ),
                              Text(
                                'Cancelar',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                        ResponsiveFlutter.of(context).hp(2)),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            Navigator.pop(context);

                            // print(username);

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ResponsiveFlutter.of(context).wp(3)),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Siguiente',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                        ResponsiveFlutter.of(context).hp(2)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Color(0xff1ba6d2),
                          onPressed: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
