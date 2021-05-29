import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Cartera/Cartera.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';
import 'package:woin/src/helpers/utils.dart';

import 'package:woin/src/presentation/pages/Personalizados_Widgets/SlidableUsers.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';

import 'package:woin/src/presentation/pages/Personalizados_Widgets/filterUbicacion.dart';
import 'package:woin/src/presentation/pages/principal/card_swiper.dart';
import 'package:woin/src/presentation/pages/transactions/steps/confirmTransactions.dart';
import 'package:woin/src/presentation/pages/transactions/steps/detalleTransactios.dart';
import 'package:woin/src/presentation/pages/transactions/steps/tarjetaTransactions.dart';
import 'package:woin/src/presentation/pages/transactions/steps/transactionsMonto.dart';
import 'package:woin/src/presentation/pages/transactions/userSelected.dart';
import 'package:woin/src/presentation/pages/usuario/AddWoiner/typeWoiner.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/providers/current_account_provider.dart';
import 'package:woin/src/providers/login_provider.dart';
import 'package:woin/src/services/CarteraService/carteraService.dart';
import 'package:woin/src/services/ServiceWallet/ServiceWallet.dart';
import 'package:woin/src/services/Transactions/TransactionsService.dart';
import 'package:woin/src/services/usuario/blocUser.dart';
import 'package:woin/src/services/usuario/blocUserTransactions.dart';
import 'package:woin/src/providers/user_service.dart';
import 'package:woin/src/widgets/clippers_transactions.dart';

class transactionGnal extends StatefulWidget {
  List<userTransactions> userSelected;
  int editMode;
  int opcion;
  MontoTransactions monto;

  transactionGnal({this.opcion, this.monto, this.userSelected, this.editMode});

  @override
  _transactionGnalState createState() => _transactionGnalState();
}


class _transactionGnalState extends State<transactionGnal>
    with SingleTickerProviderStateMixin {
  CurrentAccount sesion = new CurrentAccount();
  GlobalKey<mainTransactionsUState> _keyChild1 = GlobalKey();

  String titulo = "";
  int disabled = 0;
  int page = 2;
  int cuentaActiva = 0;
  int buscar = 0;
  String texto = "";
  countryCity filterUbicacion;

  NetworkImage imagen;

  NetworkImage imagenUser() {
    return NetworkImage(sesion.getCuentaActiva == 2
        ? sesion.getImageCli != null ? sesion.getImageCli : ""
        : sesion.getImageEm != null ? sesion.getImageEm : "");
  }

  TextEditingController busquedaCtrl = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cuentaActiva = sesion.getCuentaActiva;
    titulo = widget.opcion == 0
        ? "Pagar"
        : widget.opcion == 1
            ? "Regalar"
            : widget.opcion == 2 ? "Prestar" : "Solicitar";
    filterUbicacion = countryCity();
    filterUbicacion.setCity = new Cities(id: -1, name: "Todos");
    filterUbicacion.setCountry = new Country(id: -1, name: "Todos");

    imagen = imagenUser();

    //print("CUENTA ACTIVA=>" + cuentaActiva.toString());
  }

  @override
  Widget build(BuildContext context) {
    final userLogin = Provider.of<LoginProvider>(context).userDetail;
    Widget switchUser(double alto, double ancho, BuildContext context) {
      return StreamBuilder(
        stream: tipoUser.tipoUser,
        builder: (builder, snapshot) {
          double anchobtn = alto * 0.1;
          return snapshot.hasData
              ? GestureDetector(
                  onTap: () {
                    snapshot.data == 2
                        ? tipoUser.asignarTipo.add(3)
                        : tipoUser.asignarTipo.add(2);

                    if (snapshot.data == 3) {
                      //CREAR CUENTA EM SI NO TENGO
                      if (sesion.isTipoUser(3)) {
                        print("SI TENGO");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WoinerAccountSelected(typeUserProfile: userLogin.typeDefault )),
                        );
                      }
                    } else {
                      // CREAR CUENTA CLI SI NO TENGO

                      if (sesion.isTipoUser(2)) {
                        print("TENGO CLI");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WoinerAccountSelected(typeUserProfile: userLogin.typeDefault )),
                        );
                      }
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: anchobtn * .9,
                    width: alto * 0.2,
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white, width: .3),
                        color: Colors.white),
                    child: Stack(
                      children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                          top: anchobtn * .04,
                          left: snapshot.data == 3 ? anchobtn * .99 : 0,
                          right: snapshot.data == 3 ? 0 : anchobtn * .99,
                          child: InkWell(
                            onTap: () {
                              snapshot.data == 2
                                  ? tipoUser.asignarTipo.add(3)
                                  : tipoUser.asignarTipo.add(2);
                              //print(togglevalue);
                            },
                            child: AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                transitionBuilder: (Widget child,
                                    Animation<double> animation) {
                                  return RotationTransition(
                                      child: child, turns: animation);
                                },
                                child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 0.5, right: 0.5),
                                    child: Container(
                                      height: alto * .078,
                                      width: anchobtn * .98,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: snapshot.data == 3
                                            ? Color.fromRGBO(182, 104, 9, .6)
                                            : Color.fromRGBO(13, 183, 203, 1),
                                      ),
                                    ))),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: anchobtn * .02,
                                  right: anchobtn * .02,
                                  top: anchobtn * .15),
                              child: Text(
                                " Cli",
                                style: TextStyle(
                                    fontSize: anchobtn * .45,
                                    color: Colors.black26),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 2, right: 2, top: 3),
                              child: Text(
                                "Em",
                                style: TextStyle(
                                    fontSize: anchobtn * .45,
                                    color: Colors.black26),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : SizedBox();
        },
      );
    }

    Widget buscador() {
      return SizedBox(
        height: 34,
        //width: MediaQuery.of(context).size.width * .92,
        child: Padding(
          padding: EdgeInsets.only(right: 12),
          child: TextField(
            onChanged: (value) {
              setState(() {
                texto = value;
                // print("CAMBIO DE TEXTO");
              });
            },
            controller: busquedaCtrl,
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: MediaQuery.of(context).size.height * .018),
            keyboardType: TextInputType.emailAddress,
            autocorrect: true,
            autofocus: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),

              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              hintText: 'buscar usuario',
              suffixIcon: busquedaCtrl.text != ""
                  ? InkWell(
                      onTap: () {
                        busquedaCtrl.text = "";
                        setState(() {});
                      },
                      child: Icon(Icons.cancel, color: Colors.grey[500]))
                  : SizedBox(),

              // fillColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: MediaQuery.of(context).size.height * .018),
              enabledBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Colors.grey[300])
                  // borderSide: new BorderSide(color: Colors.teal)
                  ),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  borderSide: BorderSide(color: Colors.grey[500])
                  // borderSide: new BorderSide(color: Colors.teal)
                  ),

              // labelText: 'Correo'
            ),
          ),
        ),
      );
    }

    double size = MediaQuery.of(context).size.width;
    double anchomenu = size * .71;
    double alturabanner = anchomenu * .70;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        titleSpacing: buscar == 0 ? 0 : -8,
        title: buscar == 0
            ? Text(
                titulo,
                style: TextStyle(
                  color: page != 2 ? Colors.white : Color(0xff1ba6d2),
                  fontWeight: FontWeight.w700,
                ),
              )
            : buscador(),
        brightness: Brightness.light,
        flexibleSpace: page != 2
            ? StreamBuilder<userdetalle>(
                stream: tipoUser.userSesionG,
                builder: (builder, snapshot) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: snapshot.hasData
                          ? snapshot.data.getCuentaActiva == 2
                              ? LinearGradient(
                                  colors: [
                                      Color.fromRGBO(0, 117, 177, 1),
                                      Color.fromRGBO(13, 183, 203, 1),
                                      Color.fromRGBO(13, 183, 203, 1),
                                    ],
                                  stops: [
                                      0.01,
                                      0.2,
                                      0.7,
                                    ],
                                  begin: FractionalOffset.topRight,
                                  end: FractionalOffset.bottomLeft)
                              : snapshot.data.getCuentaActiva == 3
                                  ? LinearGradient(
                                      colors: [
                                          Color.fromRGBO(128, 73, 0, 1),
                                          Color.fromRGBO(194, 159, 0, 1),
                                          Color.fromRGBO(194, 159, 0, 1),
                                        ],
                                      stops: [
                                          0.01,
                                          0.2,
                                          0.7
                                        ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)
                                  : LinearGradient(
                                      colors: [
                                          Colors.white,
                                          Colors.white,
                                          Colors.white
                                        ],
                                      stops: [
                                          0.08,
                                          0.22,
                                          0.8
                                        ],
                                      begin: FractionalOffset.topRight,
                                      end: FractionalOffset.bottomLeft)
                          : LinearGradient(
                              colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white
                                ],
                              stops: [
                                  0.08,
                                  0.22,
                                  0.8
                                ],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomLeft),
                    ),
                  );
                })
            : Container(
                color: Colors.white,
              ),
        elevation: 0,
        centerTitle: true,
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(3),
              splashColor: Colors.white,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: page != 2
                    ? Colors.white
                    : Color(
                        0xffbbbbbb,
                      ),
              ),
              onPressed: () {
                if (buscar == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() {
                    buscar = 0;
                  });
                }
              },
            );
          }),
        ),
        actions: <Widget>[
          page == 2 && buscar == 0
              ? IconButton(
                  onPressed: () {
                    //print("BUSCAR");
                    setState(() {
                      buscar = 1;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                )
              : page != 2
                  ? Center(child: switchUser(alturabanner, anchomenu, context))
                  : SizedBox(),
          page != 2
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * .032,
                )
              : SizedBox(),
          buscar == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Icon(
                    Icons.center_focus_weak,
                    color: Colors.grey[400],
                  ))
              : InkWell(
                  onTap: () {
                    showDialogFilterUbicacion(context, filterUbicacion)
                        .then((ccity) {
                      setState(() {
                        filterUbicacion = ccity;
                      });
                      _keyChild1.currentState.actualizarPaisCiudad(ccity);
                    });
                  },
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.grey[400],
                      )),
                ),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: mainTransactionsU(
        ctrl: busquedaCtrl,
        monto: widget.monto,
        opcion: widget.opcion,
        key: _keyChild1,
        users: widget.userSelected,
        editMode: widget.editMode,
        filterUbicacion: filterUbicacion,
      ),
    );
  }
}

class mainTransactionsU extends StatefulWidget {
  TextEditingController ctrl;
  List<userTransactions> users;
  int opcion;
  MontoTransactions monto;
  int editMode;
  countryCity filterUbicacion;
  Key key;

  mainTransactionsU(
      {this.ctrl,
      this.opcion,
      this.monto,
      this.users,
      this.editMode,
      this.filterUbicacion,
      this.key});

  @override
  mainTransactionsUState createState() => mainTransactionsUState();
}

