import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/users/userTransactions.dart';
import 'package:woin/src/providers/user_service.dart';

class Comercio extends StatefulWidget {
  @override
  _ComercioState createState() => _ComercioState();
}

class _ComercioState extends State<Comercio> {
  int option=1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        option=1;
                      });
                    },
                    child: Card(
                      elevation: option==1?5:2,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.location_on,size: 16,color: option==1? Color(0xff1ba6d2):Colors.grey[600]),
                            SizedBox(width: 5,),
                            Text("Mapa GPS",style: TextStyle(color: option==1? Color(0xff1ba6d2):Colors.grey[600],fontSize: 12))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        option=2;
                      });
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: option==2?5:2,

                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.assignment,size: 16,color: option==2? Color(0xff1ba6d2):Colors.grey[600],),
                            SizedBox(width: 5,),
                            Text("Directorio",style: TextStyle(color:option==2? Color(0xff1ba6d2): Colors.grey[600],fontSize: 12),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ),

          Expanded(
            flex: 10,
            child: option==1? Mapa() :ComercioDirections(),
          )

        ],

      ),
    );
  }
}

class Mapa extends StatefulWidget {

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  final currentLocation=LatLng(4.570868, -74.297333);
  final markers=Set<Marker>();


  createMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId("MarkerCurrent"),
        position: LatLng(10.45, -73.25),
        infoWindow: InfoWindow(
            title: "Mi Ubicacion",
            snippet:
            "Lat ${currentLocation.latitude} - Lng ${currentLocation.longitude}"),
        draggable: true,
        onDragEnd: onDragEnd,
      ),
    );
  }

  onDragEnd(LatLng position) {
    print("nueva posiion $position");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 8,
      ),

    );
  }
}


class ComercioDirections extends StatefulWidget {
  @override
  _ComercioDirectionsState createState() => _ComercioDirectionsState();
}

class _ComercioDirectionsState extends State<ComercioDirections> {

  int divisionPage=99999999;
  List<userTransactions> uRed = new List();
  List<userTransactions> uwoiners = new List();
  List<userTransactions> USER_GENERAL = new List();
  List<userTransactions> listShow = new List();
  List<userTransactions> lselected = new List();
  List<userTransactions> lReferidos = new List();
  List<userTransactions> lCli = new List();
  List<userTransactions> lEm = new List();

  buscarInLista(List<userTransactions> lista, userTransactions user) {
    for (userTransactions u in lista) {
      if (u.codewoiner == user.codewoiner) {
        return true;
      }
    }
    return false;
  }


   _obtenerUsuarios() async{



      try{
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
        print("TERMINO CLI"+lCli.length.toString());
        //pages[2] = (lCli.length / divisionPage).ceil();
        //print("PAGES CLI>" + pages[2].toString());
        lEm = await userService.usuariosTransactions(filterEm);
        print("TERMINO EM"+lEm.length.toString());
        // pages[3] = (lCli.length / divisionPage).ceil();
        //print("PAGES EM>" + pages[3].toString());
        uRed = await userService.usuariosTransactions(filterRed);
        print("TERMINO RED"+uRed.length.toString());
        // pages[0] = (uRed.length / divisionPage).ceil();
        //print("PAGES RED=>" + pages[0].toString());
        uwoiners = await userService.usuariosTransactions(filterWoiners);
        print("TERMINO WOINER"+uwoiners.length.toString());
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

        setState(() {
          listShow=USER_GENERAL;
        });
        return USER_GENERAL;

      }on Exception catch (e){
        return null;
      }on NoSuchMethodError catch (er){
        return null;
      }
      //CREAR FLITROS INICIALES



      //filterTransaction filter = new filterTransaction(type: opcionFilter);
      //await usersTransactionBloc.filterTypeUser(filter);
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obtenerUsuarios();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child:
           listShow.length>0? ListView.builder(
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
                                backgroundImage: listShow[index].imagen !=
                                    ""
                                    ? NetworkImage(listShow[index].imagen)
                                    : null,
                                backgroundColor:
                                listShow[index].imagen == ""
                                    ? Colors.transparent
                                    : Colors.transparent,
                                child: listShow[index].imagen == ""
                                    ? Center(
                                  child: Text(
                                    listShow[index].fullname[0],
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
                                    listShow[index].fullname.length>25?listShow[index].fullname
                                        .substring(0, 25):listShow[index].fullname,
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
                                    listShow[index].email,
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.blue[400]),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4, top: 3),
                                  child: Text(
                                    listShow[index].telefono!=null? listShow[index].telefono:" "+" "+listShow[index].pais!=null?listShow[index].pais:"",
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
                                    border: listShow[index].selected == 0
                                        ? Border.all(color: Colors.grey[300])
                                        : Border(),
                                    color: listShow[index].selected ==
                                        1 &&
                                        listShow[index].type == 2
                                        ? Colors.blue
                                        : listShow[index].selected == 1 &&
                                        listShow[index].type == 3
                                        ? Colors.orange
                                        : Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      listShow[index].type == 2
                                          ? "Cli"
                                          : "Em",
                                      style: TextStyle(
                                        color:
                                        listShow[index].selected == 1
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
            ): Column(
            mainAxisAlignment: MainAxisAlignment.center,

            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   CircularProgressIndicator(),
                ],
              ),

            ],
          )
    );
        }

}

