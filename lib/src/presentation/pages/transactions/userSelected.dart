import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/users/userTransactions.dart';

class userTransacctionSlected extends StatefulWidget {
  List<userTransactions> luserSelected;
  int redirigirPage;
  userTransacctionSlected({this.luserSelected, this.redirigirPage});
  @override
  _userTransacctionSlectedState createState() =>
      _userTransacctionSlectedState();
}

class _userTransacctionSlectedState extends State<userTransacctionSlected> {
  int opcionFilter = -1;
  ScrollController _scrollctrl;
  bool valueAll = false;
  List<userTransactions> luserSelectedT;

  seleccionarAll() {
    //print("lengh show=>" + listShow.length.toString());
    for (userTransactions user in luserSelectedT) {
      user.selected = 1;
    }

    setState(() {});
  }

  deseleccionarAll() {
    for (userTransactions user in luserSelectedT) {
      user.selected = 0;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    luserSelectedT = List();
    for (userTransactions u in widget.luserSelected) {
      userTransactions us = userTransactions(
          cedula: u.cedula,
          ciudad: u.ciudad,
          codciudad: u.codciudad,
          codewoiner: u.codewoiner,
          codpais: u.codpais,
          compras: u.compras,
          email: u.email,
          fullname: u.fullname,
          imagen: u.imagen,
          indicativo: u.indicativo,
          ncuenta: u.ncuenta,
          pais: u.pais,
          puntos: u.puntos,
          red: u.red,
          selected: u.selected,
          telefono: u.telefono,
          tipoStr: u.tipoStr,
          type: u.type,
          ventas: u.ventas,
          woinerId: u.woinerId);
      luserSelectedT.add(us);
    }
    _scrollctrl = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Usuarios seleccionados",
          style: TextStyle(
            color: Color.fromARGB(255, 27, 166, 210),
            fontSize: 16,
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
                Navigator.of(context).pop();
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
                      Icons.filter_list,
                      color: Color(
                        0xffbbbbbb,
                      ),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                      color: Color(
                        0xffbbbbbb,
                      ),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: ListView(
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(vertical: 10),
                controller: _scrollctrl,
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // valueAll = false;
                          opcionFilter = 0;
                          _scrollctrl.animateTo(0,
                              duration: new Duration(milliseconds: 200),
                              curve: Curves.easeIn);

                          // buscartipo(0, selectedAll);
                          // isAllSelected(opcionFilter);
                        });
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        child: Center(
                          child: Text(
                            "Mi red",
                            style: TextStyle(
                                color: opcionFilter == 0
                                    ? Colors.blue[400]
                                    : Colors.grey[400]),
                          ),
                        ),
                        elevation: opcionFilter == 0 ? 5 : 1,
                      ),
                    ),
                    height: ResponsiveFlutter.of(context).hp(.25),
                    width: ResponsiveFlutter.of(context).wp(27),
                    margin: EdgeInsets.only(
                        right: ResponsiveFlutter.of(context).wp(1)),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // valueAll = false;
                          opcionFilter = 2;

