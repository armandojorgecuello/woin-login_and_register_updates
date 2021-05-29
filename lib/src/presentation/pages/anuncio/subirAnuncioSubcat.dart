import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Promocion/filterPromociondet.dart';

import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/entities/subcategorias/subcategorias.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';
import 'package:woin/src/presentation/pages/anuncio/anuncioDetalle.dart';
import 'package:woin/src/presentation/pages/anuncio/mainAnuncio.dart';
import 'package:woin/src/presentation/pages/tab-principal/tab.dart';
import 'package:woin/src/services/subcategoria/subcategoriaBloc.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class anuncioSubcat extends StatefulWidget {
  final tipoAnuncio tipo;
  final int prom;
  final  filterPromociondet filter;
  final List<Subcategoria> catselected;
  anuncioSubcat({this.tipo, this.prom=0,this.filter,this.catselected});

  @override
  _anuncioSubcatState createState() => _anuncioSubcatState();
}

class _anuncioSubcatState extends State<anuncioSubcat> {
  TextEditingController busquedaController = TextEditingController();
  List<Subcategoria> lc = new List();
  Subcategoria parent;
  int visiblec = 1;
  int swbuscador = 0;
  void initState() {
    KeyboardVisibilityNotification().addNewListener(onChange: (bool visible) {
      //print("ACA CARE VERGA");
      setState(() {
        visiblec = visible ? 0 : 1;
        //print(visiblec);
      });
    });
  }

  Widget buscador() {
    return Container(
      margin: EdgeInsets.all(0),
      height: 28,
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: 0),
              child: TextFormField(
                onChanged: (value) {
                  subcategorias.filterSubcat.add(value);
                },
                controller: busquedaController,
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
                      subcategorias.filterSubcat.add("");
                      busquedaController.clear();
                      setState(() {
                        swbuscador = 0;
                      });
                    },
                    child: Icon(Icons.cancel, color: Color(0xffafafaf)),
                  ),

