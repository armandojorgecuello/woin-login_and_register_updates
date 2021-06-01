import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/entities/Countries/Country.dart';
import 'package:woin/src/entities/Countries/countryCity.dart';
import 'package:woin/src/providers/document_type_provider.dart';
import 'package:woin/src/services/Scope/countryService.dart';

showDialogCity(
  BuildContext context,
) async {
  TextEditingController busquedaControllerp = TextEditingController();
  countryCity ubicacionSel = await showDialog<countryCity>(
      context: context,
      builder: (context) {
        int buscador = 0;
        int page = 1;
        String msj = "";
        int hb = 0;
        return StatefulBuilder(
          builder: (context, setState) {
          return AlertDialog(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentPadding: EdgeInsets.all(0),
            content: Builder(
              builder: (context) {
                return Container(
                  width: 95.0.w,
                  height: 70.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.all(0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExpeditionPlaceWidget(
                      buscador: buscador,
                      page: page,
                      busquedaControllerp: busquedaControllerp,
                      msj: msj
                    ),
                  ),
                );
              },
            ),
          );
        });
      });
  return ubicacionSel;
}

class ExpeditionPlaceWidget extends StatefulWidget {
  const ExpeditionPlaceWidget({
    Key key,
    @required this.buscador,
    @required this.page,
    @required this.busquedaControllerp,
    @required this.msj,
  });

  final int buscador;
  final int page;
  final TextEditingController busquedaControllerp;
  final String msj;

  @override
  _ExpeditionPlaceWidgetState createState() => _ExpeditionPlaceWidgetState();
}

class _ExpeditionPlaceWidgetState extends State<ExpeditionPlaceWidget> {

  TextEditingController _searchController = TextEditingController();
  List<Cities> _searchResult = [];

  List<Cities> _cityList = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        color: Colors.white,
        child:Container(
          child: _searchResult.length == 0 || _searchController.text.isEmpty ? StreamBuilder<List<Cities>>(
            stream: countryService.CityList,
            builder: (context, snapshot) {
              return snapshot.hasData
              ? ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                  _cityList = snapshot.data;
                  var data = snapshot.data[index];
                  return ListTile(
                    onTap: (){
                      Provider.of<DoumentTypeProvider>(context, listen: false).getCity = data ;
                      Navigator.of(context).pop();
                    },
                    leading: CircleAvatar(
                      backgroundColor:  Color(0xff1ba6d2),
                      child: Text(data.name[0], style: TextStyle(fontSize: 11.0.sp, color:Colors.white))
                    ),
                    title: Text(data.name, style: TextStyle(fontSize: 11.0.sp))
                  );
                }
              )
              : Center(
                child:CircularProgressIndicator(),
              );
            }
          ) : ListView.builder(
            itemCount: _searchResult.length,
            itemBuilder: (context, index){
              var data = _searchResult[index];
              return ListTile(
                onTap: (){
                  Provider.of<DoumentTypeProvider>(context, listen: false).getCity = data ;
                  Navigator.of(context).pop();
                },
                leading: CircleAvatar(
                  backgroundColor:  Color(0xff1ba6d2),
                  child: Text(data.name[0], style: TextStyle(fontSize: 11.0.sp, color:Colors.white))
                ),
                title: Text(data.name, style: TextStyle(fontSize: 11.0.sp))
              );
            }
          ),
        ), 
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Container(
        padding: EdgeInsets.symmetric(horizontal:3.0.w),
        width: 100.0.w,
        child: TextField(
          controller: _searchController,
          onChanged: (value){
            onSearchTextChanged(value);
          },
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Buscar Ciudad",
            hintStyle: TextStyle(
              color: Color(0xff1ba6d2),
              fontSize:12.0.sp
            ),
          ),
          style: TextStyle(
            color: Color(0xff1ba6d2),
            fontSize:12.0.sp
          ),
        ),
      )
    );
  }



  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _cityList.forEach((city) {
      if (city.name.contains(text))
        _searchResult.add(city);
    });

    setState(() {});
  }
}


