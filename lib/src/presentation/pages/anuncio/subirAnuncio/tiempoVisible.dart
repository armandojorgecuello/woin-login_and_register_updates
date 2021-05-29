import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/entities/anuncio/anuncioAdd.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/alerts.dart';

class tiempoVisible extends StatefulWidget {
  final fechaAnuncio fecha;

  tiempoVisible({this.fecha});
  @override
  _tiempoVisibleState createState() => _tiempoVisibleState();
}

class _tiempoVisibleState extends State<tiempoVisible> {


  DateTime _dateDesde = null;
  DateTime _dateHasta = null;
  final int daysMaximo=5;
  var myFormat = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.fecha!=null){
      fechaAnuncio fedit=fechaAnuncio(fechadesde: widget.fecha.fechadesde,fechaHasta: widget.fecha.fechaHasta);
      _dateDesde=fedit.fechadesde;
      _dateHasta=fedit.fechaHasta;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        brightness: Brightness.light,
        title: Text("Fecha",style: TextStyle(
          fontFamily: "Roboto",
          fontSize: MediaQuery.of(context).size.height * 0.0195,
          color: Color(0xff1ba6d2),
          fontWeight: FontWeight.w700,
        ),),
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
              size: 30,
              color: Color(
                0xffbbbbbb,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex:18,
          child:Padding(
      padding: EdgeInsets.only(
      left: MediaQuery.of(context).size.width * 0.03,
        top: 10,
        bottom: 0,
        right: MediaQuery.of(context).size.width * 0.03),
    child: Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Text("Fecha de publicación",style: TextStyle(color: Colors.grey[600]),)
          ],
        ),
        SizedBox(height: 5,),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        Expanded(
        flex: 8,
        child: Container(
        width: MediaQuery.of(context).size.width * .42,
        height: MediaQuery.of(context).size.height * .25 * .17,
        child: RaisedButton(
        child: Padding(
              padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text(
              _dateDesde == null
              ? "Fecha desde"
                  : myFormat.format(_dateDesde),
              style: TextStyle(
              fontSize: MediaQuery.of(context).size.height *
              0.017,
              color: Color(0xfc979797),
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400),
              ),
              Container(
              width: MediaQuery.of(context).size.width * .045,
              child: Icon(
              Icons.keyboard_arrow_down,
              size: MediaQuery.of(context).size.height *
              .15 *
              .17,
              color: Color(0xff757575),
              )),
              ],
              ),
              ),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Color(0xffd3d7db))),
              padding: EdgeInsets.all(2),
              color: Colors.white,
              elevation: 0,
              onPressed: () {
              showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().add(Duration(days: -1)),
              lastDate: DateTime(2030))
                  .then((date) {
              if (date != null) {
              setState(() {
              _dateDesde = date;
              _dateHasta=_dateDesde.add(Duration(days: daysMaximo));
              });
              }
              });
              },
              ),
              ),
              ),

              ],
              ),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            Text("Fecha final de publicación",style: TextStyle(color: Colors.grey[600]),)
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: <Widget>[

            Expanded(
              flex: 8,
              child: Container(
                width: MediaQuery.of(context).size.width * .42,
                height: MediaQuery.of(context).size.height * .25 * .17,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _dateHasta == null
                                ? "Fecha Hasta"
                                : myFormat.format(_dateHasta),
                            style: TextStyle(
                                fontSize:
                                MediaQuery.of(context).size.height *
                                    0.017,
                                color: Color(0xfc979797),
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .045,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: MediaQuery.of(context).size.height *
                                  .15 *
                                  .17,
                              color: Color(0xff757575),
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xffd3d7db))
                    ),
                    padding: EdgeInsets.all(2),


                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),

        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding:EdgeInsets.symmetric(vertical: 25),
               // height: ResponsiveFlutter.of(context).hp(1),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info,size: 40,color: Colors.grey[500],),
                    Text("El Tiempo máximo de un anucio gratis es de 5 días",style: TextStyle(color: Colors.grey[600]),),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey[400],width: 1)
                ),
              ),
            ),
          ],
        ),

      ],
    ),
          ), ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(width: 1,color: Colors.grey[300])
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.03,
                          right: MediaQuery.of(context).size.width * 0.03),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.close,
                                size: 20,
                                color: Color(0xff1ba6d2),
                              ),
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.03,
                              ),
                              Text(
                                'Cancelar',
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Color(0xff1ba6d2),
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.019),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Colors.white,
                          onPressed: () {
                            //anuncioService.tipoPaquete.add(0);
                            Navigator.of(context).pop();
                          }

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.03,
                          left: MediaQuery.of(context).size.width * 0.03),
                      child: RaisedButton(
                          elevation: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                               "Siguiente",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize:
                                    MediaQuery.of(context).size.height *
                                        0.019),
                              ),
                              /*    SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.03,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: Colors.white,
                              ),*/
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          padding: EdgeInsets.only(
                              left: 30, right: 30, top: 12, bottom: 12),
                          color: Color(0xff1ba6d2),
                          onPressed: () {

                              if(_dateDesde==null){
                                closeModal() {
                                  Navigator.of(context).pop();
                                }
                                showAlerts( context, "Seleccione fecha de publicación", false,closeModal, null,"Aceptar","", null);
                              }else{
                                fechaAnuncio fn= fechaAnuncio(fechaHasta: _dateHasta,fechadesde: _dateDesde);
                                Navigator.of(context).pop(fn);
                              }







                          }
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DrawerMenu()));

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
