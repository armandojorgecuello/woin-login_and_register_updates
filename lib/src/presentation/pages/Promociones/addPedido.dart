import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/Promocion/Pedido.dart';
import 'package:woin/src/services/promociones/pedidoBloc.dart';

class addPedido extends StatefulWidget {
  @override
  _addPedidoState createState() => _addPedidoState();
}

class _addPedidoState extends State<addPedido> {
  Color currentColor = Colors.limeAccent;
  void changeColor(Color color) => setState(() => currentColor = color);
  @override
  Widget build(BuildContext context) {
    TextEditingController ctrlCantidad = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          "Agregar pedido",
          style: TextStyle(color: Color(0xff1ba6d2), fontSize: 17),
        ),
        elevation: 0,
        centerTitle: true,
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
              Navigator.of(context).pop();
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
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: ResponsiveFlutter.of(context).hp(30),
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[500], width: 0.2),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextFormField(
                          controller: ctrlCantidad,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: Colors.grey[400],
                              fontSize:
                                  MediaQuery.of(context).size.height * .018),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),

                            //labelText: 'Usuario, Email o Teléfono',
                            hintText: "Cantidad",
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize:
                                    MediaQuery.of(context).size.height * .018),

                            // fillColor: Colors.white,
                            labelStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize:
                                    MediaQuery.of(context).size.height * .016),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey[300])
                                // borderSide: new BorderSide(color: Colors.teal)
                                ),
                            focusedBorder: new OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey[500])
                                // borderSide: new BorderSide(color: Colors.teal)
                                ),

                            // labelText: 'Correo'
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveFlutter.of(context).wp(3),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  titlePadding: const EdgeInsets.all(0.0),
                                  contentPadding: const EdgeInsets.all(0.0),
                                  content: Container(
                                    padding: EdgeInsets.zero,
                                    height:
                                        ResponsiveFlutter.of(context).hp(30),
                                    width: ResponsiveFlutter.of(context).wp(90),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10, left: 12, right: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text("Seleccione un color"),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Icon(Icons.cancel))
                                                ],
                                              )),
                                          height: ResponsiveFlutter.of(context)
                                              .hp(5),
                                        ),
                                        Divider(),
                                        Expanded(
                                          child: MaterialColorPicker(
                                            circleSize: 25.0,
                                            shrinkWrap: true,
                                            onColorChange: changeColor,
                                            selectedColor: currentColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Aceptar"),
                                      onPressed: () {},
                                    )
                                  ],
                                );
                              });
                        },
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Color",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Modelo",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveFlutter.of(context).wp(3),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Talla",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Marca",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveFlutter.of(context).wp(3),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Serie",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {},
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide(
                                width: 0.5, color: Colors.grey[400])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Costo domicilio",
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w400,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.7)),
                              ),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.grey[400])
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ResponsiveFlutter.of(context).wp(3),
                    ),
                    Expanded(
                        child: FlatButton(
                      onPressed: () {
                        Pedido p = new Pedido(
                            color: currentColor,
                            cantidad: int.parse(ctrlCantidad.text),
                            id: pedidosBloc.lpedidos.length > 0
                                ? pedidosBloc
                                        .lpedidos[
                                            pedidosBloc.lpedidos.length - 1]
                                        .id +
                                    1
                                : 1,
                            costo_domicilio: 0.0,
                            marca: "loquesea",
                            modelo: "model",
                            nombreProducto: "Producto 1",
                            serie: "SERIE");
                        pedidosBloc.addPedidoSink.add(p);
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add_circle_outline),
                          Text("Agregar Pedido")
                        ],
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: ResponsiveFlutter.of(context).hp(3),
            child: StreamBuilder<List<Pedido>>(
              stream: pedidosBloc.PedidoStreamList,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Pedido>> snapshot) {
                if (snapshot.hasData) {
                  return Text("Pedidos Actuales (${snapshot.data.length})");
                } else {
                  return Text("Pedidos Actuales 0");
                }
              },
            ),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.grey[200],
                child: StreamBuilder<List<Pedido>>(
                  stream: pedidosBloc.PedidoStreamList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Pedido>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length == 0) {
                        return Container(
                          color: Colors.grey[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.info_outline),
                              Text("No tiene pedidos agregados")
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          color: Colors.grey[100],
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: ResponsiveFlutter.of(context)
                                        .verticalScale(10)),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        width: 0.2, color: Colors.grey[500])),
                                height: ResponsiveFlutter.of(context)
                                    .verticalScale(65),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                        flex: 1,
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.red[200],
                                        )),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${snapshot.data[index].nombreProducto}(${snapshot.data[index].cantidad})",
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: snapshot
                                                        .data[index].color),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "${snapshot.data[index].marca}" +
                                                    "/" +
                                                    "${snapshot.data[index].modelo}",
                                                style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          pedidosBloc.addPedidoSink
                                              .add(snapshot.data[index]);
                                        },
                                        child: Icon(
                                          Icons.cancel,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return Container(
                        color: Colors.grey[100],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.info_outline),
                            Text("No tiene pedidos agregados")
                          ],
                        ),
                      );
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
