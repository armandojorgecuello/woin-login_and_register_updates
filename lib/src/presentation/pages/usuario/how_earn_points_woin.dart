import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HowToEarnWoinPoints extends StatefulWidget {
  @override
  _HowToEarnWoinPointsState createState() => _HowToEarnWoinPointsState();
}

class _HowToEarnWoinPointsState extends State<HowToEarnWoinPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:Text("Suma puntos a tu vida", style: TextStyle(color: Color(0xff1ba6d2))),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: (){
            Navigator.of(context).pop();
          }
        ),
      ),
      body: _body(),
    );
  }
  _body(){
    return Container(
      height: 90.0.h,
      width: 100.0.w,
      child: Stack(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Container(
              height: 90.0.h,
              width: 100.0.w,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      SizedBox(height: 2.0.h,),
                      _converPointsWoin(),
                      SizedBox(height: 2.0.h,),
                      Row(
                        children: [
                          Icon(Icons.camera_alt, color:Color(0xff1ba6d2)),
                          Text("  Como Ganar puntos Woin?", style:TextStyle(fontSize: 11.0.sp, color:Color(0xff1ba6d2), fontFamily: "Roboto-bold"))
                        ],
                      ),
                      SizedBox(height: 2.0.h,),
                      title(
                        "Invitando usuarios a tu red"
                      ),
                      SizedBox(height: 1.0.h,),
                      RichText(
                        text: TextSpan(
                          text: "Con cada usuario que invitas con tu código de referido, ganas 1.000 puntos woin",
                          style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                          children: <TextSpan>  [ 
                            TextSpan(
                              text: " (Hasta completar 1.000 usuarios)",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[600]),
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 2.0.h,),
                      title(
                        "Realizando compras"
                      ),
                      SizedBox(height: 1.0.h,),
                      RichText(
                        text: TextSpan(
                          text: "Por compras inferiores a un millón( \$1.000.000) ganas el 5%, y por compras superiores a un millón( \$1.000.001), si el comercio desea regalar un porcentaje mayor, podrá hacerlo.",
                          style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                          children: <TextSpan>  [ 
                            TextSpan(
                              text: " (Los puntos se ganan de por vida)",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[600]),
                            ),
                            TextSpan(
                              text: "\n\nCuando pague con dinero, es decisión de los comercios regalar puntos por compras",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                            ),
                            TextSpan(
                              text: " (No es obligatorio)",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[600]),
                            ),
                            TextSpan(
                              text: "\n\nPor cada compra que realice con puntos, se genera un sistema de compensación para incentivar el consumo colaborativo, por ejemplo si regalan el cinco porciento (5%) lo subdividimos, el 51% para el comprador, 40% red de referidos y el 10% es para el conector Woins",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                            ),
                            TextSpan(
                              text: " (El comprador directo siempre recibe el 51%)",
                              style: TextStyle(fontSize: 11.0.sp,color: Colors.grey[600]),
                            ),
                          ]
                        ),
                      ),
                      SizedBox(height: 2.0.h,),
                      Image(
                        height: 30.0.h,
                        width: 100.0.w,
                        image: AssetImage("assets/images/how_earn_woin_points.jpeg"),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 2.0.h,),
                      title(
                        "Viendo anuncios"
                      ),
                      SizedBox(height: 1.0.h,),
                      Text(
                        "Los anuncios que tengan el logo de Woin, significa que son anuncios de gane por ver, donde tendrá que cumplir con todos los pasos para ganar puntos",
                        style:TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                      ),
                      SizedBox(height: 2.0.h,),
                      title(
                        "Subiendo anuncions PAGADOS"
                      ),
                      SizedBox(height: 1.0.h,),
                      Text(
                        "Los anuncios que tengan el logo de Woin, significa que son anuncios de gane por ver, siga los pasos para ganar puntos",
                        style:TextStyle(fontSize: 11.0.sp,color: Colors.grey[400]),
                      ),
                      SizedBox(height: 10.0.h,),
                    ],
                  ),
                ],
              )
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.0.h),
              color:Colors.white,
              width: 100.0.w,
              height: 7.0.h,
              child: Center(
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        side: BorderSide(color:Color(0xff1ba6d2) )
                      ),
                    )
                  ),
                  onPressed: () { 
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40.0.w,
                    height: 5.0.h,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.close, size:20.0.sp, color:Color(0xff1ba6d2)),
                        Text("Cerrar", style:TextStyle(color:Color(0xff1ba6d2), fontSize:12.0.sp ))
                      ],
                    ),
                  ),
                )
              ),
            )
          )
        ],
      ),
    );
  }

  Container _converPointsWoin() {
    return Container(
      height: 11.0.h,
      width: 100.0.w,
      decoration: BoxDecoration(
        color:Colors.grey[300],
        borderRadius: BorderRadius.circular(5)
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("10 Puntos woins = \$ 1 cop", style: TextStyle(fontSize: 12.0.sp, fontFamily: "Roboto-bold"), ),
          SizedBox(height: 1.0.h,),
          Text("Conversión de puntos woin a pesos colombianos", style: TextStyle(fontSize: 11.0.sp, fontFamily: "Roboto-bold"),textAlign: TextAlign.center, )
        ],
      ) ,
    );
  }

  title(String text) {
    return Text(
      text,
      style: TextStyle(fontSize:11.0.sp, fontFamily: "Roboto-bold"),
    );
  }

}