class mainTransactionsUState extends State<mainTransactionsU>
    with SingleTickerProviderStateMixin {
  int divisionPage = 99999;
  int opcionFilter = 0;
  bool r = false;
  ScrollController scrollCtrl = new ScrollController();
  int totUsers = 0;
  int isLoading = 0;
  int recharge = 0;
  List<userTransactions> uRed = new List();
  List<userTransactions> uwoiners = new List();
  List<userTransactions> USER_GENERAL = new List();
  List<userTransactions> listShow = new List();
  List<userTransactions> lselected = new List();
  List<userTransactions> lReferidos = new List();
  List<userTransactions> lCli = new List();
  List<userTransactions> lEm = new List();
  int cargado = 0;
  int moreUser = 0;
  List<int> pages = List(4);
  String strBusqueda = "";
  int busquedastr = 0;
  int isLoadingStr = 0;
  TabController _controllertab;
  int selectedAll = 0;
  int selectedindex2 = 1;
  int selectedindex1 = 1;
  int indextab = 0;
  ScrollController _scrollctrl;

  @override
  void initState() {
    super.initState();
    _controllertab = TabController(length: 3, vsync: this);
    _scrollctrl = ScrollController();

    widget.ctrl.addListener(busquedaString);
    opcionFilter = sesion.getCuentaActiva;
    // scrollCtrl.addListener(scrollMoreUsers);

    //print("INIT");
    if (usersTransactionBloc.lGENAL.length == 0) {
      print("FIRST DATOS INIT");
      firstDatos().then((r) {
        if (r == 1) {
          print("ENTRO ACA");
          seleccionarUserSelected();
        } else {
          print("EXCEPTION");
        }
      });
    } else {
      // print("YA CARGADOS");
      USER_GENERAL = usersTransactionBloc.lGENAL;
      deselecionarAllNew();
      lselected.clear();
      usersTransactionBloc.ldelete.clear();

      buscartipo(opcionFilter, valueAll ? 1 : 0);
      seleccionarUserSelected();

      calcularMontoFinal();
      setState(() {
        cargado = 1;
      });
    }
    if (widget.editMode == 0) {
     
    } else {
      USER_GENERAL.addAll(widget.users);
      cargado = 1;
      buscartipo(2, 0);
    }
  }

  seleccionarUserSelected() {
    if (widget.editMode == 1) {
      for (userTransactions u in widget.users) {
        for (userTransactions us in USER_GENERAL) {
          if (u.codewoiner == us.codewoiner) {
            us.selected = 1;
          }
        }
      }
    }
  }

  deselecionarAllNew() {
    for (userTransactions u in USER_GENERAL) {
      u.selected = 0;
    }
    setState(() {});
  }

  seleccionarAll() {
    print("lengh show=>" + listShow.length.toString());
    for (userTransactions user in listShow) {
      for (userTransactions u in USER_GENERAL) {
        if (u.codewoiner == user.codewoiner) {
          u.selected = 1;
        }
      }

      if (!buscarInLista(lselected, user)) {
        lselected.add(user);
      } else {
        print("NO AGREGO UNO");
      }
      user.selected = 1;
    }
    print("lselected" + lselected.length.toString());
    calcularMontoFinal();
    setState(() {});
  }

  removerSeleccionadoOne(userTransactions u) {
    int indexr = -1, indexs = -1;
    for (int i = 0; i < lReferidos.length; i++) {
      if (lReferidos[i].email == u.email) {
        indexr = i;
        break;
      }
    }

    for (int i = 0; i < lselected.length; i++) {
      if (lselected[i].email == u.email) {
        indexs = i;
        break;
      }
    }
    if (indexr >= 0) {
      lReferidos.removeAt(indexr);
    }

    if (indexs >= 0) {
      lselected.removeAt(indexs);
    }

    for (int i = 0; i < USER_GENERAL.length; i++) {
      if (USER_GENERAL[i].email == u.email) {
        USER_GENERAL[i].selected = 0;
        break;
      }
    }
    setState(() {});
  }

  eliminarSeleccionados() {
    List<userTransactions> lt = usersTransactionBloc.ldelete;
    print("A ELIMINAR=>" + lt.length.toString());
    for (int i = 0; i < lt.length; i++) {
      // ELIMINAR DE SELECCIONADOS
      List<userTransactions> lsl =
          lselected.where((u) => u.email == lt[i].email).toList();
      if (lsl.length > 0) {
        lselected.remove(lsl.first);
      }
      //SI ESTA EN REFERIDO
      List<userTransactions> lsr =
          lReferidos.where((u) => u.email == lt[i].email).toList();
      if (lsr.length > 0) {
        lReferidos.remove(lsl.first);
      }

      //DESELECCIONAR DE LISTA GENERAL PARA DESMARCAR
      for (userTransactions u in USER_GENERAL) {
        if (u.codewoiner == lt[i].codewoiner) {
          u.selected = 0;
          break;
        }
      }
    }

    usersTransactionBloc.ldelete.clear();
    calcularMontoFinal();
    setState(() {});
  }

  deseleccionarAll() {
    for (userTransactions user in listShow) {
      user.selected = 0;
      if (buscarInLista(lselected, user)) {
        lselected.remove(user);
      }

      for (userTransactions u in USER_GENERAL) {
        if (u.codewoiner == user.codewoiner) {
          u.selected = 0;
        }
      }
    }
    calcularMontoFinal();
    setState(() {});
  }

  busquedaString() async {
    strBusqueda = widget.ctrl.text;
    print("STRBUSQUEDA=>" + widget.ctrl.text);
    setState(() {
      busquedastr = 1;
    });

    buscartipoSTR(opcionFilter, widget.ctrl.text);
  }

  firstDatos() async {
    try {
      filterTransaction filterRed = new filterTransaction(
          pageDesde: 0, pageHasta: divisionPage, search: "", type: 0);
      filterTransaction filterWoiners = new filterTransaction(
          pageDesde: 0, pageHasta: divisionPage, search: "", type: 1);
      filterTransaction filterEm = new filterTransaction(
          pageDesde: 0, pageHasta: divisionPage, search: "", type: 3);
      filterTransaction filterCli = new filterTransaction(
          pageDesde: 0, pageHasta: divisionPage, search: "", type: 2);

      //CARGAR LISTAS GENERALES

      // print("PAGES WOINERS=>" + pages[1].toString());
      lCli = await userService.usuariosTransactions(filterCli);
      print("TERMINO CLI" + lCli.length.toString());
      //pages[2] = (lCli.length / divisionPage).ceil();
      //print("PAGES CLI>" + pages[2].toString());
      lEm = await userService.usuariosTransactions(filterEm);
      print("TERMINO EM" + lEm.length.toString());
      // pages[3] = (lCli.length / divisionPage).ceil();
      //print("PAGES EM>" + pages[3].toString());
      uRed = await userService.usuariosTransactions(filterRed);
      print("TERMINO RED" + uRed.length.toString());
      // pages[0] = (uRed.length / divisionPage).ceil();
      //print("PAGES RED=>" + pages[0].toString());
      uwoiners = await userService.usuariosTransactions(filterWoiners);
      print("TERMINO WOINER" + uwoiners.length.toString());
      //pages[1] = (uwoiners.length / divisionPage).ceil();

      for (userTransactions user in uRed) {
        if (!buscarInLista(USER_GENERAL, user)) {
          USER_GENERAL.add(user);
        }
      }
      print("USER RED LENGTH=>" + USER_GENERAL.length.toString());

      for (userTransactions user in uwoiners) {
        if (!buscarInLista(USER_GENERAL, user)) {
          USER_GENERAL.add(user);
        }
      }

      for (userTransactions user in lCli) {
        if (!buscarInLista(USER_GENERAL, user)) {
          USER_GENERAL.add(user);
        }
      }

      for (userTransactions user in lEm) {
        if (!buscarInLista(USER_GENERAL, user)) {
          USER_GENERAL.add(user);
        }
      }

      print("TOTAL USERS" + USER_GENERAL.length.toString());
      usersTransactionBloc.eventAddlist.add(USER_GENERAL);
      buscartipo(opcionFilter, valueAll ? 1 : 0);
      setState(() {
        cargado = 1;
      });
      return 1;
    } on Exception catch (e) {
      return 0;
    } on NoSuchMethodError catch (er) {
      return 0;
    }
    //CREAR FLITROS INICIALES

    //filterTransaction filter = new filterTransaction(type: opcionFilter);
    //await usersTransactionBloc.filterTypeUser(filter);
  }

  moreUsers() async {
    print(opcionFilter);
    filterTransaction newfilter;
    print("FILTER PAGE=>" + pages[opcionFilter].toString());
    newfilter = new filterTransaction(
        pageDesde: pages[opcionFilter],
        pageHasta: divisionPage,
        search: widget.ctrl.text,
        type: opcionFilter);
    setState(() {
      isLoading = 1;
    });
    List<userTransactions> lresp =
        await userService.usuariosTransactions(newfilter);

    print("LOADING");
    if (lresp.length > 0) {
      for (userTransactions user in lresp) {
        if (!buscarInLista(USER_GENERAL, user)) {
          USER_GENERAL.add(user);
          print("AGREGADO");
        }
      }

      print("MORE USER=>" + USER_GENERAL.length.toString());

      buscartipo(opcionFilter, valueAll ? 1 : 0);

      setState(() {
        moreUser = 1;
        pages[opcionFilter] =
            (obtenertamanolista(opcionFilter) / divisionPage).ceil();
        isLoading = 0;
      });

      print("NO LOADING");
    } else {
      setState(() {
        moreUser = 0;
        isLoading = 0;
      });

      print("NO LOADING");
    }
  }

  int obtenertamanolista(int opcionFilter) {
    int len;

    if (opcionFilter == 0) {
      len = USER_GENERAL.where((u) => u.red == 1).toList().length;
    }
    if (opcionFilter == 1) {
      len = USER_GENERAL.length;
    }
    if (opcionFilter == 2) {
      len = USER_GENERAL.where((u) => u.type == 2).toList().length;
    }
    if (opcionFilter == 3) {
      len = USER_GENERAL.where((u) => u.type == 3).toList().length;
    }

    return len;
  }

  buscarInLista(List<userTransactions> lista, userTransactions user) {
    for (userTransactions u in lista) {
      if (u.codewoiner == user.codewoiner) {
        return true;
      }
    }
    return false;
  }

  buscartipoSTR(int type, String value) async {
    if (value.isNotEmpty) {
      isLoading = 0;
      busquedastr = 1;
      if (type == 0) {
        print("FILTRADO RED STR");
        setState(() {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) =>
                    u.red == 1 &&
                    (u.codewoiner.toLowerCase().contains(value.toLowerCase()) ||
                        u.email.toLowerCase().contains(value.toLowerCase()) ||
                        u.fullname.toLowerCase().contains(value.toLowerCase())))
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            }
          }
        });

        // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
      }
      if (type == 2) {
        print("FILTRADO CLI STR PAIS");
        setState(() {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) =>
                    u.type == 2 &&
                    (u.codewoiner.toLowerCase().contains(value.toLowerCase()) ||
                        u.email.toLowerCase().contains(value.toLowerCase()) ||
                        u.fullname.toLowerCase().contains(value.toLowerCase())))
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            }
          }
        });
        // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
      }
      if (type == 3) {
        print("FILTRADO EM STR PAIS");
        setState(() {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) =>
                    u.type == 3 &&
                    (u.codewoiner.toLowerCase().contains(value.toLowerCase()) ||
                        u.email.toLowerCase().contains(value.toLowerCase()) ||
                        u.fullname.toLowerCase().contains(value.toLowerCase())))
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id &&
                      (u.codewoiner
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            }
          }
        });
      }
      if (type == 1) {
        print("TODOS STR");
        setState(() {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) => (u.codewoiner.toLowerCase().contains(value) ||
                    u.email.toLowerCase().contains(value.toLowerCase()) ||
                    u.fullname.toLowerCase().contains(value.toLowerCase())))
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      (u.codewoiner.toLowerCase().contains(value) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id &&
                      (u.codewoiner.toLowerCase().contains(value) ||
                          u.email.toLowerCase().contains(value.toLowerCase()) ||
                          u.fullname
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                  .toList();
            }
          }
        });

        // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
      }
    } else {
      print("TODA LA LISTA");
      busquedastr = 0;

      buscartipo(opcionFilter, valueAll ? 1 : 0);
    }

    //FILTRADO NEW
  }

  isAllSelected(int type) {
    if (type == 0) {
      int validAll = 1;
      setState(() {
        for (userTransactions u in USER_GENERAL) {
          if (u.selected == 0 && u.red == 1) {
            validAll = 0;
          }
        }
        valueAll = validAll == 1 ? true : false;
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 2) {
      int validAll = 1;
      setState(() {
        for (userTransactions u in USER_GENERAL) {
          if (u.selected == 0 && u.type == 2) {
            validAll = 0;
          }
        }
        valueAll = validAll == 1 ? true : false;
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 3 || type == -1) {
      int validAll = 1;
      setState(() {
        for (userTransactions u in USER_GENERAL) {
          if (u.selected == 0 && u.type == 3 || u.type == 0) {
            validAll = 0;
          }
        }
        valueAll = validAll == 1 ? true : false;
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 1) {
      int validAll = 1;
      setState(() {
        for (userTransactions u in USER_GENERAL) {
          if (u.selected == 0) {
            validAll = 0;
          }
        }
        valueAll = validAll == 1 ? true : false;
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
  }

  actualizarPaisCiudad(countryCity valor) {
    print("ACTUALIZAR PAIS");
    setState(() {
      widget.filterUbicacion = valor;
    });
  }

  buscartipo(int type, int all) {
    if (type == 0) {
      print("FILTRADO RED PAIS");
      setState(() {
        if (all == 1) {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) => u.red == 1 && u.selected == 1)
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        } else {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL.where((u) => u.red == 1).toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.red == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        }
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 2) {
      print("FILTRADO CLI PAIS");
      setState(() {
        if (all == 1) {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) => u.type == 2 && u.selected == 1)
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        } else {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL.where((u) => u.type == 2).toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 2 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        }
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 3) {
      print("FILTRADO EM PAIS");
      setState(() {
        if (all == 1) {
          print("ALL=>" + all.toString());
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL
                .where((u) => u.type == 3 && u.selected == 1)
                .toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        } else {
          print("ENTRO ACA");
          print("ID_ COUNTRY==>" +
              widget.filterUbicacion.getcountry.id.toString());
          if (widget.filterUbicacion.getcountry.id == -1) {
            print(USER_GENERAL.length.toString());
            for (userTransactions u in USER_GENERAL) {
              print(u.type.toString());
            }
            listShow =
                USER_GENERAL.where((u) => u.type == 3 || u.type == 0).toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.type == 3 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        }
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 1) {
      print("TODOS PAIS");
      setState(() {
        if (all == 1) {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL.where((u) => u.selected == 1).toList();
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.selected == 1 &&
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        } else {
          if (widget.filterUbicacion.getcountry.id == -1) {
            listShow = USER_GENERAL;
          } else {
            if (widget.filterUbicacion.getCity.id == -1) {
              listShow = USER_GENERAL
                  .where(
                      (u) => u.codpais == widget.filterUbicacion.getcountry.id)
                  .toList();
            } else {
              listShow = USER_GENERAL
                  .where((u) =>
                      u.codpais == widget.filterUbicacion.getcountry.id &&
                      u.codciudad == widget.filterUbicacion.getCity.id)
                  .toList();
            }
          }
        }
      });
      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
  }

  removerReferidos() {
    lReferidos.clear();
  }

  removerReferido(userTransactions u) {
    int indexr = -1, indexs = 0;
    for (int i = 0; i < lReferidos.length; i++) {
      if (lReferidos[i].email == u.email) {
        indexr = i;
        break;
      }
    }

    for (int i = 0; i < lselected.length; i++) {
      if (lselected[i].email == u.email) {
        indexs = i;
        break;
      }
    }

    lReferidos.removeAt(indexr);
    lselected.removeAt(indexs);
  }

  buscarSeleccionados(int type) {
    print("BUSCAR SELECTED");
    if (type == 0) {
      print("FILTRADO RED");

      listShow =
          USER_GENERAL.where((u) => u.red == 1 && u.selected == 1).toList();

      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 2) {
      print("FILTRADO CLI");

      listShow =
          USER_GENERAL.where((u) => u.type == 2 && u.selected == 1).toList();

      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 3) {
      print("FILTRADO EM");

      listShow =
          USER_GENERAL.where((u) => u.type == 3 && u.selected == 1).toList();

      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
    if (type == 1) {
      print("TODOS");

      listShow = USER_GENERAL.where((u) => u.selected == 1);

      // print(USER_GENERAL.where((u) => u.red == 1).toList().length);
    }
  }

  /*buscarStringBackend(int type) async {
    String value = widget.ctrl.text;
    filterTransaction newfilter;
    newfilter = new filterTransaction(
        pageDesde: (listShow.length / divisionPage).floor(),
        pageHasta: divisionPage,
        search: value,
        type: type);
    setState(() {
      isLoadingStr = 1;
    });

    List<userTransactions> lresp =
        await userService.usuariosTransactions(newfilter);


    //print("LRESP=>" + lresp.length.toString());
    if (lresp.length > 0) {
      setState(() {
        isLoadingStr = 0;
      });
      return lresp;

      // print("MORE USER STR=>" + USER_GENERAL.length.toString());
    } else {
      print("NO HAY");
      setState(() {
        isLoadingStr = 0;
      });
      return null;
    }
  }

  void scrollMoreUsers() async {
    if (busquedastr == 0) {
      print(listShow.length);
      if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
        moreUsers();
      }
    }
  }*/

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

  Container cardsWoin2(context, int id) {
    int index = sesion.getCuentaActiva;

    return Container(
      padding: EdgeInsets.only(
          bottom: ResponsiveFlutter.of(context).verticalScale(4),
          top: ResponsiveFlutter.of(context).verticalScale(0),
          left: 0,
          right: 0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(0),
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 3,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          (() {
                            if (id == 1) {
                              print(id);
                              return "Emwoin";
                            } else if (id == 0) {
                              return "Cliwoin";
                            } else {
                              return "";
                            }
                          }()),
                          style: TextStyle(
                            fontSize: 12,
                            color: (() {
                              if (id == 1) {
                                return Color.fromARGB(255, 222, 170, 1);
                              } else if (id == 0) {
                                return Color.fromARGB(255, 27, 166, 210);
                              } else {
                                return Colors.white;
                              }
                            }()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 0),
                            child: Text(
                              "Mi saldo",
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, top: 0, bottom: 10),
                            child: Text(
                              "46800000.00",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 1, 90, 136),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  widget.opcion != -1
                                      ? Text(
                                          widget.opcion == 1
                                              ? "Pagar puntos:"
                                              : widget.opcion == 2
                                                  ? "Regalar puntos"
                                                  : widget.opcion == 3
                                                      ? "Enviar puntos"
                                                      : "Solicitar puntos",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(255, 1, 90, 136),
                                          ),
                                        )
                                      : Text(
                                          "Valor no asignado",
                                          style: TextStyle(
                                            fontSize: 11,
                                            color:
                                                Color.fromARGB(255, 1, 90, 136),
                                          ),
                                        ),
                                  widget.opcion != -1
                                      ? Text(
                                          "${widget.users == null ? "0" : widget.monto.puntos.toString()}",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 1, 90, 136),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                              widget.opcion == 1 || widget.opcion == 2
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          widget.opcion == 1
                                              ? "Pagar compras"
                                              : "Valor venta",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 11),
                                        ),
                                        Text(
                                          "\$${widget.users == null ? "0" : widget.opcion == 1 ? format(widget.monto.efectivo) : widget.monto.venta}",
                                          style: TextStyle(
                                              color: Colors.grey[500],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[400], width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              child: Container(
                margin: EdgeInsets.only(right: 0.5, top: 0.5),
                width: MediaQuery.of(context).size.width * 0.47,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(235, 237, 242, 1),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
                alignment: Alignment.centerRight,
              ),
              clipper: BottomGreyClipper2(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipPath(
              child: Container(
                margin: EdgeInsets.only(right: 0.5, top: 0.5),
                width: MediaQuery.of(context).size.width * 0.41,
                decoration: BoxDecoration(
                    gradient: (() {
                      if (id == 1) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(255, 238, 0, 1),
                              Color.fromRGBO(194, 159, 0, 1),
                              Color.fromRGBO(128, 73, 0, 1)
                            ],
                            stops: [
                              0.08,
                              0.22,
                              0.8
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      } else if (id == 0) {
                        return LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 255, 229, 1),
                              Color.fromRGBO(13, 183, 203, 1),
                              Color.fromRGBO(0, 117, 177, 1)
                            ],
                            stops: [
                              0.01,
                              0.15,
                              0.5
                            ],
                            begin: FractionalOffset.topRight,
                            end: FractionalOffset.bottomLeft);
                      } else {
                        return LinearGradient(colors: [Colors.white]);
                      }
                    }()),

                    // color: index == 0?Colors.blue[700]:Colors.amber[500],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0))),
              ),
              clipper: BottomWaveClipper2(),
            ),
          ),
          Positioned(
            right: 10,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                color: (() {
                  if (id == 1 && sesion.getImageEm != null) {
                    return Colors.transparent;
                  } else if (id == 0 && sesion.getImageCli != null) {
                    return Colors.transparent;
                  } else {
                    return Colors.grey[200];
                  }
                }()),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    (() {
                      if (id == 1 && sesion.getImageEm != null) {
                        return sesion.getImageEm;
                      } else if (id == 0 && sesion.getImageCli != null) {
                        return sesion.getImageCli;
                      } else {
                        return "";
                      }
                    }()),
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width * .13,
              height: MediaQuery.of(context).size.width * .13,
              child: (() {
                if (id == 1 && sesion.getImageEm != null) {
                  return SizedBox();
                } else if (id == 0 && sesion.getImageCli == null) {
                  return Center(
                    child: Text(
                      "//sesion.getSession.person.fullName[0]",
                      style: TextStyle(color: Colors.grey[900]),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }()),
            ),
          )
        ],
      ),
    );
  }

  calcularMontoFinal() {
    if (widget.monto != null) {
      //MULTIPLICAR SALDO
      if (widget.monto.opcion == 1) {
        int contsel = 0;
        for (userTransactions u in USER_GENERAL) {
          if (u.selected == 1) {
            u.puntos = widget.monto.puntobase;
            u.compras = widget.monto.efbase;
            contsel++;
          }
        }
        widget.monto.puntos = widget.monto.puntobase * contsel;
        widget.monto.efectivo = widget.monto.efbase * contsel;
      }

      //DIVIDIR SALDO
      if (widget.monto.opcion == 2) {
        int totalSel =
            USER_GENERAL.where((u) => u.selected == 1).toList().length;
        double divp = widget.monto.puntos / totalSel;
        print("DIVP=>" + divp.toString());

        double divc = widget.monto.efectivo / totalSel;
        print("DIVC=>" + divc.toString());

        for (userTransactions us in USER_GENERAL) {
          if (us.selected == 1) {
            if (divp >= 1) {
              us.puntos = divp;
            }

            if (divc >= 1) {
              us.compras = divc;
            }
          }
        }
        widget.monto.puntos = widget.monto.puntobase;
        widget.monto.efectivo = widget.monto.efbase;
      }
    }
  }

  TextEditingController emailaddController = TextEditingController();

  bool valueAll = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: widget.editMode == 0 ? 3 : 2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.editMode == 0
                    ? SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(8),
                      )
                    : SizedBox(),
                widget.editMode == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Seleccione usuarios a transferir",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(),
                widget.editMode == 0
                    ? SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(5),
                      )
                    : SizedBox(),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: ResponsiveFlutter.of(context).wp(100),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: false,
                                    scrollDirection: Axis.horizontal,
                                    controller: _scrollctrl,
                                    children: <Widget>[
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              valueAll = false;
                                              opcionFilter = 0;
                                              _scrollctrl.animateTo(0,
                                                  duration: new Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.easeIn);

                                              buscartipo(0, selectedAll);
                                              isAllSelected(opcionFilter);
                                            });
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(5),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10)),
                                            child: Center(
                                              child: Text(
                                                "Mi red",
                                                style: TextStyle(
                                                    color: opcionFilter == 0
                                                        ? Colors.blue[400]
                                                        : Colors.grey[400]),
                                              ),
                                            ),
                                            elevation:
                                                opcionFilter == 0 ? 6 : 2,
                                          ),
                                        ),
                                        height: ResponsiveFlutter.of(context)
                                            .hp(.25),
                                        width: ResponsiveFlutter.of(context)
                                            .wp(27),
                                        margin: EdgeInsets.only(
                                            right: ResponsiveFlutter.of(context)
                                                .wp(1)),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              valueAll = false;
                                              opcionFilter = 2;

                                              buscartipo(2, selectedAll);
                                              isAllSelected(opcionFilter);
                                            });
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(5),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10)),
                                            child: Center(
                                              child: Text(
                                                "Cliwoin",
                                                style: TextStyle(
                                                    color: opcionFilter == 2
                                                        ? Colors.blue[400]
                                                        : Colors.grey[400]),
                                              ),
                                            ),
                                            elevation:
                                                opcionFilter == 2 ? 5 : 2,
                                          ),
                                        ),
                                        height: ResponsiveFlutter.of(context)
                                            .hp(.25),
                                        width: ResponsiveFlutter.of(context)
                                            .wp(27),
                                        margin: EdgeInsets.only(
                                            right: ResponsiveFlutter.of(context)
                                                .wp(1)),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              valueAll = false;
                                              opcionFilter = 3;

                                              buscartipo(3, selectedAll);
                                              //EM REALES
                                              //isAllSelected(opcionFilter);
                                              isAllSelected(-1);
                                            });
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(5),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10)),
                                            child: Center(
                                              child: Text(
                                                "Emwoin",
                                                style: TextStyle(
                                                    color: opcionFilter == 3
                                                        ? Colors.blue[300]
                                                        : Colors.grey[400]),
                                              ),
                                            ),
                                            elevation:
                                                opcionFilter == 3 ? 5 : 2,
                                          ),
                                        ),
                                        height: ResponsiveFlutter.of(context)
                                            .hp(.25),
                                        width: ResponsiveFlutter.of(context)
                                            .wp(27),
                                        margin: EdgeInsets.only(
                                            right: ResponsiveFlutter.of(context)
                                                .wp(1)),
                                      ),
                                      Container(
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              valueAll = false;
                                              opcionFilter = 1;
                                              _scrollctrl.animateTo(
                                                  3 *
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .wp(27),
                                                  duration:
                                                      new Duration(seconds: 1),
                                                  curve: Curves.ease);

                                              buscartipo(1, selectedAll);
                                              isAllSelected(opcionFilter);
                                            });
                                          },
                                          child: Card(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(5),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10)),
                                            child: Center(
                                                child: Text(
                                              "Woiners",
                                              style: TextStyle(
                                                  color: opcionFilter == 1
                                                      ? Colors.blue[400]
                                                      : Colors.grey[400]),
                                            )),
                                            elevation:
                                                opcionFilter == 1 ? 5 : 2,
                                          ),
                                        ),
                                        height: ResponsiveFlutter.of(context)
                                            .hp(.25),
                                        width: ResponsiveFlutter.of(context)
                                            .wp(27),
                                        margin: EdgeInsets.only(
                                            right: ResponsiveFlutter.of(context)
                                                .wp(1)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ResponsiveFlutter.of(context).verticalScale(5),
                ),
              ]),
        ),
        Expanded(
          flex: widget.editMode == 0 ? 15 : 17,
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 9,
                        child: widget.editMode == 0
                            ? Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: TabBar(
                                  controller: _controllertab,
                                  onTap: (index) {
                                    int idx = index;
                                    setState(() {
                                      if ((index == 2 || index == 1) &&
                                          (indextab == index)) {
                                        if (index == 2) {
                                          selectedindex2 = 0;
                                        }
                                        if (index == 1) {
                                          selectedindex1 = 0;
                                        }
                                        //print("ENTRO");
                                        isAllSelected(opcionFilter);
                                        idx = 0;

                                        _controllertab.animateTo(0);
                                      }

                                      if (index == 0 && indextab == index) {
                                        selectedindex1 = 1;
                                        selectedindex2 = 1;
                                        if (selectedAll == 0) {
                                          selectedAll = 1;
                                          buscarSeleccionados(opcionFilter);
                                        } else {
                                          buscartipo(
                                              opcionFilter, valueAll ? 1 : 0);

                                          selectedAll = 0;
                                        }
                                      } else {
                                        opcionFilter = 0;
                                        selectedindex1 = 1;
                                        selectedindex2 = 1;
                                        valueAll = false;
                                        buscartipo(
                                            opcionFilter, valueAll ? 1 : 0);
                                        isAllSelected(opcionFilter);
                                        print("ENTRA ACA");
                                      }
                                      indextab = idx;
                                    });
                                  },
                                  indicatorColor: Colors.transparent,
                                  unselectedLabelColor: Colors.black26,
                                  tabs: [
                                    Tab(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(
                                            LineIcons.user,
                                            color: indextab == 0 &&
                                                    selectedAll == 1
                                                ? Color(0xff1ba6d2)
                                                : Colors.black26,
                                          ),
                                          Text(
                                            "(" +
                                                USER_GENERAL
                                                    .where(
                                                        (u) => u.selected == 1)
                                                    .toList()
                                                    .length
                                                    .toString() +
                                                ")",
                                            style: TextStyle(
                                              color: indextab == 0 &&
                                                      selectedAll == 1
                                                  ? Color(0xff1ba6d2)
                                                  : Colors.black26,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(
                                                1.5,
                                              ),
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(
                                            LineIcons.userPlus,
                                            color: indextab == 1 &&
                                                    selectedindex1 == 1
                                                ? Color(0xff1ba6d2)
                                                : Colors.black26,
                                          ),
                                          Text(
                                            "(" +
                                                lReferidos.length.toString() +
                                                ")",
                                            style: TextStyle(
                                              color: indextab == 1 &&
                                                      selectedindex1 == 1
                                                  ? Color(0xff1ba6d2)
                                                  : Colors.black26,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(
                                                1.5,
                                              ),
                                            ),
                                          ),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                    Tab(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(
                                            LineIcons.users,
                                            color: indextab == 2 &&
                                                    selectedindex2 == 1
                                                ? Color(0xff1ba6d2)
                                                : Colors.black26,
                                          ),
                                          Text(
                                            "(" +
                                                lselected.length.toString() +
                                                ")",
                                            style: TextStyle(
                                              color: indextab == 2 &&
                                                      selectedindex2 == 1
                                                  ? Color(0xff1ba6d2)
                                                  : Colors.black26,
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(
                                                1.5,
                                              ),
                                            ),
                                          )
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: () {
                              if (_controllertab.index == 0) {
                                setState(() {
                                  valueAll = !valueAll;
                                  if (valueAll) {
                                    seleccionarAll();
                                  } else {
                                    deseleccionarAll();
                                  }
                                });
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (_controllertab.index == 0) {
                                      setState(() {
                                        valueAll = !valueAll;
                                        if (valueAll) {
                                          seleccionarAll();
                                        } else {
                                          deseleccionarAll();
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        border: valueAll
                                            ? Border()
                                            : Border.all(
                                                color: Colors.grey[400]),
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
                      )
                    ],
                  ),
                ),
                widget.editMode == 0
                    ? Expanded(
                        flex: 8,
                        child: Container(
                          padding: EdgeInsets.all(0),
                          color: Colors.grey[100],
                          child: TabBarView(
                            controller: _controllertab,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              Scaffold(
                                resizeToAvoidBottomInset: false,
                                backgroundColor: Colors.grey[100],
                                body: Column(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 8,
                                      child: cargado == 1
                                          ? ListView.builder(
                                              controller: scrollCtrl,
                                              itemCount: listShow.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    userTransactions us =
                                                        USER_GENERAL
                                                            .where((u) =>
                                                                u.codewoiner ==
                                                                listShow[index]
                                                                    .codewoiner)
                                                            .toList()
                                                            .first;

                                                    setState(() {
                                                      us.selected =
                                                          us.selected == 0
                                                              ? 1
                                                              : 0;
                                                      listShow[index].selected =
                                                          us.selected;
                                                      calcularMontoFinal();

                                                      List<userTransactions>
                                                          lst = lselected
                                                              .where((user) =>
                                                                  user.codewoiner ==
                                                                  listShow[
                                                                          index]
                                                                      .codewoiner)
                                                              .toList();

                                                      userTransactions uselect =
                                                          lst.length == 0
                                                              ? null
                                                              : lst.first;

                                                      if (uselect == null) {
                                                        lselected.add(
                                                            listShow[index]);
                                                        print(
                                                            "AGREGADO SELECT");
                                                      } else {
                                                        lselected.remove(
                                                            listShow[index]);
                                                        print(
                                                            "ELIMINADO SELECT");
                                                      }
                                                      if (selectedAll == 1) {
                                                        buscarSeleccionados(
                                                            opcionFilter);
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .verticalScale(90),
                                                    child: Card(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 6,
                                                            child: Padding(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      ResponsiveFlutter.of(
                                                                              context)
                                                                          .scale(
                                                                              7)),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: ResponsiveFlutter.of(
                                                                        context)
                                                                    .scale(
                                                                        29.0),
                                                                backgroundImage: listShow[index]
                                                                            .imagen !=
                                                                        ""
                                                                    ? NetworkImage(
                                                                        listShow[index]
                                                                            .imagen)
                                                                    : null,
                                                                backgroundColor:
                                                                    listShow[index].imagen ==
                                                                            ""
                                                                        ? Colors
                                                                            .transparent
                                                                        : Colors
                                                                            .transparent,
                                                                child: listShow[index]
                                                                            .imagen ==
                                                                        ""
                                                                    ? Center(
                                                                        child:
                                                                            Text(
                                                                          listShow[index]
                                                                              .fullname[0],
                                                                          style:
                                                                              TextStyle(color: Colors.grey[600]),
                                                                        ),
                                                                      )
                                                                    : SizedBox(),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 16,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  height: ResponsiveFlutter.of(
                                                                          context)
                                                                      .verticalScale(
                                                                          10),
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    listShow[index].fullname !=
                                                                            null
                                                                        ? listShow[index].fullname.length >
                                                                                25
                                                                            ? listShow[index].fullname.substring(0,
                                                                                25)
                                                                            : listShow[index].fullname
                                                                        : "sin nombre",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                    style: TextStyle(
                                                                        color: Colors.grey[
                                                                            800],
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              4),
                                                                  child: Text(
                                                                    listShow[
                                                                            index]
                                                                        .email,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .blue[400]),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              4,
                                                                          top:
                                                                              3),
                                                                  child: Text(
                                                                    listShow[index].telefono !=
                                                                            null
                                                                        ? "(+" + listShow[index].indicativo + ") " + listShow[index].telefono !=
                                                                                null
                                                                            ? listShow[index]
                                                                                .telefono
                                                                            : "SNT" + " " + listShow[index].pais != null
                                                                                ? listShow[index].pais.substring(0, 3)
                                                                                : "SNP" + " - " + listShow[index].ciudad
                                                                        : "" + "" + listShow[index].pais != null ? listShow[index].pais.substring(0, 3) : "SNP" + " - " + listShow[index].ciudad,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: ResponsiveFlutter.of(
                                                                          context)
                                                                      .verticalScale(
                                                                          10),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 4,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: listShow[index].selected ==
                                                                            0
                                                                        ? Border.all(
                                                                            color:
                                                                                Colors.grey[300])
                                                                        : Border(),
                                                                    color: listShow[index].selected ==
                                                                                1 &&
                                                                            listShow[index].type ==
                                                                                2
                                                                        ? Colors
                                                                            .blue
                                                                        : listShow[index].selected == 1 &&
                                                                                listShow[index].type == 3
                                                                            ? Colors.orange
                                                                            : Colors.white,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      listShow[index].type ==
                                                                              2
                                                                          ? "Cli"
                                                                          : "Em",
                                                                      style:
                                                                          TextStyle(
                                                                        color: listShow[index].selected ==
                                                                                1
                                                                            ? Colors.white
                                                                            : Colors.grey[400],
                                                                        fontSize:
                                                                            8,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .hp(.8),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              padding: EdgeInsets.only(
                                                  top: ResponsiveFlutter.of(
                                                          context)
                                                      .hp(1)),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                    ),
                                    isLoading == 1
                                        ? Expanded(
                                            flex: 2,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                              Scaffold(
                                resizeToAvoidBottomInset: false,
                                body: Column(children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      color: Colors.white,
                                      child: SizedBox(
                                        height: 20,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ResponsiveFlutter.of(context)
                                                      .wp(3.5),
                                              vertical:
                                                  ResponsiveFlutter.of(context)
                                                      .hp(1.2)),
                                          child: TextField(
                                            onSubmitted: (val) async {
                                              bool emailValid = RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(
                                                      emailaddController.text);
                                              if (emailValid) {
                                                print("VALID");
                                                print("EMAIL=>" +
                                                    emailaddController.text);

                                                int existeEmail = lReferidos
                                                    .where((u) =>
                                                        u.email ==
                                                        emailaddController.text)
                                                    .length;

                                                if (existeEmail == 0) {
                                                  userTransactions referido =
                                                      new userTransactions(
                                                          email:
                                                              emailaddController
                                                                  .text,
                                                          type: 0,
                                                          codewoiner: "0",
                                                          fullname:
                                                              "Usuario no registrado",
                                                          telefono:
                                                              "Sin teléfono",
                                                          compras: 0,
                                                          imagen: "",
                                                          puntos: 0,
                                                          selected: 0);

                                                  setState(() {
                                                    // USER_GENERAL.add(referido);
                                                    lReferidos.add(referido);
                                                    lselected.add(referido);
                                                  });

                                                  emailaddController.text = "";
                                                } else {
                                                  closeModal() {
                                                    Navigator.of(context).pop();
                                                  }

                                                  showAlerts(
                                                      context,
                                                      "Usuario referido ya agregado...",
                                                      false,
                                                      closeModal,
                                                      null,
                                                      "Aceptar",
                                                      "",
                                                      null);
                                                }
                                              } else {
                                                closeModal() {
                                                  Navigator.of(context).pop();
                                                }

                                                showAlerts(
                                                    context,
                                                    "Escribir email válido para agregar referido...",
                                                    false,
                                                    closeModal,
                                                    null,
                                                    "Aceptar",
                                                    "",
                                                    null);
                                              }
                                            },
                                            controller: emailaddController,
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .018),
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autocorrect: true,
                                            autofocus: false,
                                            decoration: InputDecoration(
                                              hintText: "Ingrese un email*",
                                              contentPadding: EdgeInsets.all(0),

                                              prefixIcon: Icon(
                                                  Icons.person_outline,
                                                  color: Colors.grey[500]),

                                              // fillColor: Colors.white,
                                              labelStyle: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .018),
                                              enabledBorder: new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              50.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[300])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                  ),
                                              focusedBorder: new OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              50.0)),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[500])
                                                  // borderSide: new BorderSide(color: Colors.teal)
                                                  ),

                                              // labelText: 'Correo'
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 14,
                                    child: Container(
                                      color: Colors.grey[100],
                                      child: ListView.builder(
                                        itemCount: lReferidos.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Dismissible(
                                            key: Key(lReferidos[index]
                                                .codewoiner
                                                .toString()),
                                            onDismissed: (direction) {
                                              removerReferido(
                                                  lReferidos[index]);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height:
                                                  ResponsiveFlutter.of(context)
                                                      .verticalScale(90),
                                              child: Card(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 6,
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                ResponsiveFlutter.of(
                                                                        context)
                                                                    .scale(7)),
                                                        child: CircleAvatar(
                                                            radius: ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(29.0),
                                                            backgroundColor:
                                                                Colors
                                                                    .grey[200],
                                                            child: Center(
                                                              child: Text(
                                                                lReferidos[
                                                                        index]
                                                                    .fullname[0],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 16,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: ResponsiveFlutter
                                                                    .of(context)
                                                                .verticalScale(
                                                                    10),
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              lReferidos[index]
                                                                  .fullname,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 4),
                                                            child: Text(
                                                              lReferidos[index]
                                                                  .email,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                          .blue[
                                                                      400]),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: ResponsiveFlutter
                                                                    .of(context)
                                                                .verticalScale(
                                                                    10),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 20,
                                                            height: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: lReferidos[
                                                                              index]
                                                                          .type ==
                                                                      0
                                                                  ? Border.all(
                                                                      color: Colors
                                                                              .grey[
                                                                          300])
                                                                  : Border(),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "Ref",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
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
                                                  vertical:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .hp(.8),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.only(
                                            top: ResponsiveFlutter.of(context)
                                                .hp(1)),
                                      ),
                                    ),
                                  ),
                                ]),
                                backgroundColor: Colors.grey[100],
                                floatingActionButton: FloatingActionButton(
                                  onPressed: () async {
                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(emailaddController.text);
                                    if (emailValid) {
                                      print("VALID");
                                      print(
                                          "EMAIL=>" + emailaddController.text);

                                      int existeEmail = lReferidos
                                          .where((u) =>
                                              u.email ==
                                              emailaddController.text)
                                          .length;

                                      if (existeEmail == 0) {
                                        userTransactions referido =
                                            new userTransactions(
                                                email: emailaddController.text,
                                                type: 0,
                                                codewoiner: "0",
                                                fullname:
                                                    "Usuario no registrado",
                                                telefono: "Sin teléfono",
                                                compras: 0,
                                                imagen: "",
                                                puntos: 10,
                                                selected: 0);
                                        lReferidos.add(referido);
                                        emailaddController.text = "";
                                      } else {
                                        closeModal() {
                                          Navigator.of(context).pop();
                                        }

                                        showAlerts(
                                            context,
                                            "Usuario referido ya agregado...",
                                            false,
                                            closeModal,
                                            null,
                                            "Aceptar",
                                            "",
                                            null);
                                      }
                                    } else {
                                      closeModal() {
                                        Navigator.of(context).pop();
                                      }

                                      showAlerts(
                                          context,
                                          "Escribir email válido para agregar referido...",
                                          false,
                                          closeModal,
                                          null,
                                          "Aceptar",
                                          "",
                                          null);
                                    }
                                  },
                                  child: Icon(LineIcons.userPlus),
                                ),
                              ),
                              Scaffold(
                                backgroundColor: Colors.grey[100],
                                body: ListView.builder(
                                  padding: EdgeInsets.only(top: 6),
                                  itemCount: lselected.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 8),
                                      child: SlidableV2(
                                        closeOnScroll: false,
                                        key: Key(lselected[index]
                                            .codewoiner
                                            .toString()),
                                        secondaryActions: <Widget>[
                                          SlideAction(
                                            onTap: () {
                                              removerSeleccionadoOne(
                                                  lselected[index]);
                                            },
                                            color: Colors.grey[100],
                                            child: Text(
                                              "Eliminar",
                                              style: TextStyle(
                                                  color: Colors.red[600]),
                                            ),
                                            closeOnTap: false,
                                          ),
                                        ],
                                        user: lselected[index],
                                        child: Container(
                                          height: ResponsiveFlutter.of(context)
                                              .verticalScale(90),
                                          child: Card(
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 6,
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .scale(7)),
                                                    child: CircleAvatar(
                                                      radius:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .scale(29.0),
                                                      backgroundImage:
                                                          lselected[index]
                                                                      .imagen !=
                                                                  ""
                                                              ? NetworkImage(
                                                                  lselected[
                                                                          index]
                                                                      .imagen)
                                                              : null,
                                                      backgroundColor:
                                                          lselected[index]
                                                                      .imagen ==
                                                                  ""
                                                              ? Colors.grey[200]
                                                              : Colors
                                                                  .transparent,
                                                      child: lselected[index]
                                                                  .imagen ==
                                                              ""
                                                          ? Center(
                                                              child: Text(
                                                                lselected[index]
                                                                    .fullname[0],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600]),
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 16,
                                                  child: Container(
                                                    // color: Colors.amber,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          lselected[index]
                                                                      .type !=
                                                                  0
                                                              ? MainAxisAlignment
                                                                  .spaceEvenly
                                                              : MainAxisAlignment
                                                                  .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: ResponsiveFlutter
                                                                  .of(context)
                                                              .verticalScale(
                                                                  10),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                left: lselected[index]
                                                                            .type !=
                                                                        0
                                                                    ? 0
                                                                    : 4),
                                                            child: Text(
                                                              lselected[index]
                                                                  .fullname
                                                                  .substring(
                                                                      0, 20),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        lselected[index].type ==
                                                                0
                                                            ? SizedBox(
                                                                height: ResponsiveFlutter.of(
                                                                        context)
                                                                    .hp(1),
                                                              )
                                                            : SizedBox(),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Text(
                                                            lselected[index]
                                                                .email,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .blue[400]),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                        lselected[index].type !=
                                                                0
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 4,
                                                                        top: 3),
                                                                child: Text(
                                                                  lselected[index].telefono !=
                                                                          null
                                                                      ? "(+" + lselected[index].indicativo + ") " + lselected[index].telefono !=
                                                                              null
                                                                          ? lselected[index]
                                                                              .telefono
                                                                          : "SNT" + "  " + lselected[index].pais != null
                                                                              ? lselected[index].pais.substring(0,
                                                                                  3)
                                                                              : "SNP" +
                                                                                  " - " +
                                                                                  lselected[index]
                                                                                      .ciudad
                                                                      : "" +
                                                                          "" +
                                                                          lselected[index].pais.substring(
                                                                              0,
                                                                              3) +
                                                                          " - " +
                                                                          lselected[index]
                                                                              .ciudad,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            : SizedBox(),
                                                        SizedBox(
                                                          height: ResponsiveFlutter
                                                                  .of(context)
                                                              .verticalScale(
                                                                  10),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border(),
                                                          color: lselected[index]
                                                                          .selected ==
                                                                      1 &&
                                                                  lselected[index]
                                                                          .type ==
                                                                      2
                                                              ? Colors.blue
                                                              : lselected[index]
                                                                              .selected ==
                                                                          1 &&
                                                                      lselected[index]
                                                                              .type ==
                                                                          3
                                                                  ? Colors
                                                                      .orange
                                                                  : Colors.grey[
                                                                      400],
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            lselected[index]
                                                                        .type ==
                                                                    2
                                                                ? "Cli"
                                                                : lselected[index]
                                                                            .type ==
                                                                        3
                                                                    ? "Em"
                                                                    : "Ref",
                                                            style: TextStyle(
                                                              color: lselected[
                                                                              index]
                                                                          .selected ==
                                                                      1
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .white,
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
                                          ),
                                        ),
                                        actionPane: SlidableDrawerActionPane(),
                                      ),
                                    );
                                  },
                                ),
                                floatingActionButton: StreamBuilder<int>(
                                  stream: usersTransactionBloc.isActiveDelete,
                                  builder: (context, snapshot) {
                                    return snapshot.hasData &&
                                            snapshot.data == 1
                                        ? FloatingActionButton(
                                            onPressed: () {
                                              eliminarSelected() {
                                                eliminarSeleccionados();
                                                usersTransactionBloc.activarSink
                                                    .add(0);

                                                Navigator.of(context).pop();
                                              }

                                              eliminarTodos() {
                                                lselected.clear();
                                                usersTransactionBloc.ldelete
                                                    .clear();
                                                removerReferidos();
                                                deselecionarAllNew();
                                                Navigator.of(context).pop();
                                              }

                                              showAlerts(
                                                  context,
                                                  "¿Que desea eliminar?",
                                                  null,
                                                  eliminarSelected,
                                                  eliminarTodos,
                                                  "Eliminar seleccionados",
                                                  "Eliminar todos",
                                                  Colors.red[600]);

                                              //print("BORRADOS");
                                            },
                                            backgroundColor: Colors.red[800],
                                            child: Icon(Icons.delete_forever),
                                            tooltip: "Borrar Seleccionados",
                                            heroTag: null,
                                          )
                                        : SizedBox();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        flex: 8,
                        child: ListView.builder(
                          itemCount: listShow.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  listShow[index].selected =
                                      listShow[index].selected == 0 ? 1 : 0;
                                });
                              },
                              child: Container(
                                height: ResponsiveFlutter.of(context)
                                    .verticalScale(90),
                                child: Card(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 6,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  ResponsiveFlutter.of(context)
                                                      .scale(7)),
                                          child: CircleAvatar(
                                            radius:
                                                ResponsiveFlutter.of(context)
                                                    .scale(29.0),
                                            backgroundImage:
                                                listShow[index].imagen != ""
                                                    ? NetworkImage(
                                                        listShow[index].imagen)
                                                    : null,
                                            backgroundColor:
                                                listShow[index].imagen == ""
                                                    ? Colors.transparent
                                                    : Colors.transparent,
                                            child: listShow[index].imagen == ""
                                                ? Center(
                                                    child: Text(
                                                      listShow[index]
                                                          .fullname[0],
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 16,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  ResponsiveFlutter.of(context)
                                                      .verticalScale(10),
                                            ),
                                            Flexible(
                                              child: Text(
                                                listShow[index]
                                                    .fullname
                                                    .substring(0, 25),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 4),
                                              child: Text(
                                                listShow[index]
                                                    .puntos
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue[400]),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 4, top: 3),
                                              child: Text(
                                                "\$ " +
                                                    listShow[index]
                                                        .compras
                                                        .toString(),
                                                style: TextStyle(fontSize: 11),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  ResponsiveFlutter.of(context)
                                                      .verticalScale(10),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: listShow[index]
                                                            .selected ==
                                                        0
                                                    ? Border.all(
                                                        color: Colors.grey[300])
                                                    : Border(),
                                                color: listShow[index]
                                                                .selected ==
                                                            1 &&
                                                        listShow[index].type ==
                                                            2
                                                    ? Colors.blue
                                                    : listShow[index]
                                                                    .selected ==
                                                                1 &&
                                                            listShow[index]
                                                                    .type ==
                                                                3
                                                        ? Colors.orange
                                                        : Colors.white,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  listShow[index].type == 2
                                                      ? "Cli"
                                                      : "Em",
                                                  style: TextStyle(
                                                    color: listShow[index]
                                                                .selected ==
                                                            1
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
                                    vertical:
                                        ResponsiveFlutter.of(context).hp(.8),
                                  ),
                                ),
                              ),
                            );
                          },
                          padding: EdgeInsets.only(
                              top: ResponsiveFlutter.of(context).hp(1)),
                        ),
                      ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.grey[300], width: 1))),
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Login(),
                          ));

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
                          if (widget.editMode == 0) {
                            if (lselected.length > 0) {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => ValorTransactionView(
                                        userSelected: lselected,
                                        monto: null,
                                        editMode: 0,
                                        opcion: this.widget.opcion,
                                        userall: lselected,
                                      )));
                            } else {
                              closeModal() {
                                Navigator.of(context).pop();
                              }

                              showAlerts(
                                  context,
                                  "Seleccione por lo menos un usuario para realizar la transacción",
                                  false,
                                  closeModal,
                                  null,
                                  "Aceptar",
                                  "",
                                  null);
                            }
                          } else {
                            bool isvalidUsers = false;

                            for (userTransactions u in listShow) {
                              if (u.selected == 0) {
                                isvalidUsers = true;
                                break;
                              }
                            }

                            if (isvalidUsers) {
                              Navigator.of(context).pop(listShow);
                            } else {
                              closeModal() {
                                Navigator.of(context).pop();
                              }

                              showAlerts(
                                  context,
                                  "Seleccione por lo menos un usuario para asignar un valor",
                                  false,
                                  closeModal,
                                  null,
                                  "Aceptar",
                                  "",
                                  null);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ValorTransactionView extends StatefulWidget {
  int opcion;
  List<userTransactions> userall;
  List<userTransactions> userSelected;
  MontoTransactions monto;
  int editMode;

  ValorTransactionView(
      {this.opcion,
      this.userSelected,
      this.monto,
      this.editMode,
      this.userall});

  @override
  _ValorTransactionViewState createState() => _ValorTransactionViewState();
}

class _ValorTransactionViewState extends State<ValorTransactionView> {
  int opcionCalculate = 1;
  int valoroption = -1;
  List<String> valores;
  FocusNode myFocusNode;
  TextEditingController mycontroller;
  List<userTransactions> userSelectedT;
  List<userTransactions> userAsingSel;
  int asignMonto = 0;
  int redibujarfoco = 0;
  int cambioOpcion = 0;
  Widget muestra;
  int valorInicial = 10000;

  double porci = 10;
  ScrollController _controllerLV;
  double anchoCard = 90;
  MontoTransactions montoNew;
  MontoTransactions montoEdit;
  double porcvalid = 90;
  int puntosValid = 9999999;
  double comprasValid = 999999999;
  int valorFijo = 0;
  int valorFijoC = 0;
  bool prptfijo = false;
  bool prcfijo = false;

  //PORCENTAJES DE LIMITES PARA REPARTIR SALDO
  double porcedit = 75 / 100;
  double porceditmin = 5 / 100;
  String text = "";
  int sumarestEdit = 0;
  double valrest = 0;
  double valsum = 0;
  double valrestdec = 0;
  double valsumdec = 0;
  bool isUltimo = false;
  bool isUltimoC = false;
  bool isUltimoopt2 = false;
  bool isUltimoopt2C = false;
  double montoActual = 0;

  //CALCULADORA
  double porcentaje = 10;
  double venta = 0;
  double totalRegalar = 0;
  int firstAsigP = 0;
  int firstAsingV = 0;
  int firstAsignVal = 0;

  @override
  void initState() {
    super.initState();
    mycontroller = TextEditingController();
    userAsingSel = List();
    if (widget.editMode == 0) {
      widget.opcion = widget.opcion + 1;
    }
    valoroption = widget.opcion != 2 ? 0 : 1;
    if (valoroption == 0) {
      text = "0";
      mycontroller.value = new TextEditingValue(
          text: text,
          selection: new TextSelection(
              baseOffset: text.length,
              extentOffset: text.length,
              affinity: TextAffinity.downstream,
              isDirectional: false),
          composing: new TextRange(start: 0, end: 0));
      muestra = cajadeTexto(mycontroller.text);
    } else if (widget.opcion == 2) {
      valoroption = 1;
      text = "0";
      mycontroller.value = new TextEditingValue(
          text: text,
          selection: new TextSelection(
              baseOffset: text.length,
              extentOffset: text.length,
              affinity: TextAffinity.downstream,
              isDirectional: false),
          composing: new TextRange(start: 0, end: 0));
      muestra = cajadeTexto(mycontroller.text);
    }

    //print("PUNTOS TOT=>" + widget.monto.puntos.toString());
    //print("EFECTIVO TOT=>" + widget.monto.efectivo.toString());
    userSelectedT = List();
    for (userTransactions u in widget.userSelected) {
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
          woinerId: u.woinerId,
          efecfijo: u.efecfijo,
          valorFijo: u.valorFijo,
          calificacion: u.calificacion,
          montocompraOld: u.montocompraOld,
          montopuntoOld: u.montopuntoOld,
          nota: u.nota);
      userSelectedT.add(us);
    }

    valores = List();
    String mp = "0.5";
    String m1 = "10";
    String m1_1 = "50";
    String m2 = "100";
    String m3 = "1000";
    String m4 = "2000";
    String m5 = "5000";
    String m6 = "7000";
    String m7 = "10000";
    String m8 = "20000";
    String m9 = "50000";
    String m10 = "100000";
    String m11 = "200000";
    String m12 = "500000";
    String m13 = "700000";
    String m14 = "1000000";
    String m15 = "2000000";
    String m16 = "5000000";
    String m17 = "10000000";
    //print("MODO=>" + widget.editMode.toString());

    valores.add(mp);
    valores.add(m1);
    valores.add(m1_1);
    valores.add(m2);
    valores.add(m3);
    valores.add(m4);
    valores.add(m5);
    valores.add(m6);
    valores.add(m7);
    valores.add(m8);
    valores.add(m9);
    valores.add(m10);
    valores.add(m11);
    valores.add(m12);
    valores.add(m13);
    valores.add(m14);
    valores.add(m15);
    valores.add(m16);
    valores.add(m17);
    /*porcentaje = widget.monto!=null? widget.monto.porcentaje == 0 ? 10 : widget.monto.porcentaje:10;
  if(widget.monto!=null) {
    montoNew = MontoTransactions(
        efbase: widget.monto.efbase,
        efectivo: widget.monto.efectivo,
        opcion: widget.monto.opcion,
        porcentaje: widget.monto.porcentaje == 0 ? 10 : widget.monto.porcentaje,
        puntobase: widget.monto.puntobase,
        puntos: widget.monto.puntos,
        saldoDisponible: widget.monto.saldoDisponible,
        venta: widget.monto.venta);
  }
    if (widget.editMode == 1) {
      montoEdit = MontoTransactions(
          efbase: 0,
          efectivo: widget.monto.efectivo,
          opcion: 3,
          porcentaje: 10,
          puntobase: 0,
          puntos: widget.monto.puntos,
          saldoDisponible: 0,
          venta: 0);
    }*/

    myFocusNode = FocusNode();

    double v = anchoCard * indiceValor(valorInicial.toDouble());
    _controllerLV = ScrollController(initialScrollOffset: v);

    if (widget.monto != null) {
      opcionCalculate = widget.editMode == 1 ? 3 : widget.monto.opcion;
    }
  }

  Widget cajadeTexto(String texto) {
    print("ENTRO");
    double val = double.parse(texto.split(",")[0]);
    print(val);
    mycontroller = TextEditingController(text: texto);
    myFocusNode = FocusNode();
    //print("ACA" + texto.length.toString());
    mycontroller.value = new TextEditingValue(
      text: texto,
      selection: new TextSelection(
          baseOffset: texto.length,
          extentOffset: texto.length,
          affinity: TextAffinity.downstream,
          isDirectional: false),
      //composing: new TextRange(start: 0, end: texto.length)
    );

    return TextFormField(
      controller: mycontroller,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        CurrencyPtBrInputFormatter(maxDigits: 8)
      ],
      autofocus: false,
      onSaved: (value) {
        String _onlyDigits = value.replaceAll(RegExp('[^0-9]'), "");
        double _doubleValue = double.parse(_onlyDigits) / 100;
        return _doubleValue;
      },
      onChanged: (value) {
        if (widget.editMode == 0 || widget.editMode == 1) {
          if (valoroption == 0 ||
              valoroption == 1 ||
              valoroption == 5 ||
              valoroption == 6) {
            value = value.replaceAll('.', '');

            if (value == "") {
              if (asignMonto == 0) {
                asignarValor(0);
              } else {
                asignarValorE(0);
              }
            } else if (double.parse(value) <= puntosValid) {
              //print("ENTRA ACA=>");
              text = value;
              totalRegalar = double.parse(value);
              //print("TOT REGALAR"+totalRegalar.toString());

              if (asignMonto == 0) {
                asignarValor(double.parse(text));
                print("ASIGNADO 1");
              } else {
                asignarValorE(double.parse(text));
                print("ASIGNADO 2");
              }
            } else {
              //print("SE MODIFICA");
              mycontroller.value = new TextEditingValue(
                  text: text,
                  selection: new TextSelection(
                      baseOffset: text.length,
                      extentOffset: text.length,
                      affinity: TextAffinity.downstream,
                      isDirectional: false),
                  composing: new TextRange(start: 0, end: 0));
            }
          } else if (valoroption == 4) {
            value = value.replaceAll('.', '');
            var regExp = RegExp('\d+(\.\d{1,2})?');
            bool valorvalid = true;
            if (value == "") {
              porcentaje = 10;

              totalRegalar = venta * porcentaje / 100;
              if (asignMonto == 0) {
                asignarValor(totalRegalar);
              } else {
                asignarValorE(totalRegalar);
              }
            }
            if (value.length >= 5) {
              valorvalid = regExp.hasMatch(value);
            }

            if (double.parse(value) <= porcvalid &&
                valorvalid &&
                double.parse(value) > 0) {
              text = value;
              porcentaje = double.parse(value);
              if (venta > 0 && porcentaje > 0) {
                totalRegalar = venta * porcentaje / 100;
                if (asignMonto == 0) {
                  asignarValor(totalRegalar);
                } else {
                  asignarValorE(totalRegalar);
                }
              } else {
                if (asignMonto == 0) {
                  asignarValor(0);
                } else {
                  asignarValorE(0);
                }
              }
            } else {
              //print("SE MODIFICA");
              mycontroller.value = new TextEditingValue(
                  text: text,
                  selection: new TextSelection(
                      baseOffset: text.length,
                      extentOffset: text.length,
                      affinity: TextAffinity.downstream,
                      isDirectional: false),
                  composing: new TextRange(start: 0, end: 0));
            }
          } else if (valoroption == 3) {
            value = value.replaceAll('.', '');
            if (value == "") {
              venta = 0;
              totalRegalar = venta * porcentaje / 100;
              if (asignMonto == 0) {
                asignarValor(totalRegalar);
              } else {
                asignarValorE(totalRegalar);
              }
            }

            if (double.parse(value) <= comprasValid &&
                double.parse(value) > 0) {
              text = value;

              venta = double.parse(value);
              if (porcentaje > 0 && venta > 0) {
                totalRegalar = venta * porcentaje / 100;
                if (asignMonto == 0) {
                  asignarValor(totalRegalar);
                } else {
                  asignarValorE(totalRegalar);
                }
              } else {
                if (asignMonto == 0) {
                  asignarValor(0);
                } else {
                  asignarValorE(0);
                }
              }
            } else {
              //print("SE MODIFICA");
              mycontroller.value = new TextEditingValue(
                  text: text,
                  selection: new TextSelection(
                      baseOffset: text.length,
                      extentOffset: text.length,
                      affinity: TextAffinity.downstream,
                      isDirectional: false),
                  composing: new TextRange(start: 0, end: 0));
            }
          } else {
            //print("SE MODIFICA");
            mycontroller.value = new TextEditingValue(
                text: text,
                selection: new TextSelection(
                    baseOffset: text.length,
                    extentOffset: text.length,
                    affinity: TextAffinity.downstream,
                    isDirectional: false),
                composing: new TextRange(start: 0, end: 0));
          }
        }

        setState(() {});
      },
      onFieldSubmitted: (val) {
        myFocusNode.consumeKeyboardToken();
        /* if (widget.editMode == 0) {
          if (valoroption == 3 && val != "") {
            montoNew.venta = double.parse(val);
            montoNew.puntobase = (montoNew.venta * porcentaje);
          }
          if (valoroption == 4 && val == "") {
            porcentaje = 0;

            valoroption = -1;
          }

          muestra = SizedBox();
          valoroption = -1;
        } else {
          double valornuevo = val == "" ? 0 : double.parse(val);
          _modificarValor(valornuevo);
        }
        text = "";
        setState(() {});*/

        //  myFocusNode.requestFocus();
      },
      focusNode: myFocusNode,
      maxLength: valoroption == 4 ? 4 : 12,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: (valsum >= valrest &&
                  (valoroption == 1 || valoroption == 5 || valoroption == 6) &&
                  widget.editMode == 1)
              ? Color.fromARGB(255, 1, 90, 136)
              : (valsum < valrest &&
                      (valoroption == 1 ||
                          valoroption == 5 ||
                          valoroption == 6) &&
                      widget.editMode == 1)
                  ? Colors.red[300]
                  : Color.fromARGB(255, 1, 90, 136),
          fontWeight: FontWeight.w700,
          fontSize: 30),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        counterText: "",
        counterStyle: TextStyle(fontSize: 0),
        hintText: '',
        contentPadding:
            new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        border: InputBorder.none,
      ),
    );
  }

  double puntosTotalUserSelected() {
    double puntos = 0;
    for (userTransactions u in userSelectedT) {
      puntos += u.puntos;
    }
    return puntos;
  }

  int puntosTotalUserSelectedOld() {
    int puntos = 0;
    for (userTransactions u in userSelectedT) {
      puntos += u.montopuntoOld.floor();
    }
    return puntos;
  }

  double comprasTotalUserSelected() {
    double compra = 0;
    for (userTransactions u in userSelectedT) {
      compra += u.compras;
    }
    return compra;
  }

  double comprasTotalUserSelectedOld() {
    double compra = 0;
    for (userTransactions u in userSelectedT) {
      compra += u.montocompraOld;
    }
    return compra;
  }

  _modificarValor(double valornuevo) {
    bool isvalid = false;

    if (valoroption == 3 && mycontroller.text != "") {
      montoEdit.venta = double.parse(mycontroller.text);
      //MONTO EDIT
      montoEdit.puntobase = (porcentaje * montoEdit.venta / 100);
      // print("NEW PUNTOS=>" + montoEdit.puntobase.toString());
    }
    if (valoroption == 4 && mycontroller.text != "") {
      montoEdit.porcentaje = double.parse(mycontroller.text);
      //MONTO EDIT
      montoEdit.puntobase = (porcentaje * montoEdit.venta / 100);
      // print("NEW PUNTOS=>" + montoEdit.puntobase.toString());
    }

    //print(opcionCalculate );
    //print(puntosTotalUserSelected());
    //print(puntosTotalUserSelected()+valornuevo);
    //print(montoEdit.puntos * porcedit);
    //print(montoEdit.puntos);
    //print(porcedit);

    if ((valoroption == 0 ||
            valoroption == 1 ||
            valoroption == 5 ||
            valoroption == 6) &&
        valornuevo >= 0 &&
        opcionCalculate == 3 &&
        (puntosTotalUserSelected() + valornuevo * userSelectedT.length <=
            (montoEdit.puntos * porcedit))) {
      // print("SUMA O RESTA?=>" + sumarestEdit.toString())
      isvalid = true;

      for (userTransactions u in userSelectedT) {
        // print("SUMO PUNTOS");
        u.puntos += valornuevo.toInt();
      }
      mycontroller.text = "";
    }
    //COMPRAS Y VENTAS  CALCULATE 3
    //MAXIMO MONTO
    if (((valoroption == 2) &&
        valornuevo >= 0 &&
        opcionCalculate == 3 &&
        (comprasTotalUserSelected() + valornuevo * userSelectedT.length <=
            (montoEdit.efectivo * porcedit)))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        u.compras += valornuevo;
      }
      mycontroller.text = "";
    }
    // OPCION CALCULATE 4***************************************************

    if ((valoroption == 0 ||
            valoroption == 1 ||
            valoroption == 5 ||
            valoroption == 6) &&
        valornuevo >= 0 &&
        opcionCalculate == 4 &&
        (puntosTotalUserSelected() -
                valornuevo.floor() * userSelectedT.length >=
            (montoEdit.puntos * porceditmin))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        //print("RESTO A MINIMO DE PUNTOS");
        u.puntos -= valornuevo;
      }
      mycontroller.text = "";
    }

    //COMPRAS Y VENTAS  CALCULATE 4
    if ((valoroption == 2) &&
        valornuevo >= 0 &&
        opcionCalculate == 4 &&
        (comprasTotalUserSelected() - valornuevo * userSelectedT.length >=
            (montoEdit.efectivo * porceditmin))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        // print("RESTO A MINIMO DE PUNTOS");
        u.compras -= valornuevo;
      }
      mycontroller.text = "";
    }

    //CALCULATE OPCION 2*************************************************************************************************
    if ((valoroption == 0 ||
            valoroption == 1 ||
            valoroption == 5 ||
            valoroption == 6) &&
        valornuevo >= 0 &&
        opcionCalculate == 2 &&
        (puntosTotalUserSelected() + (valornuevo.toInt()) <=
            (montoEdit.puntos * porcedit))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        // print("SUMO PUNTOS");
        u.puntos += (valornuevo.toInt() / userSelectedT.length).floor().toInt();
      }
      mycontroller.text = "";
    }

    //COMPRAS Y VENTAS  CALCULATE 2
    //MAXIMO MONTO
    if (((valoroption == 2) &&
        valornuevo >= 0 &&
        opcionCalculate == 2 &&
        (comprasTotalUserSelected() + (valornuevo) <=
            (montoEdit.efectivo * porcedit)))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        u.compras += (valornuevo / userSelectedT.length);
      }
      mycontroller.text = "";
    }

    //OPCION CALCULATE 1
    if ((valoroption == 0 ||
            valoroption == 1 ||
            valoroption == 5 ||
            valoroption == 6) &&
        valornuevo >= 0 &&
        opcionCalculate == 1 &&
        ((valornuevo * userSelectedT.length) <=
            (montoEdit.puntos * porcedit))) {
      print("ENTRA A DIVIDIR");
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        // print("SUMO PUNTOS");
        u.puntos = (valornuevo);
      }
      mycontroller.text = "";
    }

    //COMPRAS Y VENTAS  CALCULATE 2
    //MAXIMO MONTO
    if (((valoroption == 2) &&
        valornuevo >= 0 &&
        opcionCalculate == 1 &&
        ((valornuevo * userSelectedT.length) <=
            (montoEdit.efectivo * porcedit)))) {
      isvalid = true;
      for (userTransactions u in userSelectedT) {
        u.compras = valornuevo.roundToDouble();
      }
      mycontroller.text = "";
    }

    String msj = "";
    if (!isvalid) {
      if (opcionCalculate == 2) {
        msj = "No se puede dividir el monto ingresado";
      }
      if (opcionCalculate == 3) {
        msj = "No se puede sumar el monto ingresado";
      }
      if (opcionCalculate == 4) {
        msj = "No se puede restar el monto ingresado";
      }
      closeModal() {
        Navigator.of(context).pop();
      }

      showAlerts(context, msj, isvalid, closeModal, null, "Aceptar", "", null);
    }
    //CALCULAR TOTALES
    montoNew.efectivo = 0;
    montoNew.puntos = 0;

    for (userTransactions u in userSelectedT) {
      montoNew.efectivo += u.compras;
      montoNew.puntos += u.puntos;
    }
    setState(() {});

    //MONTO FINAL
  }

  int indiceValor(double valor) {
    for (int i = 0; i < valores.length; i++) {
      if (valor == double.parse(valores[i])) {
        return i - 1;
      }
    }
  }

  int saldoUsersValid() {
    int r = 1;
    for (userTransactions us in userSelectedT) {
      if (us.puntos == 0) {
        r = 0;
        break;
      }
    }
    return r;
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    super.dispose();
  }

  asignarValor(double valor) {
    if (opcionCalculate == 1) {
      if (valoroption == 1 ||
          valoroption == 0 ||
          valoroption == 5 ||
          valoroption == 6) {
        for (userTransactions u in userSelectedT) {
          u.puntos = valor;
        }
        //montoNew.puntobase = valor;

      } else if (valoroption == 2 || valoroption == 3 || valoroption == 4) {
        for (userTransactions u in userSelectedT) {
          u.puntos = valor;
        }
        for (userTransactions u in userSelectedT) {
          u.compras = valor;
        }
        // montoNew.efbase = valor;
      }
    }

    if (opcionCalculate == 2) {
      if (valoroption == 1 ||
          valoroption == 0 ||
          valoroption == 5 ||
          valoroption == 6) {
        for (userTransactions u in userSelectedT) {
          u.puntos = (valor / userSelectedT.length);
        }
        montoNew.puntobase = valor;
      } else if (valoroption == 2 || valoroption == 3) {
        for (userTransactions u in userSelectedT) {
          u.compras = (valor / userSelectedT.length).floor().toDouble();
        }
        montoNew.efbase = valor;
      }
    }

    setState(() {});
    //print("ASIGNADO");
  }

  asignarValorE(double valor) {
    if (opcionCalculate == 1) {
      if (valoroption == 1 ||
          valoroption == 0 ||
          valoroption == 5 ||
          valoroption == 6) {
        if (userAsingSel.length > 0) {
          for (userTransactions u in userAsingSel) {
            u.puntos = valor;
          }
        } else {
          for (userTransactions u in userSelectedT) {
            u.puntos = valor;
          }
        }

        // montoNew.puntobase=valor.floor();
      } else if (valoroption == 2 || valoroption == 3 || valoroption == 4) {
        print("entra aqui");

        for (userTransactions u in userAsingSel) {
          u.compras = valor;
          u.puntos = valor;
        }
        //montoNew.efbase=valor;
      }
    }

    if (opcionCalculate == 2) {
      if (valoroption == 1 ||
          valoroption == 0 ||
          valoroption == 5 ||
          valoroption == 6) {
        for (userTransactions u in userAsingSel) {
          u.puntos = (valor / userAsingSel.length);
        }
        // montoNew.puntobase=valor.floor();
      } else if (valoroption == 2 || valoroption == 3) {
        for (userTransactions u in userAsingSel) {
          u.compras = (valor / userAsingSel.length).toDouble();
        }
        //montoNew.efbase=valor;
      }
    }

    setState(() {});
  }

  removerAsigEdit(userTransactions u) {
    userTransactions userRemove = null;
    for (userTransactions u in userAsingSel) {
      if (u.codewoiner == u.codewoiner) {
        userRemove = u;
      }
    }
    if (userRemove != null) {
      userAsingSel.remove(u);
    }
  }

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

  void deleteUserList(userTransactions user) {
    if (userSelectedT.length > 0) {
      for (int i = 0; i < userSelectedT.length; i++) {
        if (userSelectedT[i].codewoiner == user.codewoiner) {
          userSelectedT.removeAt(i);
          break;
        }
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _wlist(userTransactions user) {
      // print("ENTRA WLIST");
      return GestureDetector(
        onTap: userSelectedT.length > 1 && (widget.editMode == 0)
            ? () {
                venta = 0;
                totalRegalar = 0;
                porcentaje = 10;
                firstAsingV = 0;
                firstAsigP = 0;
                firstAsignVal = 0;
                String value = "0";

                if (valoroption == 4) {
                  value = porcentaje.toString();
                }
                mycontroller.value = new TextEditingValue(
                    text: value.toString(),
                    selection: new TextSelection(
                        baseOffset: value.toString().length,
                        extentOffset: value.toString().length,
                        affinity: TextAffinity.downstream,
                        isDirectional: false),
                    composing: new TextRange(start: 0, end: 0));

                userAsingSel.clear();
                userTransactions us = userTransactions(
                    cedula: user.cedula,
                    ciudad: user.ciudad,
                    codciudad: user.codciudad,
                    codewoiner: user.codewoiner,
                    codpais: user.codpais,
                    compras: user.compras,
                    email: user.email,
                    fullname: user.fullname,
                    imagen: user.imagen,
                    indicativo: user.indicativo,
                    ncuenta: user.ncuenta,
                    pais: user.pais,
                    puntos: user.puntos,
                    red: user.red,
                    selected: user.selected,
                    telefono: user.telefono,
                    tipoStr: user.tipoStr,
                    type: user.type,
                    ventas: user.ventas,
                    woinerId: user.woinerId);
                userAsingSel.add(us);
                asignMonto = 1;
                setState(() {});
              }
            : null,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: ResponsiveFlutter.of(context).verticalScale(1),
              horizontal: 0),
          width: userSelectedT.length == 2 || userAsingSel.length == 2
              ? ResponsiveFlutter.of(context).wp(45.5)
              : ResponsiveFlutter.of(context).wp(46),
          // height: ResponsiveFlutter.of(context).hp(18),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[300], width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.only(
              top: ResponsiveFlutter.of(context).verticalScale(2),
              bottom: ResponsiveFlutter.of(context).verticalScale(2),
            ),
            elevation: 1,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 7),
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
                            : user.type == 3
                                ? Color.fromARGB(255, 222, 170, 1)
                                : Colors.white,
                        child: CircleAvatar(
                          radius: ResponsiveFlutter.of(context).hp(2.7),
                          backgroundImage: user.imagen != ""
                              ? NetworkImage(user.imagen)
                              : null,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //print("ELIMINAR");

                          if (asignMonto == 0 && widget.editMode == 0) {
                            deleteUserList(user);
                          }

                          if (asignMonto == 1) {
                            //print("ENTRA");

                            if (userAsingSel.length > 0) {
                              // print("ENTRA 2");
                              removerAsigEdit(user);
                            }
                          }
                          setState(() {});
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
                    user.fullname != null ? user.fullname.trim() : "sin Nombre",
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
                      widget.opcion == 2
                          ? Text(
                              "\$" + format(user.compras),
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.left,
                            )
                          : SizedBox(),
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

    CalcularMontoTotalP() {
      double vP = 0;
      for (userTransactions u in userSelectedT) {
        vP += u.puntos;
      }
      return vP;
    }

    CalcularMontoAsingnP() {
      double vP = 0;
      for (userTransactions u in userAsingSel) {
        vP += u.puntos;
      }
      return vP;
    }

    CalcularMontoTotalC() {
      double cP = 0;
      for (userTransactions u in userSelectedT) {
        cP += u.compras;
      }
      return cP;
    }

    CalcularMontoAsingnC() {
      double cP = 0;
      for (userTransactions u in userAsingSel) {
        cP += u.compras;
      }
      return cP;
    }

    Container cardsWoin2(context, int id) {
      int index = sesion.getCuentaActiva;

      return Container(
        padding: EdgeInsets.only(
            bottom: ResponsiveFlutter.of(context).verticalScale(7),
            top: ResponsiveFlutter.of(context).verticalScale(0),
            left: 0,
            right: 0),
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              child: Card(
                margin: EdgeInsets.all(0),
                elevation: 3,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            (() {
                              if (id == 1) {
                                //print(id);
                                return "Emwoin";
                              } else if (id == 0) {
                                return "Cliwoin";
                              } else {
                                return "";
                              }
                            }()),
                            style: TextStyle(
                              fontSize: 12,
                              color: (() {
                                if (id == 1) {
                                  return Color.fromARGB(255, 222, 170, 1);
                                } else if (id == 0) {
                                  return Color.fromARGB(255, 27, 166, 210);
                                } else {
                                  return Colors.transparent;
                                }
                              }()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 0),
                              child: Text(
                                "Mi saldo",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 20, top: 0, bottom: 10),
                              child: Text(
                                "46800000.00",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 1, 90, 136),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      widget.opcion == 1
                                          ? "Pagar puntos:"
                                          : widget.opcion == 2
                                              ? "Regalar puntos"
                                              : widget.opcion == 3
                                                  ? "Enviar puntos"
                                                  : "Solicitar puntos",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color.fromARGB(255, 1, 90, 136),
                                      ),
                                    ),
                                    Text(
                                      "\$ ${asignMonto == 0 ? CalcularMontoTotalP().floor().toString() : CalcularMontoAsingnP().floor().toString()}",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 1, 90, 136),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                                widget.opcion == 1 || widget.opcion == 2
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            widget.opcion == 1
                                                ? "Pagar compras"
                                                : "Valor venta x" +
                                                    porcentaje.toString() +
                                                    "%",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 11),
                                          ),
                                          Text(
                                            "\$ ${asignMonto == 0 ? format(CalcularMontoTotalC()) : format(CalcularMontoAsingnC())}",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )
                                        ],
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[400], width: 0.5),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                child: Container(
                  margin: EdgeInsets.only(right: 0.5, top: 0.5),
                  width: MediaQuery.of(context).size.width * 0.47,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 237, 242, 1),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0))),
                  alignment: Alignment.centerRight,
                ),
                clipper: BottomGreyClipper2(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                child: Container(
                  margin: EdgeInsets.only(right: 0.5, top: 0.5),
                  width: MediaQuery.of(context).size.width * 0.41,
                  decoration: BoxDecoration(
                      gradient: (() {
                        if (id == 1) {
                          return LinearGradient(
                              colors: [
                                Color.fromRGBO(255, 238, 0, 1),
                                Color.fromRGBO(194, 159, 0, 1),
                                Color.fromRGBO(128, 73, 0, 1)
                              ],
                              stops: [
                                0.08,
                                0.22,
                                0.8
                              ],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomLeft);
                        } else if (id == 0) {
                          return LinearGradient(
                              colors: [
                                Color.fromRGBO(0, 255, 229, 1),
                                Color.fromRGBO(13, 183, 203, 1),
                                Color.fromRGBO(0, 117, 177, 1)
                              ],
                              stops: [
                                0.01,
                                0.15,
                                0.5
                              ],
                              begin: FractionalOffset.topRight,
                              end: FractionalOffset.bottomLeft);
                        } else {
                          return LinearGradient(colors: [Colors.white]);
                        }
                      }()),

                      // color: index == 0?Colors.blue[700]:Colors.amber[500],
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0))),
                ),
                clipper: BottomWaveClipper2(),
              ),
            ),
            Positioned(
              right: 10,
              top: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: (() {
                    if (id == 1 && sesion.getImageEm != null) {
                      return Colors.transparent;
                    } else if (id == 0 && sesion.getImageCli != null) {
                      return Colors.transparent;
                    } else {
                      return Colors.grey[200];
                    }
                  }()),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      (() {
                        if (id == 1 && sesion.getImageEm != null) {
                          return sesion.getImageEm;
                        } else if (id == 0 && sesion.getImageCli != null) {
                          return sesion.getImageCli;
                        } else {
                          return "";
                        }
                      }()),
                    ),
                  ),
                ),
                width: MediaQuery.of(context).size.width * .13,
                height: MediaQuery.of(context).size.width * .13,
                child: (() {
                  if (id == 1 && sesion.getImageEm != null) {
                    return SizedBox();
                  } else if (id == 0 && sesion.getImageCli == null) {
                    return Center(
                      child: Text(
                        /* sesion.getSession.person.fullName[0]*/ "J",
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    );
                  } else {
                    return Center();
                  }
                }()),
              ),
            )
          ],
        ),
      );
    }

    actualizarMontoAsign() {
      for (userTransactions u in userAsingSel) {
        for (userTransactions u1 in userSelectedT) {
          if (u.codewoiner == u1.codewoiner) {
            u1.puntos = u.puntos;
            u1.compras = u.compras;
          }
        }
      }
    }

    obtenerValorSelected(userTransactions u) {
      for (userTransactions u1 in userAsingSel) {
        if (u.codewoiner == u1.codewoiner) {
          return u1;
        }
      }
      return null;
    }

    double calcularMontoTotalPuntos() {
      double total = 0;
      for (userTransactions u in userSelectedT) {
        total += u.puntos;
      }
      return total;
    }

    double calcularMontoTotalAsign() {
      double total = 0;
      for (userTransactions u in userAsingSel) {
        total += u.puntos;
      }
      return total;
    }

    final bottomSheet = CupertinoActionSheet(
      cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.cancel,
                color: Colors.grey[700],
              ),
              Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          )),
      title: Text("Tipo de Transferencia"),
      actions: <Widget>[
        widget.opcion != 1
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    widget.opcion = 1;
                    valoroption = -1;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.account_balance_wallet,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Pagar      ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : SizedBox(),
        widget.opcion != 2
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    widget.opcion = 2;
                    valoroption = -1;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_giftcard,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Regalar   ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
        widget.opcion != 3
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    widget.opcion = 3;

                    valoroption = -1;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.send,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "Enviar    ",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
        widget.opcion != 4
            ? CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () {
                  setState(() {
                    widget.opcion = 4;
                    valoroption = -1;
                    Navigator.of(context).pop();
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.system_update,
                      color: Colors.grey[600],
                    ),
                    Text(
                      " Solicitar",
                      style: TextStyle(
                          color: Colors.grey[600], fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              )
            : SizedBox(),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          (() {
            print("OPCION=>" + widget.opcion.toString());
            if (widget.editMode == 0) {
              if (widget.opcion == 1) {
                return "Pagar";
              } else if (widget.opcion == 2) {
                return "Regalar";
              } else if (widget.opcion == 3) {
                return "Enviar";
              } else {
                return "Solicitar";
              }
            } else {
              return "Modificar monto";
            }
          }()),
          style: TextStyle(color: Color.fromARGB(255, 27, 166, 210)),
        ),
        leading: Container(
          //color: Colors.red,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          width: 10,
          height: 10,
          child: Builder(builder: (BuildContext context) {
            return IconButton(
              padding: EdgeInsets.all(3),
              splashColor: Colors.white,
              alignment: Alignment.centerLeft,
              icon: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(
                  0xffbbbbbb,
                ),
              ),
              onPressed: () {
                // print("PUNTOS=>" + widget.userSelected[0].puntos.toString());
                if (asignMonto == 1) {
                  asignMonto = 0;
                  String value = "0";
                  mycontroller.value = new TextEditingValue(
                      text: value.toString(),
                      selection: new TextSelection(
                          baseOffset: value.toString().length,
                          extentOffset: value.toString().length,
                          affinity: TextAffinity.downstream,
                          isDirectional: false),
                      composing: new TextRange(start: 0, end: 0));
                  setState(() {});
                } else {
                  Navigator.of(context).pop();
                }
              },
            );
          }),
        ),
        actions: <Widget>[
          widget.editMode == 1
              ? Padding(
                  padding: EdgeInsets.only(right: 8, top: 15, bottom: 3),
                  child: InkWell(
                    onTap: () {
                      for (userTransactions u1 in widget.userall) {
                        u1.selected = 0;
                      }
                      if (userSelectedT != null && userSelectedT.length > 0) {
                        for (userTransactions u in userSelectedT) {
                          for (userTransactions u1 in widget.userall) {
                            if (u.codewoiner == u1.codewoiner &&
                                u.selected == 1) {
                              u1.selected = 1;
                            }
                          }
                        }
                      }
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return userTransacctionSlected(
                          luserSelected: widget.userall,
                          redirigirPage: 0,
                        );
                      })).then((users) {
                        valsum = 0;
                        valrest = 0;
                        isUltimo = false;
                        isUltimoC = false;
                        isUltimoopt2 = false;
                        isUltimoopt2C = false;
                        if (users != null && users.length > 0) {
                          userSelectedT.clear();
                          for (userTransactions u in users) {
                            if (u.selected == 1) {
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
                                  woinerId: u.woinerId,
                                  valorFijo: u.valorFijo,
                                  efecfijo: u.efecfijo);

                              userSelectedT.add(u);
                            }
                          }

                          if (valoroption == 1 ||
                              valoroption == 0 ||
                              valoroption == 5 ||
                              valoroption == 6) {
                            mycontroller.text = "0";
                          } else {
                            mycontroller.text = "0.0";
                          }

                          setState(() {});
                        }
                      });
                    },
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 35,
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_add,
                          color: Color(
                            0xffbbbbbb,
                          ),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          asignMonto == 1
              ? Padding(
                  padding: EdgeInsets.only(right: 8, top: 15, bottom: 3),
                  child: InkWell(
                    onTap: () {
                      for (userTransactions u1 in widget.userall) {
                        u1.selected = 0;
                      }
                      if (userAsingSel != null && userAsingSel.length > 0) {
                        for (userTransactions u in userSelectedT) {
                          for (userTransactions u1 in widget.userall) {
                            if (u.codewoiner == u1.codewoiner) {
                              u1.puntos = u.puntos;
                              u1.compras = u.compras;
                            }
                          }
                        }
                        for (userTransactions u in userAsingSel) {
                          for (userTransactions u1 in widget.userall) {
                            if (u.codewoiner == u1.codewoiner) {
                              //print("ENTRO");
                              u1.selected = 1;
                              u1.puntos = u.puntos;
                              u1.compras = u.compras;
                            }
                          }
                        }
                      }
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return transactionGnal(
                          editMode: 1,
                          opcion: widget.opcion,
                          userSelected: widget.userall,
                        );
                      })).then((users) {
                        valsum = 0;
                        valrest = 0;
                        isUltimo = false;
                        isUltimoC = false;
                        isUltimoopt2 = false;
                        isUltimoopt2C = false;
                        if (users != null && users.length > 0) {
                          userAsingSel.clear();
                          for (userTransactions u in users) {
                            if (u.selected == 1) {
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
                              userAsingSel.add(u);
                              print("agregado");
                            }
                          }

                          if (valoroption == 1 ||
                              valoroption == 0 ||
                              valoroption == 5 ||
                              valoroption == 6) {
                            mycontroller.text = "0";
                          } else {
                            mycontroller.text = "0.0";
                          }

                          setState(() {});
                        }
                      });
                    },
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      width: 35,
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_add,
                          color: Color(
                            0xffbbbbbb,
                          ),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
      body: Column(
        children: <Widget>[
          userSelectedT.length > 0
              ? Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(
                        left: 0,
                        top: ResponsiveFlutter.of(context).verticalScale(5),
                        bottom: ResponsiveFlutter.of(context).verticalScale(5)),
                    child: userSelectedT.length > 1 && asignMonto == 0
                        ? ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            scrollDirection: Axis.horizontal,
                            itemCount: userSelectedT.length,
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                            itemBuilder: (context, index) =>
                                _wlist(userSelectedT[index]))
                        : userSelectedT.length == 1 && asignMonto == 0
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 1),
                                margin: EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 2),
                                width: ResponsiveFlutter.of(context).wp(100),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.grey[300], width: 0.5),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
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
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: CircleAvatar(
                                                radius: ResponsiveFlutter.of(
                                                        context)
                                                    .hp(2.8),
                                                backgroundColor:
                                                    userSelectedT[0].type == 2
                                                        ? Color.fromARGB(
                                                            255, 27, 166, 210)
                                                        : Color.fromARGB(
                                                            255, 222, 170, 1),
                                                child: CircleAvatar(
                                                  radius: ResponsiveFlutter.of(
                                                          context)
                                                      .hp(2.7),
                                                  backgroundImage:
                                                      userSelectedT[0].imagen !=
                                                              ""
                                                          ? NetworkImage(
                                                              userSelectedT[0]
                                                                  .imagen)
                                                          : null,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                deleteUserList(
                                                    userSelectedT[0]);
                                                montoNew.opcion =
                                                    opcionCalculate;
                                                montoNew.montoefecAll =
                                                    montoNew.efbase *
                                                        userSelectedT.length;
                                                montoNew.montopuntosAll =
                                                    montoNew.puntobase *
                                                        userSelectedT.length;

                                                montoUsers usm = new montoUsers(
                                                    monto: montoNew,
                                                    users: userSelectedT);
                                                Navigator.of(context).pop(usm);
                                                //Navigator.of(context).pop(userSelectedT);
                                              },
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: ResponsiveFlutter.of(
                                                        context)
                                                    .wp(8),
                                                height: ResponsiveFlutter.of(
                                                        context)
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
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Text(
                                              userSelectedT[0].fullname,
                                              style: TextStyle(
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 10,
                                                  fontFamily: "Roboto"),
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              userSelectedT[0]
                                                  .puntos
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.blue[700],
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800),
                                              textAlign: TextAlign.left,
                                            ),
                                            widget.opcion == 1
                                                ? Text(
                                                    "\$" +
                                                        format(userSelectedT[0]
                                                            .compras),
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w800),
                                                    textAlign: TextAlign.left,
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : asignMonto == 1 && userAsingSel.length > 1
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: userAsingSel.length,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 10,
                                        ),
                                    itemBuilder: (context, index) =>
                                        _wlist(userAsingSel[index]))
                                : asignMonto == 1 && userAsingSel.length == 1
                                    ? Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 1),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 0),
                                        width: ResponsiveFlutter.of(context)
                                            .wp(100),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey[300],
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
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
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            userAsingSel[
                                                                            0]
                                                                        .type ==
                                                                    2
                                                                ? Color
                                                                    .fromARGB(
                                                                        255,
                                                                        27,
                                                                        166,
                                                                        210)
                                                                : Color
                                                                    .fromARGB(
                                                                        255,
                                                                        222,
                                                                        170,
                                                                        1),
                                                        child: CircleAvatar(
                                                          radius: 19,
                                                          backgroundImage: userAsingSel[
                                                                          0]
                                                                      .imagen !=
                                                                  ""
                                                              ? NetworkImage(
                                                                  userAsingSel[
                                                                          0]
                                                                      .imagen)
                                                              : null,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        removerAsigEdit(
                                                            userAsingSel[0]);
                                                        asignMonto = 0;
                                                        setState(() {});
                                                      },
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: ResponsiveFlutter
                                                                .of(context)
                                                            .wp(8),
                                                        height:
                                                            ResponsiveFlutter
                                                                    .of(context)
                                                                .wp(8),
                                                        child: Icon(
                                                          FontAwesome
                                                              .times_circle,
                                                          color:
                                                              Colors.grey[500],
                                                          size: 20,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    userAsingSel[0].fullname,
                                                    style: TextStyle(
                                                        color: Colors.grey[900],
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10,
                                                        fontFamily: "Roboto"),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      userAsingSel[0]
                                                          .puntos
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.blue[700],
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                    widget.opcion == 1
                                                        ? Text(
                                                            "\$" +
                                                                userAsingSel[0]
                                                                    .compras
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey[800],
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                            textAlign:
                                                                TextAlign.left,
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                  ),
                )
              : SizedBox(),
          Expanded(
            flex: 14,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        margin: EdgeInsets.zero,
                        color: Color.fromRGBO(21, 105, 162, 1),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                          widget.editMode == 0
                                              ? "Valor total"
                                              : "Valor asignado",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 8, left: 0),
                                        child: InkWell(
                                          onTap: () {
                                            valrest = 0;
                                            valsum = 0;
                                            showCupertinoModalPopup(
                                                context: context,
                                                builder: (context) =>
                                                    bottomSheet);
                                          },
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          child: Container(
                                            width: 35,
                                            padding: EdgeInsets.all(2),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                () {
                                                  if (widget.opcion == 1) {
                                                    return Icons
                                                        .account_balance_wallet;
                                                  } else if (widget.opcion ==
                                                      2) {
                                                    return Icons.card_giftcard;
                                                  } else if (widget.opcion ==
                                                      3) {
                                                    return Icons.send;
                                                  } else {
                                                    return Icons.reply_all;
                                                  }
                                                }(),
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          asignMonto == 0
                                              ? format(
                                                  calcularMontoTotalPuntos())
                                              : format(
                                                  calcularMontoTotalAsign()),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ResponsiveFlutter.of(context).verticalScale(10),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          widget.opcion == 2
                              ? Expanded(
                                  flex: 2,
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveFlutter.of(context)
                                            .verticalScale(0),
                                        horizontal: 8,
                                      ),
                                      //color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          widget.opcion == 3 ||
                                                  widget.opcion == 4
                                              ? Container(
                                                  width: ResponsiveFlutter.of(
                                                          context)
                                                      .scale(200),
                                                  child: InkWell(
                                                    onTap: () {
                                                      mycontroller.clear();
                                                      valoroption =
                                                          valoroption == 0
                                                              ? -1
                                                              : 0;

                                                      if (widget.editMode ==
                                                          0) {
                                                        if (valoroption == 0) {
                                                          text = "0";
                                                          mycontroller.value = new TextEditingValue(
                                                              text: text,
                                                              selection: new TextSelection(
                                                                  baseOffset: text
                                                                      .length,
                                                                  extentOffset:
                                                                      text
                                                                          .length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                        }
                                                      } else {
                                                        if (valoroption == 0) {
                                                          text = "0";
                                                          mycontroller.value = new TextEditingValue(
                                                              text: text,
                                                              selection: new TextSelection(
                                                                  baseOffset: text
                                                                      .length,
                                                                  extentOffset:
                                                                      text
                                                                          .length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                        }
                                                      }

                                                      if (valoroption == 0) {
                                                        //print("ENTRA 2");
                                                        muestra = cajadeTexto(
                                                            mycontroller.text);
                                                      } else {
                                                        muestra = SizedBox();
                                                      }
                                                      setState(() {});
                                                      _controllerLV.animateTo(
                                                          anchoCard *
                                                              indiceValor(
                                                                  valorInicial
                                                                      .toDouble()),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve:
                                                              Curves.easeInOut);
                                                    },
                                                    child: Container(
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      10),
                                                          child: Center(
                                                            child: Text(
                                                              "Valor a pagar",
                                                              style: TextStyle(
                                                                  decoration: valoroption ==
                                                                          0
                                                                      ? TextDecoration
                                                                          .underline
                                                                      : TextDecoration
                                                                          .none,
                                                                  color: valoroption ==
                                                                          0
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          166,
                                                                          210)
                                                                      : Colors.grey[
                                                                          600],
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          widget.opcion == 2
                                              ? Expanded(
                                                  flex: 2,
                                                  child: InkWell(
                                                    onTap: () {
                                                      valoroption =
                                                          valoroption == 1
                                                              ? -1
                                                              : 1;

                                                      if (widget.editMode ==
                                                              0 ||
                                                          widget.editMode ==
                                                              1) {
                                                        if (valoroption == 1) {
                                                          final formatter =
                                                              new NumberFormat(
                                                                  "#,##0",
                                                                  "es_AR");
                                                          String p =
                                                              formatter.format(
                                                                  totalRegalar);
                                                          mycontroller.value = new TextEditingValue(
                                                              text: p,
                                                              selection: new TextSelection(
                                                                  baseOffset:
                                                                      p.length,
                                                                  extentOffset:
                                                                      p.length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                          muestra =
                                                              cajadeTexto(p);
                                                        }
                                                      }

                                                      setState(() {});
                                                      _controllerLV.animateTo(
                                                          anchoCard *
                                                              indiceValor(
                                                                  valorInicial
                                                                      .toDouble()),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve:
                                                              Curves.easeInOut);
                                                    },
                                                    child: Container(
                                                      width:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .wp(28),
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      6),
                                                          child: Center(
                                                            child: Text(
                                                              "Valor a Regalar",
                                                              style: TextStyle(
                                                                  color: valoroption ==
                                                                          1
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          166,
                                                                          210)
                                                                      : Colors.grey[
                                                                          600],
                                                                  fontSize: 11),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          widget.opcion == 2
                                              ? Expanded(
                                                  flex: 2,
                                                  child: InkWell(
                                                    onTap: () {
                                                      // mycontroller.clear();
                                                      valoroption =
                                                          valoroption == 3
                                                              ? -1
                                                              : 3;
                                                      for (userTransactions u
                                                          in userSelectedT) {
                                                        u.montopuntoOld =
                                                            u.puntos.toDouble();
                                                        u.montocompraOld =
                                                            u.compras;
                                                      }

                                                      if (widget.editMode ==
                                                              0 ||
                                                          widget.editMode ==
                                                              1) {
                                                        if (valoroption == 3) {
                                                          final formatter =
                                                              new NumberFormat(
                                                                  "#,##0",
                                                                  "es_AR");
                                                          String p = formatter
                                                              .format(venta);

                                                          mycontroller.value = new TextEditingValue(
                                                              text: p,
                                                              selection: new TextSelection(
                                                                  baseOffset:
                                                                      p.length,
                                                                  extentOffset:
                                                                      p.length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                          muestra =
                                                              cajadeTexto(p);
                                                        }
                                                      }

                                                      setState(() {});
                                                      _controllerLV.animateTo(
                                                          anchoCard *
                                                              indiceValor(
                                                                  valorInicial
                                                                      .toDouble()),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve:
                                                              Curves.easeInOut);
                                                    },
                                                    child: Container(
                                                      width:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .wp(28),
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      7),
                                                          child: Center(
                                                            child: Text(
                                                              "Valor venta",
                                                              style: TextStyle(
                                                                  color: valoroption ==
                                                                          3
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          166,
                                                                          210)
                                                                      : Colors.grey[
                                                                          600],
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          widget.opcion == 2
                                              ? Expanded(
                                                  flex: 2,
                                                  child: InkWell(
                                                    onTap: () {
                                                      valoroption =
                                                          valoroption == 4
                                                              ? -1
                                                              : 4;
                                                      for (userTransactions u
                                                          in userSelectedT) {
                                                        u.montopuntoOld =
                                                            u.puntos.toDouble();
                                                        u.montocompraOld =
                                                            u.compras;
                                                      }

                                                      if (widget.editMode ==
                                                              0 ||
                                                          widget.editMode ==
                                                              1) {
                                                        if (valoroption == 4) {
                                                          String p = porcentaje
                                                              .toString();
                                                          ;
                                                          mycontroller.value = new TextEditingValue(
                                                              text: p,
                                                              selection: new TextSelection(
                                                                  baseOffset:
                                                                      p.length,
                                                                  extentOffset:
                                                                      p.length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                          muestra =
                                                              cajadeTexto(p);
                                                        }
                                                      }

                                                      setState(() {});
                                                    },
                                                    child: Container(
                                                      width:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .wp(28),
                                                      child: Card(
                                                        elevation: 3,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 6,
                                                                  horizontal:
                                                                      10),
                                                          child: Center(
                                                            child: Text(
                                                              "Porcentaje",
                                                              style: TextStyle(
                                                                  color: valoroption ==
                                                                          4
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          27,
                                                                          166,
                                                                          210)
                                                                      : Colors.grey[
                                                                          600],
                                                                  fontSize: 12),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),

                                          /*  widget.editMode==0? Container(
                                      width:ResponsiveFlutter.of(context).scale(40),
                                      height:ResponsiveFlutter.of(context).verticalScale(50) ,
                                      child: InkWell(
                                        focusColor: Colors.blueAccent,
                                        hoverColor: Colors.blueAccent,
                                        onTap: () {
                                          for (userTransactions u
                                              in userSelectedT) {
                                            u.montopuntoOld =
                                                u.puntos.toDouble();
                                            u.montocompraOld = u.compras;
                                          }

                                          print("MONTO OLD PUNTO=>" +
                                              userSelectedT[0]
                                                  .montopuntoOld
                                                  .toString());
                                          print("MONTO OLD COMPRA=>" +
                                              userSelectedT[0]
                                                  .montocompraOld
                                                  .toString());

                                          showDialogOpcion(
                                                  context,
                                                  widget.editMode,
                                                  opcionCalculate,
                                                  widget.userSelected != null
                                                      ? userSelectedT.length ==
                                                              1
                                                          ? 0
                                                          : 1
                                                      : 0)
                                              .then((opcion) {
                                            if (opcion != null) {
                                              // userSelectedT.clear();

                                              opcionCalculate = opcion;
                                              if (valoroption == 1 ||
                                                  valoroption == 0 ||
                                                  valoroption == 5 ||
                                                  valoroption == 6) {
                                                mycontroller.text = "0";
                                              } else {
                                                mycontroller.text = "0.0";
                                              }

                                              //_modificarValor();
                                              setState(() {});
                                              ;
                                            }
                                          });
                                        },
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Container(
                                            child: Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.grey[400]),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  opcionCalculate == 1
                                                      ? "X"
                                                      : opcionCalculate == 2
                                                          ? "÷"
                                                          : opcionCalculate == 3
                                                              ? "+"
                                                              : "-",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey[500]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ):SizedBox(),*/
                                        ],
                                      )),
                                )
                              : SizedBox(),
                          Expanded(
                            flex: widget.opcion == 2 ? 5 : 4,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      ResponsiveFlutter.of(context).scale(10)),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: Colors.white,
                                      child: valoroption != -1
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    onTap: () {
                                                      myFocusNode.unfocus();

                                                      //PORCENTAJE
                                                      double valueActual;
                                                      double valueNuevo;

                                                      if (valoroption == 4) {
                                                        valueActual =
                                                            mycontroller.text !=
                                                                    ""
                                                                ? double.parse(
                                                                    mycontroller
                                                                        .text)
                                                                : 0;

                                                        double valueNuevo =
                                                            valueActual
                                                                    .toDouble() -
                                                                porci;

                                                        if (valueNuevo >= 0) {
                                                          mycontroller.value = new TextEditingValue(
                                                              text: valueNuevo
                                                                  .toString(),
                                                              selection: new TextSelection(
                                                                  baseOffset:
                                                                      valueNuevo
                                                                          .toString()
                                                                          .length,
                                                                  extentOffset:
                                                                      valueNuevo
                                                                          .toString()
                                                                          .length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                          porcentaje =
                                                              valueNuevo;
                                                          if (venta > 0 &&
                                                              porcentaje > 0) {
                                                            totalRegalar =
                                                                venta *
                                                                    porcentaje /
                                                                    100;
                                                            if (asignMonto ==
                                                                0) {
                                                              asignarValor(
                                                                  totalRegalar);
                                                            } else {
                                                              asignarValorE(
                                                                  totalRegalar);
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        //RESTO
                                                        String value =
                                                            mycontroller.text
                                                                .replaceAll(
                                                                    '.', '');
                                                        valueActual =
                                                            mycontroller.text !=
                                                                    ""
                                                                ? double.parse(
                                                                    value)
                                                                : 0;
                                                        // print("VALUE ACTUAL=>"+valueActual.toString());
                                                        valueNuevo = valueActual
                                                                .toDouble() -
                                                            valorInicial;
                                                        final formatter =
                                                            new NumberFormat(
                                                                "#,##0",
                                                                "es_AR");
                                                        String valor = formatter
                                                            .format(valueNuevo);
                                                        if (valueNuevo >= 0) {
                                                          if (valoroption == 0 ||
                                                              valoroption ==
                                                                  5 ||
                                                              valoroption ==
                                                                  6 ||
                                                              valoroption ==
                                                                  1) {
                                                            mycontroller.value = new TextEditingValue(
                                                                text: valor
                                                                    .toString(),
                                                                selection: new TextSelection(
                                                                    baseOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    extentOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    affinity:
                                                                        TextAffinity
                                                                            .downstream,
                                                                    isDirectional:
                                                                        false),
                                                                composing:
                                                                    new TextRange(
                                                                        start:
                                                                            0,
                                                                        end:
                                                                            0));
                                                            asignarValor(
                                                                valueNuevo);
                                                          } else {
                                                            if (valoroption ==
                                                                3) {
                                                              venta =
                                                                  valueNuevo;

                                                              if (venta >= 0 &&
                                                                  porcentaje >
                                                                      0) {
                                                                totalRegalar =
                                                                    venta *
                                                                        porcentaje /
                                                                        100;
                                                                asignarValor(
                                                                    totalRegalar);
                                                              }
                                                            }
                                                            mycontroller.value = new TextEditingValue(
                                                                text: valor
                                                                    .toString(),
                                                                selection: new TextSelection(
                                                                    baseOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    extentOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    affinity:
                                                                        TextAffinity
                                                                            .downstream,
                                                                    isDirectional:
                                                                        false),
                                                                composing:
                                                                    new TextRange(
                                                                        start:
                                                                            0,
                                                                        end:
                                                                            0));
                                                          }

                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                          vertical:
                                                              ResponsiveFlutter
                                                                      .of(context)
                                                                  .hp(1.8)),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[400]),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "-",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 5,
                                                    child: Container(
                                                        margin: EdgeInsets.symmetric(
                                                            vertical:
                                                                ResponsiveFlutter.of(
                                                                        context)
                                                                    .hp(1.8)),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  width: 1),
                                                              bottom: BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  width: 1)),
                                                        ),
                                                        child: Center(
                                                            child: muestra))),
                                                Expanded(
                                                  flex: 1,
                                                  child: InkWell(
                                                    splashColor: Color.fromARGB(
                                                        255, 27, 166, 210),
                                                    onTap: () {
                                                      myFocusNode.unfocus();

                                                      //PORCENTAJE
                                                      double valueActual;

                                                      double valueNuevo;

                                                      if (valoroption == 4) {
                                                        double valueActual =
                                                            mycontroller.text !=
                                                                    ""
                                                                ? double.parse(
                                                                    mycontroller
                                                                        .text)
                                                                : 0;

                                                        double valueNuevo =
                                                            valueActual
                                                                    .toDouble() +
                                                                porci;

                                                        if (valueNuevo <=
                                                            porcvalid) {
                                                          porcentaje =
                                                              valueNuevo;

                                                          if (venta > 0 &&
                                                              porcentaje > 0) {
                                                            totalRegalar =
                                                                venta *
                                                                    porcentaje /
                                                                    100;
                                                            if (asignMonto ==
                                                                0) {
                                                              asignarValor(
                                                                  totalRegalar);
                                                            } else {
                                                              asignarValorE(
                                                                  totalRegalar);
                                                            }
                                                          }
                                                          mycontroller.value = new TextEditingValue(
                                                              text: valueNuevo
                                                                  .toString(),
                                                              selection: new TextSelection(
                                                                  baseOffset:
                                                                      valueNuevo
                                                                          .toString()
                                                                          .length,
                                                                  extentOffset:
                                                                      valueNuevo
                                                                          .toString()
                                                                          .length,
                                                                  affinity:
                                                                      TextAffinity
                                                                          .downstream,
                                                                  isDirectional:
                                                                      false),
                                                              composing:
                                                                  new TextRange(
                                                                      start: 0,
                                                                      end: 0));
                                                        }
                                                      } else {
                                                        String value =
                                                            mycontroller.text
                                                                .replaceAll(
                                                                    '.', '');
                                                        valueActual =
                                                            mycontroller.text !=
                                                                    ""
                                                                ? double.parse(
                                                                    value)
                                                                : 0;

                                                        valueNuevo = valueActual
                                                                .toDouble() +
                                                            valorInicial;
                                                        final formatter =
                                                            new NumberFormat(
                                                                "#,##0",
                                                                "es_AR");
                                                        String valor = formatter
                                                            .format(valueNuevo);
                                                        if (valoroption == 1 ||
                                                            valoroption == 0 ||
                                                            valoroption == 5 ||
                                                            valoroption == 6) {
                                                          if (valueNuevo <=
                                                              puntosValid) {
                                                            totalRegalar =
                                                                valueNuevo;
                                                            if (asignMonto ==
                                                                0) {
                                                              asignarValor(
                                                                  totalRegalar);
                                                            } else {
                                                              asignarValorE(
                                                                  totalRegalar);
                                                            }
                                                            mycontroller.value = new TextEditingValue(
                                                                text: valor
                                                                    .toString(),
                                                                selection: new TextSelection(
                                                                    baseOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    extentOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    affinity:
                                                                        TextAffinity
                                                                            .downstream,
                                                                    isDirectional:
                                                                        false),
                                                                composing:
                                                                    new TextRange(
                                                                        start:
                                                                            0,
                                                                        end:
                                                                            0));
                                                          }
                                                        } else {
                                                          if (valueNuevo <=
                                                              comprasValid) {
                                                            venta = valueNuevo;
                                                            if (venta > 0 &&
                                                                porcentaje >
                                                                    0) {
                                                              totalRegalar =
                                                                  venta *
                                                                      porcentaje /
                                                                      100;
                                                              if (asignMonto ==
                                                                  0) {
                                                                asignarValor(
                                                                    totalRegalar);
                                                              } else {
                                                                asignarValorE(
                                                                    totalRegalar);
                                                              }
                                                            }

                                                            mycontroller.value = new TextEditingValue(
                                                                text: valor
                                                                    .toString(),
                                                                selection: new TextSelection(
                                                                    baseOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    extentOffset: valor
                                                                        .toString()
                                                                        .length,
                                                                    affinity:
                                                                        TextAffinity
                                                                            .downstream,
                                                                    isDirectional:
                                                                        false),
                                                                composing:
                                                                    new TextRange(
                                                                        start:
                                                                            0,
                                                                        end:
                                                                            0));
                                                          }
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                          vertical:
                                                              ResponsiveFlutter
                                                                      .of(context)
                                                                  .hp(1.8)),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .grey[400]),
                                                          color: Colors
                                                              .transparent),
                                                      child: Center(
                                                        child: Text(
                                                          "+",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontSize: 25,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                    ),
                                  ),
                                  valoroption != -1
                                      ? Expanded(
                                          flex: 2,
                                          child: Container(
                                            color: Colors.white,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 4,
                                                  child: ListView(
                                                      controller: _controllerLV,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5),
                                                      children: valoroption != 4
                                                          ? valores
                                                              .where((val) =>
                                                                  double.parse(
                                                                      val) >
                                                                  1)
                                                              .map(
                                                                (val) =>
                                                                    Container(
                                                                  width:
                                                                      anchoCard,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      valorInicial =
                                                                          int.parse(
                                                                              val);

                                                                      if (valoroption ==
                                                                          3) {
                                                                        if (firstAsingV ==
                                                                            0) {
                                                                          venta =
                                                                              valorInicial.toDouble();
                                                                          final formatter = new NumberFormat(
                                                                              "#,##0",
                                                                              "es_AR");
                                                                          String
                                                                              valor =
                                                                              formatter.format(venta);

                                                                          mycontroller.value = new TextEditingValue(
                                                                              text: valor.toString(),
                                                                              selection: new TextSelection(baseOffset: valor.toString().length, extentOffset: valor.toString().length, affinity: TextAffinity.downstream, isDirectional: false),
                                                                              composing: new TextRange(start: 0, end: 0));
                                                                          muestra =
                                                                              cajadeTexto(valor.toString());
                                                                          venta =
                                                                              double.parse(val);
                                                                          if (venta > 0 &&
                                                                              porcentaje > 0) {
                                                                            totalRegalar = venta *
                                                                                porcentaje /
                                                                                100;
                                                                            if (asignMonto ==
                                                                                0) {
                                                                              asignarValor(totalRegalar);
                                                                            } else {
                                                                              asignarValorE(totalRegalar);
                                                                            }
                                                                          }
                                                                          firstAsingV =
                                                                              1;
                                                                        }
                                                                      } else {
                                                                        totalRegalar =
                                                                            valorInicial.toDouble();
                                                                        final formatter = new NumberFormat(
                                                                            "#,##0",
                                                                            "es_AR");
                                                                        String
                                                                            valor =
                                                                            formatter.format(totalRegalar);
                                                                        if (firstAsignVal ==
                                                                            0) {
                                                                          mycontroller.value = new TextEditingValue(
                                                                              text: valor.toString(),
                                                                              selection: new TextSelection(baseOffset: valor.toString().length, extentOffset: valor.toString().length, affinity: TextAffinity.downstream, isDirectional: false),
                                                                              composing: new TextRange(start: 0, end: 0));
                                                                          muestra =
                                                                              cajadeTexto(valor.toString());
                                                                          if (asignMonto ==
                                                                              0) {
                                                                            asignarValor(totalRegalar);
                                                                          } else {
                                                                            asignarValorE(totalRegalar);
                                                                          }
                                                                          firstAsignVal =
                                                                              1;
                                                                        }
                                                                      }
                                                                      _controllerLV.animateTo(
                                                                          anchoCard *
                                                                              indiceValor(valorInicial
                                                                                  .toDouble()),
                                                                          duration: Duration(
                                                                              milliseconds:
                                                                                  500),
                                                                          curve:
                                                                              Curves.easeInOut);

                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          valorInicial == int.parse(val)
                                                                              ? 5
                                                                              : 2,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              2,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            bottom:
                                                                                3),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            val,
                                                                            style:
                                                                                TextStyle(color: valorInicial == int.parse(val) ? Color.fromARGB(255, 27, 166, 210) : Colors.grey[600]),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                              .toList()
                                                          : valores
                                                              .where((val) =>
                                                                  double.parse(
                                                                      val) <
                                                                  100)
                                                              .map(
                                                                (val) =>
                                                                    Container(
                                                                  width:
                                                                      anchoCard,
                                                                  child:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      porci = double
                                                                          .parse(
                                                                              val);

                                                                      if (firstAsigP ==
                                                                          0) {
                                                                        porcentaje =
                                                                            double.parse(val);

                                                                        mycontroller.value = new TextEditingValue(
                                                                            text: porcentaje
                                                                                .toString(),
                                                                            selection: new TextSelection(
                                                                                baseOffset: porcentaje.toString().length,
                                                                                extentOffset: porcentaje.toString().length,
                                                                                affinity: TextAffinity.downstream,
                                                                                isDirectional: false),
                                                                            composing: new TextRange(start: 0, end: 0));
                                                                        muestra =
                                                                            cajadeTexto(porcentaje.toString());

                                                                        if (venta >
                                                                                0 &&
                                                                            porcentaje >
                                                                                0) {
                                                                          totalRegalar = venta *
                                                                              porcentaje /
                                                                              100;
                                                                          if (asignMonto ==
                                                                              0) {
                                                                            asignarValor(totalRegalar);
                                                                          } else {
                                                                            print("ASIGNAR VALUE");
                                                                            print(totalRegalar);
                                                                            asignarValorE(totalRegalar);
                                                                            setState(() {});
                                                                          }
                                                                        }
                                                                        firstAsigP =
                                                                            1;
                                                                      }

                                                                      _controllerLV.animateTo(
                                                                          anchoCard *
                                                                              indiceValor(
                                                                                  porci),
                                                                          duration: Duration(
                                                                              milliseconds:
                                                                                  500),
                                                                          curve:
                                                                              Curves.easeInOut);

                                                                      setState(
                                                                          () {});
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          porci == double.parse(val)
                                                                              ? 5
                                                                              : 2,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              2,
                                                                          top:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                3,
                                                                            bottom:
                                                                                3),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            val,
                                                                            style:
                                                                                TextStyle(color: porci == double.parse(val) ? Color.fromARGB(255, 27, 166, 210) : Colors.grey[600]),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                              .toList()),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  /* (valoroption == 0 ||
                                              valoroption == 01 ||
                                              valoroption == 5 ||
                                              valoroption == 6) &&
                                          widget.editMode == 1
                                      ? Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            valorFijo =
                                                                valorFijo == 0
                                                                    ? 1
                                                                    : 0;
                                                            prptfijo = true;
                                                          });
                                                        },
                                                        padding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        2),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            side: BorderSide(
                                                                color: valorFijo ==
                                                                        0
                                                                    ? Colors
                                                                        .transparent
                                                                    : Colors.grey[
                                                                        700])),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                                valorFijo == 0
                                                                    ? Icons
                                                                        .radio_button_unchecked
                                                                    : Icons
                                                                        .check_circle_outline,
                                                                color: valorFijo ==
                                                                        0
                                                                    ? Colors.grey[
                                                                        700]
                                                                    : Colors.grey[
                                                                        700]),
                                                            SizedBox(width: 15),
                                                            Text(
                                                              "Fijar valor",
                                                              style: TextStyle(
                                                                  color: valorFijo ==
                                                                          0
                                                                      ? Colors.grey[
                                                                          700]
                                                                      : Colors.grey[
                                                                          700],
                                                                  decoration: valorFijo ==
                                                                          0
                                                                      ? TextDecoration
                                                                          .none
                                                                      : TextDecoration
                                                                          .underline),
                                                            ),
                                                          ],
                                                        )),
                                                  )),
                                              SizedBox(
                                                width: ResponsiveFlutter.of(
                                                        context)
                                                    .wp(5),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: FlatButton(
                                                      onPressed: () {
                                                        print(
                                                            "VALOR A MODIFICAR=>" +
                                                                mycontroller
                                                                    .text);
                                                        double val =
                                                            mycontroller.text ==
                                                                    ""
                                                                ? 0
                                                                : double.parse(
                                                                    mycontroller
                                                                        .text);
                                                        if (val == 0) {
                                                          String texto = "0";
                                                          mycontroller.value =
                                                              new TextEditingValue(
                                                            text: texto,
                                                            selection: new TextSelection(
                                                                baseOffset:
                                                                    texto
                                                                        .length,
                                                                extentOffset:
                                                                    texto
                                                                        .length,
                                                                affinity:
                                                                    TextAffinity
                                                                        .downstream,
                                                                isDirectional:
                                                                    false),
                                                            //composing: new TextRange(start: 0, end: texto.length)
                                                          );
                                                        }
                                                        _modificarValor(val);
                                                      },
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 2),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xff1ba6d2))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              FontAwesome
                                                                  .hand_pointer_o,
                                                              color: Color(
                                                                  0xff1ba6d2)),
                                                          SizedBox(width: 10),
                                                          Text("Asignar valor",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff1ba6d2))),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),*/
                                  (valoroption == 2) && widget.editMode == 1
                                      ? Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: FlatButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            valorFijoC =
                                                                valorFijoC == 0
                                                                    ? 1
                                                                    : 0;
                                                            prcfijo = true;
                                                          });
                                                        },
                                                        padding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        2),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            side: BorderSide(
                                                                color: valorFijoC ==
                                                                        0
                                                                    ? Colors
                                                                        .transparent
                                                                    : Colors.grey[
                                                                        700])),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                                valorFijoC == 0
                                                                    ? Icons
                                                                        .radio_button_unchecked
                                                                    : Icons
                                                                        .check_circle_outline,
                                                                color: valorFijoC ==
                                                                        0
                                                                    ? Colors.grey[
                                                                        700]
                                                                    : Colors.grey[
                                                                        700]),
                                                            SizedBox(width: 15),
                                                            Text(
                                                              "Fijar valor",
                                                              style: TextStyle(
                                                                  color: valorFijoC ==
                                                                          0
                                                                      ? Colors.grey[
                                                                          700]
                                                                      : Colors.grey[
                                                                          700],
                                                                  decoration: valorFijoC ==
                                                                          0
                                                                      ? TextDecoration
                                                                          .none
                                                                      : TextDecoration
                                                                          .underline),
                                                            ),
                                                          ],
                                                        )),
                                                  )),
                                              SizedBox(
                                                width: ResponsiveFlutter.of(
                                                        context)
                                                    .wp(5),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: FlatButton(
                                                      onPressed: () {
                                                        print(
                                                            "VALOR A MODIFICAR=>" +
                                                                mycontroller
                                                                    .text);
                                                        double val =
                                                            mycontroller.text ==
                                                                    ""
                                                                ? 0
                                                                : double.parse(
                                                                    mycontroller
                                                                        .text);
                                                        if (val == 0) {
                                                          String texto = "0";
                                                          mycontroller.value =
                                                              new TextEditingValue(
                                                            text: texto,
                                                            selection: new TextSelection(
                                                                baseOffset:
                                                                    texto
                                                                        .length,
                                                                extentOffset:
                                                                    texto
                                                                        .length,
                                                                affinity:
                                                                    TextAffinity
                                                                        .downstream,
                                                                isDirectional:
                                                                    false),
                                                            //composing: new TextRange(start: 0, end: texto.length)
                                                          );
                                                        }
                                                        _modificarValor(val);
                                                      },
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12,
                                                              vertical: 2),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xff1ba6d2))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              FontAwesome
                                                                  .hand_pointer_o,
                                                              color: Color(
                                                                  0xff1ba6d2)),
                                                          SizedBox(width: 10),
                                                          Text("Asignar valor",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff1ba6d2))),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Expanded(flex: 4, child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(width: 1, color: Colors.grey[300]))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: ResponsiveFlutter.of(context).wp(3)),
                      child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.close,
                                  size: 20, color: Color(0xff1ba6d2)),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).wp(3),
                              ),
                              Text(
                                'Cancelar',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0195),
                              )
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Login(),
                            ));

                            // print(username);

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                          }),
                    ),
                  ),
                  SizedBox(width: ResponsiveFlutter.of(context).wp(3)),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveFlutter.of(context).wp(3)),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                asignMonto == 1 ? "Confirmar" : 'Siguiente',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.0195),
                              ),
                              SizedBox(
                                width: ResponsiveFlutter.of(context).wp(1),
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
                            closeModal() {
                              Navigator.of(context).pop();
                            }

                            if (widget.editMode == 0 && asignMonto == 0) {
                              /* montoNew.opcion = opcionCalculate;
                              montoNew.montoefecAll =
                                  montoNew.efbase * userSelectedT.length;
                              montoNew.montopuntosAll =
                                  montoNew.puntobase * userSelectedT.length;
                              if (userSelectedT.length == 0 &&
                                  (montoNew.puntobase == 0)) {
                                montoNew.efectivo = 0;
                                montoNew.puntos = 0;
                                montoNew.efbase = 0;
                                montoNew.puntobase = 0;
                              }

                              montoUsers usm = new montoUsers(
                                  monto: montoNew, users: userSelectedT);*/

                              if (userSelectedT.length > 0) {
                                int saldoValid = saldoUsersValid();
                                if (saldoValid == 0) {
                                  showAlerts(
                                      context,
                                      "Usuarios con valor a transferir en 0, asigne un valor o eliminelo",
                                      false,
                                      closeModal,
                                      null,
                                      "Aceptar",
                                      "",
                                      null);
                                } else {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => selectionWoiner(
                                            opcion: widget.opcion,
                                            user: userSelectedT,
                                          )));
                                }
                              }
                            } else if (asignMonto == 0 &&
                                widget.editMode == 1) {
                              bool isValid = true;
                              for (userTransactions u in userSelectedT) {
                                if (u.puntos == 0) {
                                  isValid = false;
                                  break;
                                }
                              }

                              if (isValid) {
                                List<userTransactions> ledit = userSelectedT;
                                Navigator.of(context).pop(ledit);
                              } else {
                                showAlerts(
                                    context,
                                    "Usuarios con valor a transferir en 0, debe asignar un valor ",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    "",
                                    null);
                              }
                            } else if (asignMonto == 1) {
                              asignMonto = 0;

                              totalRegalar = 0;
                              porcentaje = 10;
                              porci = 10;
                              firstAsigP = 0;
                              firstAsingV = 0;
                              String value = "0";
                              firstAsignVal = 0;
                              mycontroller.value = new TextEditingValue(
                                  text: value.toString(),
                                  selection: new TextSelection(
                                      baseOffset: value.toString().length,
                                      extentOffset: value.toString().length,
                                      affinity: TextAffinity.downstream,
                                      isDirectional: false),
                                  composing: new TextRange(start: 0, end: 0));
                              valoroption = -1;
                              actualizarMontoAsign();
                            }
                            setState(() {});
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class selectionWoiner extends StatefulWidget {
  // selectionWoiner({Key key}) : super(key: key);
  int opcion;
  List<userTransactions> user;
  final int editMode;

  selectionWoiner(
      {@required this.opcion, @required this.user, this.editMode = 0});

  @override
  _selectionWoinerState createState() => _selectionWoinerState();
}

