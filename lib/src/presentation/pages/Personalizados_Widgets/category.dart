import 'package:flutter/material.dart';
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/services/Category/categoryBloc.dart';
import 'package:woin/src/services/categoryService.dart';

Future<Category> showDialogCategory(BuildContext context, Category c) async {
  Category selectedCategory = await showDialog<Category>(
      context: context,
      builder: (context) {
        Category cat = c;
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

          Widget buscadorp() {
            return Container(
              margin: EdgeInsets.all(0),
              height: 28,
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: 40, left: 0),
                      child: TextFormField(
                        onChanged: (value) {},
                        autofocus: true,
                        controller: busquedaControllerp,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          isDense: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xffafafaf),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              busquedaControllerp.clear();
                            },
                            child: Icon(Icons.cancel, color: Color(0xffafafaf)),
                          ),

                          hintText: "Buscar categoría",
                          hintStyle: TextStyle(
                              color: Color(0xffbcbcbc),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                          enabledBorder: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Color(0xffc9c9c9))
                              // borderSide: new BorderSide(color: Colors.teal)
                              ),
                          focusedBorder: new OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              borderSide: BorderSide(color: Colors.grey[500])
                              // borderSide: new BorderSide(color: Colors.teal)
                              ),
                          // labelText: 'Correo'
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          Widget titulo() {
            return Text(
              "Seleccione categoría",
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
                var heightc = MediaQuery.of(context).size.height * .8;
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
                          actions: <Widget>[
                            buscador == 0
                                ? IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Color(0xff97a4b1),
                                    ),
                                    alignment: Alignment.centerLeft,
                                    onPressed: () {
                                      setState(() {
                                        buscador = 1;
                                      });
                                    })
                                : SizedBox()
                          ],
                          leading: IconButton(
                            icon: Icon(
                              Icons.chevron_left,
                              size: 18,
                              color: Color(0xff97a4b1),
                            ),
                            alignment: Alignment.centerLeft,
                            onPressed: () {
                              if (buscador == 0) {
                                Navigator.of(context).pop();
                              } else {
                                setState(() {
                                  buscador = 0;
                                });
                              }
                            },
                          ),
                          title: buscador == 0 ? titulo() : buscadorp(),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              cat != null
                                  ? Expanded(
                                      flex: buscador == 0 ? 2 : 3,
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
                                            cat == null
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
                                                                      0.012),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Flexible(
                                                            flex: 1,
                                                            child: Text(
                                                              cat.name,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Roboto",
                                                                  color:
                                                                      Colors.grey[
                                                                          600],
                                                                  fontSize: cat
                                                                              .name
                                                                              .length >
                                                                          15
                                                                      ? heightc *
                                                                          .018
                                                                      : heightc *
                                                                          .022),
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
                              Expanded(
                                flex: 12,
                                child: Container(
                                  color: Color(0xffecedee),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 9, left: 7, right: 7),
                                    child: Container(
                                      child: StreamBuilder<List<Category>>(
                                          stream: categoriesbloc.categoriesList,
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
                                                                      cat = snapshot
                                                                              .data[
                                                                          index];
                                                                    });
                                                                  },
                                                                  child: Card(
                                                                    elevation:
                                                                        cat != null &&
                                                                                cat.id == snapshot.data[index].id
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
                                                                              13,
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
                                                                              style: TextStyle(color: cat != null && cat.id == snapshot.data[index].id ? Color(0xff1ba6d2) : Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize: snapshot.data[index].name.length > 15 ? heightc * 0.022 : heightc * 0.025),
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
                                  flex: buscador == 1
                                      ? cat == null ? 3 : 4
                                      : cat == null ? 2 : 3,
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
                                                  Navigator.of(context)
                                                      .pop(cat);

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
  return selectedCategory;
}