                  hintText: "Buscar subcategorias",
                  hintStyle: TextStyle(
                      color: Color(0xffbcbcbc),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(color: Color(0xffc9c9c9))
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
          ),
        ],
      ),
    );
  }

  Widget titulo() {
    return Text(
      widget.prom==0?"Subir anuncio " + this.widget.tipo.tipo:"Subcategorías",
      style: TextStyle(

        fontFamily: "Roboto",
        fontSize: 16,
        color: Color(0xff1ba6d2),
        fontWeight: FontWeight.w700,
      ),
    );
  }

  int buscarCategoriaParent(int id) {
    if (lc.length > 0) {
      for (int i = 0; i < lc.length; i++) {
        if (lc[i].id == id) {
          return i;
        }
      }
    }
    return -1;
  }


  Subcategoria retornaCategoriaParent(int id) {
    if (lc.length > 0) {
      for (int i = 0; i < lc.length; i++) {
        if (lc[i].id == id) {
          return lc[i];
        }
      }
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    var _spacing = widthScreen * 0.03;
    var _crossAxisCount = 2;
    var width =
        ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
    var celHeight = heightScreen * .04 + 30;
    var aspectratio = width / celHeight;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        centerTitle: swbuscador == 0 ? true : false,
        titleSpacing: -20,
        elevation: 0,

        backgroundColor: Colors.white,
        title: swbuscador == 0 ? titulo() : buscador(),
        automaticallyImplyLeading: false,
        leading: Container(
          height: 45,
          width: 50,
          decoration: BoxDecoration(shape: BoxShape.circle),
          alignment: Alignment.centerLeft,
          //color: Colors.amber,
          padding: EdgeInsets.all(0),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            splashColor: Colors.white10,
            onTap: () {
              if(widget.prom==1){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TabMain(
                          index: 0,filtercats: widget.catselected!=null &&widget.catselected.length>0?true: false,filtermode: true,filterprom: false,list:widget.catselected,filterAplicados: widget.filter,)));

              }else {
                Navigator.of(context).pop();
              }
            },
            child: Icon(
              Icons.chevron_left,
              size: 35,
              color: Color(
                0xffbbbbbb,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          swbuscador == 0
              ? InkWell(
                  child: SizedBox(
                    width: 30,
                    child: Builder(builder: (BuildContext context) {
                      return IconButton(
                        padding: EdgeInsets.all(5),
                        splashColor: Colors.white,
                        alignment: Alignment.centerRight,
                        icon: Icon(
                          Icons.search,
                          size: 25,
                          color: Color(0xffbbbbbb),
                        ),
                        onPressed: () {
                          setState(() {
                            swbuscador == 1 ? swbuscador = 0 : swbuscador = 1;
                          });
                        },
                      );
                    }),
                  ),
                )
              : SizedBox(),
          InkWell(
            child: SizedBox(
              width: 35,
              child: Builder(builder: (BuildContext context) {
                return IconButton(
                  padding: EdgeInsets.only(right: 5),
                  splashColor: Colors.white,
                  alignment: Alignment.centerRight,
                  icon: Icon(
                    Icons.more_vert,
                    size: 25,
                    color: Color(0xffbbbbbb),
                  ),
                  onPressed: () {

                  },
                );
              }),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              widget.prom==0?  Flexible(
                  child: RawMaterialButton(
                    elevation: 0,
                    fillColor: this.widget.tipo.color,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.035),
                    shape: CircleBorder(),
                    child: Icon(
                      this.widget.tipo.icono,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.height * 0.035,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => mainAnuncio()));
                    },
                  ),
                ):SizedBox(),
              ],
            ),
          widget.prom==0?  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  this.widget.tipo.nombre,
                  style: TextStyle(
                      color: this.widget.tipo.color,
                      fontSize: MediaQuery.of(context).size.height * 0.0195,
                      fontFamily: "TrebuchetMS",
                      fontWeight: FontWeight.w400),
                ),
              ],
            ):SizedBox(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.015),

            Expanded(
              flex: widget.prom==0?14:16,
              child: Container(
                  height: MediaQuery.of(context).size.height * .5355,
                  color: Color(0xffecedee),
                  child: Padding(
                    padding: EdgeInsets.only(top: 9, left: 7, right: 7),
                    child: Container(
                      child: parent==null? 
                      StreamBuilder<List<Subcategoria>>(
                        stream: subcategorias.SubcategoriaListGnal,
                        builder: (Context, snapshot) {
                          return snapshot.hasData
                              ? /*GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    //childAspectRatio: aspectratio,
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .45,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (lc.length > 0 &&
                                                      lc.contains(snapshot
                                                          .data[index])) {
                                                    lc.remove(
                                                        snapshot.data[index]);
                                                  } else {
                                                    if (lc.length < 3) {
                                                      lc.add(
                                                          snapshot.data[index]);
                                                    }
                                                  }
                                                });
                                              },
                                              child: Card(
                                                elevation: lc.length > 0 &&
                                                        (lc.contains(snapshot
                                                            .data[index]))
                                                    ? 5
                                                    : 0,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20,
                                                      right: 20,
                                                      top: 13,
                                                      bottom: 12),
                                                  child: Text(
                                                    snapshot.data[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: lc.length > 0 &&
                                                                (lc.contains(
                                                                    snapshot.data[
                                                                        index]))
                                                            ? Color(0xff1ba6d2)
                                                            : Color(0xffb7b7b7),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            "TrebuchetMS",
                                                        fontSize: snapshot
                                                                    .data[index]
                                                                    .name
                                                                    .length >
                                                                15
                                                            ? MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.018
                                                            : MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.0195),
                                                  ),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    side: BorderSide.none),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )*/
                          ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context,index){
                                    return InkWell(
                                      onTap: (){
                                        if (widget.prom==0){
                                          if(snapshot.data[index].parentId==null ||snapshot.data[index].parentId==0 ){
                                            parent=snapshot.data[index];
                                            subcategorias.seleccionarParent.add(parent);
                                          }else{
                                            parent=subcategorias.lsubcatGnal.where((s)=>s.id==snapshot.data[index].parentId).toList()[0];
                                            subcategorias.seleccionarParent.add(parent);

                                            lc.add(snapshot.data[index]);
                                          }

                                          setState(() {

                                          });

                                        }else{
                                          int indx=buscarCategoriaParent(snapshot.data[index].id);
                                          if(indx>-1){
                                            lc.removeAt(indx);
                                            print("REMOVIDO");
                                          }else{
                                            if(!lc.contains(snapshot.data[index])){
                                              lc.add(snapshot.data[index]);
                                            }
                                          }
                                          setState(() {

                                          });
                                        }

                                      },
                                      child: Container(

                                        margin: EdgeInsets.only(bottom: 15,left: 6,right: 6),
                                        padding: EdgeInsets.zero,
                                        height: ResponsiveFlutter.of(context).verticalScale(55),
                                        child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child:    Card(
                                                  elevation:0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                    side: BorderSide(
                                                      color: Colors.grey[400],
                                                      width: 0.7,
                                                    )
                                                  ),
                                                  margin: EdgeInsets.zero,

                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 12,),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: <Widget>[
                                                        Expanded(
                                                          child:
                                                              Container(
                                                              padding: EdgeInsets.zero,
                                                                margin: EdgeInsets.zero,
                                                                alignment: Alignment.centerLeft,
                                                                //color:Colors.blue,
                                                                  child: Text(snapshot.data[index].name.trim(),style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.8) ,color: lc.contains(snapshot.data[index])?Color(0xff1ba6d2): Colors.grey[600],),textAlign: TextAlign.left,))

                                                        )

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                      ),
                                    );
                                  }
                                  )
                              : Center(
                                  child: CircularProgressIndicator(),
                                );

                        },
                      ): 
                      
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        reverseDuration: const Duration(milliseconds: 800),
                        switchInCurve: Curves.bounceInOut,
                        switchOutCurve: Curves.bounceIn,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: StreamBuilder<List<Subcategoria>>(
                                stream: subcategorias.SubcategoriaList,
                                builder:(context,AsyncSnapshot<List<Subcategoria>> snapshot){
                                  return snapshot.hasData? ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            parent=snapshot.data[index];
                                            lc.clear();
                                            subcategorias.seleccionarParent.add(snapshot.data[index]);

                                            setState(() {

                                            });
                                          },
                                          child: Container(

                                            margin: EdgeInsets.only(bottom: 15,left: 6,right: 6),
                                            padding: EdgeInsets.zero,
                                            height: ResponsiveFlutter.of(context).verticalScale(62),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child:    Card(
                                                    elevation:0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                        side: BorderSide(
                                                          color: Colors.grey[400],
                                                          width: 0.7,
                                                        )
                                                    ),
                                                    margin: EdgeInsets.zero,

                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 12,),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: <Widget>[
                                                          Expanded(
                                                              child:
                                                              Container(
                                                                  padding: EdgeInsets.zero,
                                                                  margin: EdgeInsets.zero,
                                                                  alignment: Alignment.centerLeft,
                                                                  //color:Colors.blue,
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: <Widget>[
                                                                      Flexible(child: Text(snapshot.data[index].name.trim(),style: TextStyle(color: parent==snapshot.data[index]?Color(0xff1ba6d2): Colors.grey[600],fontSize: ResponsiveFlutter.of(context).fontSize(snapshot.data[index].name.length>10?  1.6:1.8)),textAlign: TextAlign.left,)),
                                                                      Icon(Icons.chevron_right,color: Colors.grey[500],)
                                                                    ],
                                                                  ),

                                                          ),),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),
                                        );
                                      }
                                  ):CircularProgressIndicator();

                                } ,
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder<List<Subcategoria>>(
                                stream: subcategorias.SubcategoriaListSon,
                                builder:(context,AsyncSnapshot<List<Subcategoria>> snapshot){
                                  return snapshot.hasData? ListView.builder(
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (context,index){
                                        return InkWell(
                                          onTap: (){
                                            int indx=buscarCategoriaParent(snapshot.data[index].id);
                                            if(indx>-1){
                                              lc.removeAt(indx);
                                              print("REMOVIDO");
                                            }else{
                                              if(!lc.contains(snapshot.data[index])){
                                                lc.add(snapshot.data[index]);
                                              }


                                            }

                                            setState(() {

                                            });
                                          },
                                          child: Container(

                                            margin: EdgeInsets.only(bottom: 15,left: 6,right: 6),
                                            padding: EdgeInsets.zero,
                                            height: ResponsiveFlutter.of(context).verticalScale(55),
                                            child:  Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child:    Card(
                                                    elevation:0,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5),
                                                        side: BorderSide(
                                                          color: Colors.grey[400],
                                                          width: 0.7,
                                                        )
                                                    ),
                                                    margin: EdgeInsets.zero,

                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 12,),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,

                                                        children: <Widget>[
                                                          Expanded(
                                                              child:
                                                              Container(
                                                                  padding: EdgeInsets.zero,
                                                                  margin: EdgeInsets.zero,
                                                                  alignment: Alignment.centerLeft,
                                                                  //color:Colors.blue,
                                                                  child: Text(snapshot.data[index].name.trim(),style: TextStyle(fontSize: ResponsiveFlutter.of(context).fontSize(1.7), color: lc.contains(snapshot.data[index])?Color(0xff1ba6d2): Colors.grey[600],),textAlign: TextAlign.left,))

                                                          )

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),
                                        );
                                      }
                                  ):Center(child: CircularProgressIndicator(),);

                                } ,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            Expanded(
              flex: visiblec == 1 ? 2 : widget.prom==0? 4:3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.grey[300])
                  )
                ),
                height: MediaQuery.of(context).size.height * .07 + 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.03),
                        child: RaisedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.close,
                                  size: 20, color: Color(0xff1ba6d2)),
                              SizedBox(
                                width: 8,
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
                              left: 37, right: 37, top: 12, bottom: 12),
                          color: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            subcategorias.filterSubcat.add("");
                                  if(widget.prom==1){
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) => TabMain(
                                  index: 0,filtercats: widget.catselected!=null &&widget.catselected.length>0?true: false,filtermode: true,filterprom: false,list:widget.catselected,filterAplicados: widget.filter,)));

                                  }else {
                                    Navigator.of(context).pop();
                                  }
                            // print(username);

                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.03),
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
                                          MediaQuery.of(context).size.height *
                                              0.0195),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.0195,
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
                                left: 37, right: 37, top: 12, bottom: 12),
                            color: Color(0xff1ba6d2),
                            onPressed: () {
                              if ((lc != null && lc.length > 0) || parent!=null) {
                                if (widget.prom==0){
                                  if(parent!=null){
                                    if(!lc.contains(parent)){
                                      lc.add(parent);
                                    }
                                    for(Subcategoria s in lc){
                                      if(s.parentId==null){
                                        s.parentId=0;
                                      }
                                    }
                                    lc.sort((a,b)=>a.parentId.compareTo(b.parentId));
                                  }


                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => anuncioDetalle(
                                              this.widget.tipo, lc)));

                                }else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabMain(
                                             index: 0,filtercats: true,filtermode: true,filterprom: false,list:lc,filterAplicados: widget.filter,)));
                                }

                              } else {
                                closeModal() {
                                  Navigator.of(context).pop();
                                }

                                showAlerts(
                                    context,
                                    "Seleccione una categoria para continuar",
                                    false,
                                    closeModal,
                                    null,
                                    "Aceptar",
                                    "",
                                    null);
                              }

                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