class _selectionWoinerState extends State<selectionWoiner> {
  userdetalle sesion = new userdetalle();
  Utilities utils = Utilities();
  int selected = 0;
  WalletService ws = WalletService();

  @override
  void initState() {
    super.initState();
    print(widget.opcion);
    // selected = sesion.getCuentaActiva;
    selected = 1;
  }

  @override
  void dispose() {
    print("DISPOSE");
    super.dispose();
  }

  double montoUsuarios() {
    double total = 0;
    for (userTransactions u in widget.user) {
      total += u.puntos;
    }

    return total;
  }

  Future<double> obtenerBalance(int cuenta) async {
    var resp = await ws.obtenerWallet(0, cuenta);
    return resp.entities[0].balance;
  }

  @override
  Widget build(BuildContext context) {
    Widget cardsWoinCartera(BuildContext context, Cartera c) {
      return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          CarteraService.selectedCarter.add(c);
        },
        child: Container(
          padding: EdgeInsets.only(
            bottom: ResponsiveFlutter.of(context).verticalScale(3),
            top: ResponsiveFlutter.of(context).verticalScale(3),
            left: ResponsiveFlutter.of(context).scale(3),
            right: ResponsiveFlutter.of(context).scale(3),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 3,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Text(
                              c.name,
                              style: TextStyle(
                                fontSize: 12,
                                color: (() {
                                  if (c.type == 3) {
                                    return Color.fromARGB(255, 222, 170, 1);
                                  }

                                  if (c.type == 2) {
                                    return Color.fromARGB(255, 27, 166, 210);
                                  }

                                  if (c.type == 0 || c.type == 1) {
                                    return Colors.grey[400];
                                  } else {
                                    return Colors.white;
                                  }
                                }()),
                              ),
                            ),
                            c.selected == 1
                                ? SizedBox(
                                    width:
                                        ResponsiveFlutter.of(context).scale(10),
                                  )
                                : SizedBox(),
                            c.selected == 1
                                ? Icon(Icons.check_circle,
                                    color: Color(0xff1ba6d2))
                                : SizedBox()
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20, bottom: 0),
                                child: Text(
                                  c.type == 3 || c.type == 2
                                      ? "Mi saldo"
                                      : c.nombreBanco,
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: c.type == 3 || c.type == 2
                                          ? ResponsiveFlutter.of(context)
                                              .fontSize(1.6)
                                          : ResponsiveFlutter.of(context)
                                              .fontSize(2.5),
                                      fontWeight: c.type == 3 || c.type == 2
                                          ? FontWeight.normal
                                          : FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          c.type == 2 || c.type == 3
                              ? Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, top: 0, bottom: 10),
                                      child: FutureBuilder<double>(
                                        future: obtenerBalance(c.type),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            c.saldoDisponible = snapshot.data;
                                          }
                                          if (snapshot.hasData) {
                                            return Text(
                                              utils.format(snapshot.data),
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 1, 90, 136),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            );
                                          }
                                          return Transform.scale(
                                              scale: 0.3,
                                              child:
                                                  CircularProgressIndicator());
                                        },
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            c.type == 2 || c.type == 3 || c.type == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      c.type == 2 || c.type == 3 || c.type == 0
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  right: ResponsiveFlutter.of(
                                                          context)
                                                      .scale(25)),
                                              child: Text(
                                                c.fullname,
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .fontSize(1.7)),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 68),
                                      child: Text(
                                        "Dinero pagado en efectivo al comercio para ganar puntos según términos y condiciones del establecimiento",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(1.6),
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[400], width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipPath(
                  child: Container(
                    margin: EdgeInsets.only(right: 0.5, top: 0.5),
                    width: MediaQuery.of(context).size.width * 0.47,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(235, 237, 242, 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                    alignment: Alignment.centerRight,
                  ),
                  clipper: BottomGreyClipper2(),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipPath(
                  child: Container(
                    margin: EdgeInsets.only(right: 0.5, top: 0.5),
                    width: MediaQuery.of(context).size.width * 0.41,
                    decoration: BoxDecoration(
                        gradient: (() {
                          if (c.type == 3) {
                            return LinearGradient(
                                colors: [
                                  Color.fromRGBO(255, 238, 0, 1),
                                  Color.fromRGBO(194, 159, 0, 1),
                                  Color.fromRGBO(128, 73, 0, 1)
                                ],
                                stops: [
                                  0.08,
                                  0.22,
                                  0.8
                                ],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft);
                          } else if (c.type == 2) {
                            return LinearGradient(
                                colors: [
                                  Color.fromRGBO(0, 255, 229, 1),
                                  Color.fromRGBO(13, 183, 203, 1),
                                  Color.fromRGBO(0, 117, 177, 1)
                                ],
                                stops: [
                                  0.01,
                                  0.15,
                                  0.5
                                ],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft);
                          } else if (c.type == 0) {
                            return LinearGradient(
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white
                                ],
                                stops: [
                                  0.01,
                                  0.15,
                                  0.5
                                ],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft);
                          } else if (c.type == 1) {
                            return LinearGradient(
                                colors: [
                                  Colors.grey[200],
                                  Colors.grey[400],
                                  Colors.grey[500]
                                ],
                                stops: [
                                  0.01,
                                  0.15,
                                  0.5
                                ],
                                begin: FractionalOffset.topRight,
                                end: FractionalOffset.bottomLeft);
                          } else {
                            return LinearGradient();
                          }
                        }()),

                        // color: index == 0?Colors.blue[700]:Colors.amber[500],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0))),
                  ),
                  clipper: BottomWaveClipper2(),
                ),
              ),
              Positioned(
                right: c.type == 0 ? 18 : 10,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: (() {
                      if (c.type == 3 && sesion.getImageEm != null) {
                        return Colors.transparent;
                      } else if (c.type == 2 && sesion.getImageCli != null) {
                        return Colors.transparent;
                      } else {
                        return Colors.grey[200];
                      }
                    }()),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        (() {
                          if (c.type == 3 && sesion.getImageEm != null) {
                            return sesion.getImageEm;
                          } else if (c.type == 2 &&
                              sesion.getImageCli != null) {
                            return sesion.getImageCli;
                          } else if (c.type == 0 &&
                              sesion.getImageCli != null) {
                            return c.urlFranquicia;
                          } else {
                            return "";
                          }
                        }()),
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * .13,
                  height: MediaQuery.of(context).size.width * .13,
                  child: (() {
                    if (c.type == 3 && sesion.getImageEm == null) {
                      return Center(
                        child: Text(
                          "sesion.getSession.person.fullName[0],",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(4)),
                        ),
                      );
                    } else if (c.type == 2 && sesion.getImageCli == null) {
                      return Center(
                        child: Text(
                          /* sesion.getSession.person.fullName[0]*/ "J",
                          style: TextStyle(color: Colors.grey[900]),
                        ),
                      );
                    } else if (c.type == 1) {
                      return Center(
                        child: Text(
                          /* sesion.getSession.person.fullName[0]*/ "\$",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(4)),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }()),
                ),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
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
        title: Text(
          this.widget.opcion == 1
              ? "Pagar"
              : this.widget.opcion == 2
                  ? "Regalar"
                  : this.widget.opcion == 3 ? "Prestar" : "Solicitar",
          style: TextStyle(
            color: Color(0xff1ba6d2),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 18,
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              "Seleccione las carteras para realizar transferencias",
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                      widget.opcion == 1
                          ? Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 15),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) =>
                                                    addTarjeta()));
                                      },
                                      child: Card(
                                          elevation: 3,
                                          margin: EdgeInsets.zero,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    ResponsiveFlutter.of(
                                                            context)
                                                        .scale(12),
                                                vertical: ResponsiveFlutter.of(
                                                        context)
                                                    .verticalScale(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  "+ Agregar tarjeta",
                                                  style: TextStyle(
                                                      color: Colors.grey[500],
                                                      fontSize: 14),
                                                ),
                                                Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.grey,
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        top: 5,
                                        right: 10,
                                        bottom: 15),
                                    child: Card(
                                      elevation: 3,
                                      margin: EdgeInsets.zero,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                ResponsiveFlutter.of(context)
                                                    .scale(12),
                                            vertical:
                                                ResponsiveFlutter.of(context)
                                                    .verticalScale(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Icon(
                                              widget.opcion == 1
                                                  ? Icons.account_balance_wallet
                                                  : widget.opcion == 2
                                                      ? Icons.card_giftcard
                                                      : widget.opcion == 3
                                                          ? Icons.send
                                                          : Icons.system_update,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              utils.format(montoUsuarios()),
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey[600], width: 0.2),
                  )),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: CarteraService.CarteraList,
                    builder: (context, AsyncSnapshot<List<Cartera>> snapshot) {
                      List<Cartera> lc;
                      if (snapshot.hasData && snapshot.data != null) {
                        lc = snapshot.data
                            .where((car) => car.type == 2 || car.type == 3)
                            .toList();
                      }
                      return snapshot.hasData && snapshot.data != null
                          ? ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              itemCount: snapshot.data
                                  .where(
                                      (car) => car.type == 2 || car.type == 3)
                                  .toList()
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: ResponsiveFlutter.of(context)
                                      .verticalScale(190),
                                  margin: EdgeInsets.only(
                                      bottom: ResponsiveFlutter.of(context)
                                          .verticalScale(10)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 7,
                                  ),
                                  child: cardsWoinCartera(context, lc[index]),
                                );
                              })
                          : CircularProgressIndicator();
                    },
                  ),
                )
              ],
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
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Login(),
                            ));

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
                          onPressed: () async {
                            int lc = -1;
                            List<Cartera> lcar =
                                CarteraService.carteraSelected();

                            lcar = lcar
                                .where((car) => car.type == 2 || car.type == 3)
                                .toList();

                            lc = lcar.length;

                            if (widget.editMode == 0) {
                              if (lc > 1) {
                                for (Cartera c in CarteraService.lcarteras) {
                                  c.valortransferir = 0;
                                }
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => MontoCartera(
                                          opcion: this.widget.opcion,
                                          editmode: 0,
                                          lu: widget.user,
                                        )));
                              } else if (lc == 1) {
                                if (lcar[0].saldoDisponible >=
                                    montoUsuarios()) {
                                  for (int i = 0;
                                      i <
                                          CarteraService.carteraSelected()
                                              .length;
                                      i++) {
                                    if (CarteraService.carteraSelected()[i]
                                            .type ==
                                        lcar[0].type) {
                                      CarteraService.carteraSelected()[i]
                                          .valortransferir = montoUsuarios();
                                      CarteraService.carteraSelected()[i]
                                          .montofinal = montoUsuarios();
                                    }
                                  }

                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (context) => ConfirmTransactions(
                                            editMode: 0,
                                            opcion: widget.opcion,
                                            usuarios: widget.user,
                                          )));
                                } else {
                                  closeModal() {
                                    Navigator.of(context).pop();
                                  }

                                  showAlerts(
                                      context,
                                      "Saldo insuficiente para realizar transacción",
                                      false,
                                      closeModal,
                                      null,
                                      "Aceptar",
                                      null,
                                      null);
                                }
                              } else {
                                closeModal() {
                                  Navigator.of(context).pop();
                                }

                                showAlerts(
                                    context,
                                    "Seleccione por lo menos una cartera para continuar",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    null,
                                    null);
                              }
                            } else {
                              if (lc > 0) {
                                Navigator.of(context).pop(lc);
                              } else {
                                closeModal() {
                                  Navigator.of(context).pop();
                                }

                                showAlerts(
                                    context,
                                    "Seleccione por lo menos una cartera para continuar",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    null,
                                    null);
                              }
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

class transacctionExitosa extends StatefulWidget {
  final double total_transaccion;
  final List<userTransactions> usuarios;
  transacctionExitosa({Key key, this.total_transaccion, this.usuarios})
      : super(key: key);

  @override
  _transacctionExitosaState createState() => _transacctionExitosaState();
}

class _transacctionExitosaState extends State<transacctionExitosa> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(flex: 2, child: SizedBox()),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Woin",
                    style: TextStyle(
                        color: Color(0xff1ba6d2),
                        fontFamily: "Arial-rounded",
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 14,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveFlutter.of(context).wp(6)),
                child: Card(
                  elevation: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: ResponsiveFlutter.of(context).verticalScale(20),
                      ),
                      Container(
                        height: ResponsiveFlutter.of(context).hp(20),
                        width: ResponsiveFlutter.of(context).hp(25),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/PeticionesOK.gif"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Transacción exitosa",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            format(widget.total_transaccion),
                            style: TextStyle(
                                color: Color.fromRGBO(21, 105, 162, 1),
                                fontSize: 35,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Pago enviado a ${this.widget.usuarios.length.toString()} usuarios",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: ResponsiveFlutter.of(context).wp(60),
                            child: RaisedButton(
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ir a inicio',
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.white,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      //MediaQuery.of(context).size.height * .018),
                                    ),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Color(0xff1ba6d2),
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .02,
                                  bottom:
                                      MediaQuery.of(context).size.height * .02),
                              onPressed: () {
                                TransctionsService ts = TransctionsService();
                                ts.nuevaTransaccion();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: ResponsiveFlutter.of(context).wp(60),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: Color(0xff1ba6d2), width: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Ver detalle',
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Color(0xff1ba6d2),
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      //MediaQuery.of(context).size.height * .018),
                                    ),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              color: Color(0xff1ba6d2),
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * .02,
                                  bottom:
                                      MediaQuery.of(context).size.height * .02),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetalleTransaccion()));
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveFlutter.of(context).hp(1),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class userTransactionsView extends StatefulWidget {
  int opcion;

  userTransactionsView({this.opcion}) {
    print("NEW");
  }

  @override
  _userTransactionsViewState createState() => _userTransactionsViewState();
}

class _userTransactionsViewState extends State<userTransactionsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//FORMATTER INPUT TEXT

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  CurrencyPtBrInputFormatter({this.maxDigits});
  final int maxDigits;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0", "es_AR");
    String newText = formatter.format(value);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