                          // buscartipo(2, selectedAll);
                          // isAllSelected(opcionFilter);
                        });
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        child: Center(
                          child: Text(
                            "Cliwoin",
                            style: TextStyle(
                                color: opcionFilter == 2
                                    ? Colors.blue[400]
                                    : Colors.grey[400]),
                          ),
                        ),
                        elevation: opcionFilter == 2 ? 5 : 1,
                      ),
                    ),
                    height: ResponsiveFlutter.of(context).hp(.25),
                    width: ResponsiveFlutter.of(context).wp(27),
                    margin: EdgeInsets.only(
                        right: ResponsiveFlutter.of(context).wp(1)),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //valueAll = false;
                          opcionFilter = 3;

                          //buscartipo(3, selectedAll);
                          //isAllSelected(opcionFilter);
                        });
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        child: Center(
                          child: Text(
                            "Emwoin",
                            style: TextStyle(
                                color: opcionFilter == 3
                                    ? Colors.blue[300]
                                    : Colors.grey[400]),
                          ),
                        ),
                        elevation: opcionFilter == 3 ? 5 : 1,
                      ),
                    ),
                    height: ResponsiveFlutter.of(context).hp(.25),
                    width: ResponsiveFlutter.of(context).wp(27),
                    margin: EdgeInsets.only(
                        right: ResponsiveFlutter.of(context).wp(1)),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          //valueAll = false;
                          opcionFilter = 1;
                          _scrollctrl.animateTo(
                              3 * ResponsiveFlutter.of(context).wp(27),
                              duration: new Duration(seconds: 1),
                              curve: Curves.ease);

                          //buscartipo(1, selectedAll);
                          // isAllSelected(opcionFilter);
                        });
                      },
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                        child: Center(
                            child: Text(
                          "Woiners",
                          style: TextStyle(
                              color: opcionFilter == 1
                                  ? Colors.blue[400]
                                  : Colors.grey[400]),
                        )),
                        elevation: opcionFilter == 1 ? 5 : 1,
                      ),
                    ),
                    height: ResponsiveFlutter.of(context).hp(.25),
                    width: ResponsiveFlutter.of(context).wp(27),
                    margin: EdgeInsets.only(
                        right: ResponsiveFlutter.of(context).wp(1)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 9,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      elevation: 0,
                      child: Row(
                        children: <Widget>[
                          Text("Todos  "),
                          InkWell(
                            onTap: () {
                              setState(() {
                                valueAll = !valueAll;
                                if (valueAll) {
                                  seleccionarAll();
                                } else {
                                  deseleccionarAll();
                                }
                              });
                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  border: valueAll
                                      ? Border()
                                      : Border.all(color: Colors.grey[400]),
                                  shape: BoxShape.circle,
                                  color: valueAll
                                      ? Colors.blue
                                      : Colors.transparent),
                              child: Center(
                                  child: valueAll
                                      ? Icon(
                                          Icons.check,
                                          size: 20.0,
                                          color: Colors.white,
                                        )
                                      : SizedBox()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: ListView.builder(
              itemCount: luserSelectedT.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      print("SELECCIONAR");
                      luserSelectedT[index].selected =
                          luserSelectedT[index].selected == 0 ? 1 : 0;
                    });
                  },
                  child: Container(
                    height: ResponsiveFlutter.of(context).verticalScale(90),
                    child: Card(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ResponsiveFlutter.of(context).scale(7)),
                              child: CircleAvatar(
                                radius:
                                    ResponsiveFlutter.of(context).scale(29.0),
                                backgroundImage: luserSelectedT[index].imagen !=
                                        ""
                                    ? NetworkImage(luserSelectedT[index].imagen)
                                    : null,
                                backgroundColor:
                                    luserSelectedT[index].imagen == ""
                                        ? Colors.transparent
                                        : Colors.transparent,
                                child: luserSelectedT[index].imagen == ""
                                    ? Center(
                                        child: Text(
                                          luserSelectedT[index].fullname[0],
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      )
                                    : SizedBox(),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 16,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: ResponsiveFlutter.of(context)
                                      .verticalScale(10),
                                ),
                                Flexible(
                                  child: Text(
                                    widget.luserSelected[index].fullname
                                        .substring(0, 25),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    widget.luserSelected[index].puntos
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue[400]),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4, top: 3),
                                  child: Text(
                                    "\$ " +
                                        widget.luserSelected[index].compras
                                            .toString(),
                                    style: TextStyle(fontSize: 11),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveFlutter.of(context)
                                      .verticalScale(10),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: luserSelectedT[index].selected == 0
                                        ? Border.all(color: Colors.grey[300])
                                        : Border(),
                                    color: luserSelectedT[index].selected ==
                                                1 &&
                                            luserSelectedT[index].type == 2
                                        ? Colors.blue
                                        : luserSelectedT[index].selected == 1 &&
                                                luserSelectedT[index].type == 3
                                            ? Colors.orange
                                            : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      luserSelectedT[index].type == 2
                                          ? "Cli"
                                          : "Em",
                                      style: TextStyle(
                                        color:
                                            luserSelectedT[index].selected == 1
                                                ? Colors.white
                                                : Colors.grey[400],
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: ResponsiveFlutter.of(context).hp(.8),
                      ),
                    ),
                  ),
                );
              },
              padding:
                  EdgeInsets.only(top: ResponsiveFlutter.of(context).hp(1)),
            ),
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
                            //1=>NOTA  0=>SALDO
                            if (widget.redirigirPage == 1) {
                              Navigator.of(context).pop(luserSelectedT);
                            } else {
                              Navigator.of(context).pop(luserSelectedT);
                            }
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
