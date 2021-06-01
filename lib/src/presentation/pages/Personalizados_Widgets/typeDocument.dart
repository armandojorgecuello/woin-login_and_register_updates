// import 'package:flutter/material.dart';

// import 'package:woin/src/entities/Persons/typeDocument.dart';

// import 'package:woin/src/services/typeDocument/typeDocumentBloc.dart';

// Future<typeDocument> showDialogTypeDocument(
//     BuildContext context, typeDocument td) async {
//   typeDocument selectedtype = await showDialog<typeDocument>(
//       context: context,
//       builder: (context) {
//         typeDocument doc = td;
//         int buscador = 0;
//         TextEditingController busquedaControllerp = TextEditingController();

//         return StatefulBuilder(builder: (context, setState) {
//           var widthScreen = MediaQuery.of(context).size.width;
//           var heightScreen = MediaQuery.of(context).size.height;
//           var _spacing = widthScreen * 0.03;
//           var _crossAxisCount = 2;
//           var width = ((widthScreen - (_crossAxisCount - 1) * _spacing)) / _crossAxisCount;
//           var celHeight = heightScreen * .09;
//           var aspectratio = width / celHeight;

//           Widget titulo() {
//             return
//           }
//           return AlertDialog(
//             shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             contentPadding: EdgeInsets.all(0),
//             content: Builder(
//               builder: (context) {
//                 var heightc = MediaQuery.of(context).size.height * .8;
//                 var widthc = MediaQuery.of(context).size.width;
//                 return Container(
//                     width: widthc,
//                     height: heightc,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.white,
//                     ),
//                     margin: EdgeInsets.all(0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Scaffold(
//                         resizeToAvoidBottomInset: false,
//                         appBar: AppBar(
//                           centerTitle: true,
//                           backgroundColor: Colors.white,
//                           elevation: 0,
//                           titleSpacing: -20,
//                           actions: <Widget>[
//                             buscador == 0
//                                 ? IconButton(
//                                     icon: Icon(
//                                       Icons.search,
//                                       size: 18,
//                                       color: Color(0xff97a4b1),
//                                     ),
//                                     alignment: Alignment.centerLeft,
//                                     onPressed: () {
//                                       setState(() {
//                                         buscador = 1;
//                                       });
//                                     })
//                                 : SizedBox()
//                           ],
//                           leading: IconButton(
//                             icon: Icon(
//                               Icons.chevron_left,
//                               size: 18,
//                               color: Color(0xff97a4b1),
//                             ),
//                             alignment: Alignment.centerLeft,
//                             onPressed: () {
//                               if (buscador == 0) {
//                                 Navigator.of(context).pop();
//                               } else {
//                                 setState(() {
//                                   buscador = 0;
//                                 });
//                               }
//                             },
//                           ),
//                           title:  titulo(),
//                         ),
//                         body: Container(
//                           color: Colors.white,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               doc != null
//                                   ? Expanded(
//                                       flex: buscador == 0 ? 2 : 3,
//                                       child: Container(
//                                         padding: EdgeInsets.only(top: 0),
//                                         color: Colors.white,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           mainAxisSize: MainAxisSize.min,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: <Widget>[
//                                             doc == null
//                                                 ? SizedBox()
//                                                 : Card(
//                                                     margin:
//                                                         EdgeInsets.only(top: 0),
//                                                     color: Colors.grey[100],
//                                                     elevation: 4,
//                                                     child: Container(
//                                                       width: widthc * 0.38,
//                                                       padding:
//                                                           EdgeInsets.symmetric(
//                                                               horizontal:
//                                                                   widthc * 0.03,
//                                                               vertical:
//                                                                   heightc *
//                                                                       0.012),
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: <Widget>[
//                                                           Flexible(
//                                                             flex: 1,
//                                                             child: Text(
//                                                               doc.name,
//                                                               style: TextStyle(
//                                                                   fontFamily:
//                                                                       "Roboto",
//                                                                   color:
//                                                                       Colors.grey[
//                                                                           600],
//                                                                   fontSize: doc
//                                                                               .name
//                                                                               .length >
//                                                                           15
//                                                                       ? heightc *
//                                                                           .018
//                                                                       : heightc *
//                                                                           .022),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .center,
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   : SizedBox(),
//                               Expanded(
//                                 flex: 12,
//                                 child: Container(
//                                   color: Color(0xffecedee),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         top: 9, left: 7, right: 7),
//                                     child:
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                   flex: buscador == 1
//                                       ? doc == null ? 3 : 4
//                                       : doc == null ? 2 : 3,
//                                   child: Container(
//                                     color: Colors.white,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: <Widget>[
//                                         Expanded(
//                                           flex: 1,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: widthc * 0.03),
//                                             child: RaisedButton(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: <Widget>[
//                                                     Icon(Icons.close,
//                                                         size: 20,
//                                                         color:
//                                                             Color(0xff1ba6d2)),
//                                                     SizedBox(
//                                                       width: widthc * 0.03,
//                                                     ),
//                                                     Text(
//                                                       'Cancelar',
//                                                       style: TextStyle(
//                                                           fontFamily: "Roboto",
//                                                           color:
//                                                               Color(0xff1ba6d2),
//                                                           fontSize: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height *
//                                                               0.0195),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(30),
//                                                 ),
//                                                 padding: EdgeInsets.only(
//                                                     left: 30,
//                                                     right: 30,
//                                                     top: 12,
//                                                     bottom: 12),
//                                                 color: Colors.white,
//                                                 elevation: 0,
//                                                 onPressed: () {
//                                                   Navigator.pop(context);

//                                                   // print(username);

//                                                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
//                                                 }),
//                                           ),
//                                         ),
//                                         SizedBox(width: widthc * 0.03),
//                                         Expanded(
//                                           flex: 1,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 right: widthc * 0.03),
//                                             child: RaisedButton(
//                                                 elevation: 0,
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: <Widget>[
//                                                     Text(
//                                                       'Siguiente',
//                                                       style: TextStyle(
//                                                           fontFamily: "Roboto",
//                                                           color: Colors.white,
//                                                           fontSize: MediaQuery.of(
//                                                                       context)
//                                                                   .size
//                                                                   .height *
//                                                               0.0195),
//                                                     ),
//                                                     SizedBox(
//                                                       width: widthc * 0.025,
//                                                     ),
//                                                     Icon(
//                                                       Icons.chevron_right,
//                                                       size: 20,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             30)),
//                                                 padding: EdgeInsets.only(
//                                                     left: 30,
//                                                     right: 30,
//                                                     top: 12,
//                                                     bottom: 12),
//                                                 color: Color(0xff1ba6d2),
//                                                 onPressed: () {
//                                                   Navigator.of(context)
//                                                       .pop(doc);

//                                                   //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));
//                                                 }),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ));
//               },
//             ),
//           );
//         });
//       });
//   return selectedtype;
// }
