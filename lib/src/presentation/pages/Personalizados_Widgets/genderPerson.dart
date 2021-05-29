import 'package:flutter/material.dart';
import 'package:woin/src/entities/Persons/gender.dart';
import 'package:woin/src/services/Gender/generoBloc.dart';

Future<genero> showDialogGender(BuildContext context, genero g) async {
  genero selectedGender = await showDialog<genero>(
      context: context,
      builder: (context) {
        genero ge = g;
        int buscador = 0;
        TextEditingController busquedaControllerp = TextEditingController();

        return StatefulBuilder(builder: (context, setState) {
          var widthScreen = MediaQuery.of(context).size.width;
          var heightScreen = MediaQuery.of(context).size.height;
          var _spacing = widthScreen * 0.03;
          var _crossAxisCount = 2;
          var width = ((widthScreen - (_crossAxisCount - 1) * _spacing)) /
              _crossAxisCount;
          var celHeight = heightScreen * .09;
          var aspectratio = width / celHeight;

          Widget titulo() {
            return Text(
              "Seleccione género",
              style: TextStyle(
                  color: Color(0xff1ba6d2),
                  fontSize: MediaQuery.of(context).size.height * 0.0195),
            );
          }

          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                var heightc = MediaQuery.of(context).size.height * .45;
                var widthc = MediaQuery.of(context).size.width;
                return Container(
                    width: widthc,
                    height: heightc,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Scaffold(
                        resizeToAvoidBottomInset: false,
                        appBar: AppBar(
                          centerTitle: true,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          titleSpacing: -20,
                          leading: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 18,
                              color: Color(0xff97a4b1),
                            ),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          title: titulo(),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ge != null
                                  ? Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(top: 0),
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            ge == null
                                                ? SizedBox()
                                                : Card(
                                                    margin:
                                                        EdgeInsets.only(top: 0),
                                                    color: Colors.grey[100],
                                                    elevation: 4,
                                                    child: Container(
                                                      width: widthc * 0.38,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  widthc * 0.03,
                                                              vertical:
                                                                  heightc *
                                                                      0.025),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Flexible(
                                                            flex: 1,
                                                            child: Text(
                                                              ge.name,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  color:
                                                                      Colors.grey[
                                                                          600],
                                                                  fontSize: ge.name
                                                                              .length >
                                                                          15
                                                                      ? heightc *
                                                                          .025
                                                                      : heightc *
                                                                          .035),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              ge != null
                                  ? Expanded(
                                      flex: 1,
                                      child: SizedBox(),
                                    )
                                  : SizedBox(),
                              Expanded(
                                flex: 12,
                                child: Container(
                                  color: Color(0xffecedee),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 9, left: 7, right: 7),
                                    child: Container(
                                      child: StreamBuilder<List<genero>>(
                                          stream: gendersbloc.genderList,
                                          builder: (Context, snapshot) {
                                            return snapshot.hasData
                                                ? GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          _crossAxisCount,
                                                      childAspectRatio:
                                                          aspectratio,
                                                    ),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        snapshot.data.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Container(
                                                                height:
                                                                    heightc *
                                                                        0.15,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    .43,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      ge = snapshot
                                                                              .data[
                                                                          index];
                                                                    });
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        ge != null &&
                                                                                ge.id == snapshot.data[index].id
                                                                            ? 5
                                                                            : 0,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              10,
                                                                          bottom:
                                                                              8),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: <
                                                                            Widget>[
                                                                          Flexible(
                                                                            child:
                                                                                Text(
                                                                              snapshot.data[index].name,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(color: ge != null && ge.id == snapshot.data[index].id ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 15 ? heightc * 0.03 : heightc * 0.04),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        side: BorderSide
                                                                            .none),
                                                                  ),
                                                                ))
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: widthc * 0.03),
                                            child: RaisedButton(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.close,
                                                        size: 20,
                                                        color:
                                                            Color(0xff1ba6d2)),
                                                    SizedBox(
                                                      width: widthc * 0.03,
                                                    ),
                                                    Text(
                                                      'Cancelar',
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          color:
                                                              Color(0xff1ba6d2),
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0195),
                                                    )
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 12,
                                                    bottom: 12),
                                                color: Colors.white,
                                                elevation: 0,
                                                onPressed: () {
                                                  Navigator.pop(context);

                                                  // print(username);

                                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                }),
                                          ),
                                        ),
                                        SizedBox(width: widthc * 0.03),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: widthc * 0.03),
                                            child: RaisedButton(
                                                elevation: 0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Siguiente',
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          color: Colors.white,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0195),
                                                    ),
                                                    SizedBox(
                                                      width: widthc * 0.025,
                                                    ),
                                                    Icon(
                                                      Icons.chevron_right,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                padding: EdgeInsets.only(
                                                    left: 30,
                                                    right: 30,
                                                    top: 12,
                                                    bottom: 12),
                                                color: Color(0xff1ba6d2),
                                                onPressed: () {
                                                  Navigator.of(context).pop(ge);

                                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          );
        });
      });
  return selectedGender;
}
