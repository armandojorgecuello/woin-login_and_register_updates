import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:woin/src/entities/Persons/typeDocument.dart';
import 'package:woin/src/providers/document_type_provider.dart';
import 'package:woin/src/services/typeDocument/typeDocumentBloc.dart';



Future<typeDocument> showDialogTypeDocument(BuildContext context, typeDocument td) async {
    typeDocument selectedtype = await showDialog<typeDocument>(
    context: context,
    builder: (context) {
      int buscador = 0;
      
      return StatefulBuilder(
        builder: (context, setState) {
          var _crossAxisCount = 2;
          final double itemHeight = (30.0.h - kToolbarHeight - 24) / 2;
          final double itemWidth = 80.0.w / 2;
          var aspectratio = itemWidth / itemHeight;

          Widget titulo() {
            return Text(
              "Seleccione tipo de documento",
              style: TextStyle(
                color: Color(0xff1ba6d2),
                fontSize:13.0.sp
              ),
            );
          }
          return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                return Container(
                  width: 90.0.w,
                  height: 57.0.h,
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
                        titleSpacing: 0,
                        title: titulo(),
                      ),
                      body: _bodyScaffoldPopup(_crossAxisCount, aspectratio, setState, td, buscador, context),
                    ),
                  )
                );
              },
            ),
          );
        }
      );
    }
  );
  return selectedtype;
}

Container _bodyScaffoldPopup(int _crossAxisCount, double aspectratio, StateSetter setState, typeDocument doc, int buscador, BuildContext context) {
  return Container(
    color: Colors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 2.0.h,),
        Container(
          height: 38.0.h,
          child:  StreamBuilder<List<typeDocument>>(
            stream: documentsbloc.documentsList,
            builder: (context, snapshot) {
              return snapshot.hasData? GridView.builder(
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:_crossAxisCount,
                  childAspectRatio:aspectratio,
                ),
                scrollDirection:Axis.vertical,
                itemCount:snapshot.data.length,
                itemBuilder:(BuildContext context,int index) {
                  return Container(
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height:18.0.h,
                          width: 35.0.w,
                          child:GestureDetector(
                            onTap: () {
                              Provider.of<DoumentTypeProvider>(context, listen:false).typeDoc  = snapshot.data[index];
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              child:Center(
                                child: Text(
                                  snapshot.data[index].name,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: TextStyle(color: Color(0xffb7b7b7), fontWeight: FontWeight.w400, fontFamily: "TrebuchetMS", fontSize:10.0.sp),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:BorderRadius.circular(5),
                                side: BorderSide.none
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  );
                },
              ): Center(
                child:CircularProgressIndicator(),
              );
            }
          ),
        ),
        Center(
          child: Container(
            height: 6.0.h,
            width: 30.0.w,
            child: Center(
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color:Color(0xff1ba6d2))
                  ))
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.close, color:Color(0xff1ba6d2), size:16.0.sp),
                    Text("  Cerrar", style: TextStyle(fontSize:12.0.sp,color:Color(0xff1ba6d2)),)
                  ],
                )
              ),
            ),
          ),
        )
      ],
    ),
  );
}