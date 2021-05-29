import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';

Future<int> showAlerts(
    BuildContext context,
    String mensaje,
    bool status,
    Function onPress,
    Function onPress2,
    String nombreb1,
    String nombreb2,
    Color colorbt2) async {
  int respuesta = await showDialogV2(
      context: context,
      builder: (context) {
        return DialogV2(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: dialogContent2(context, mensaje, status, onPress, onPress2,nombreb1, nombreb2, colorbt2),
        );
      });
  return respuesta;
}

dialogContent2(BuildContext context, String msj, bool st, Function pres ,Function onpress2, String nombreb1, String nombreb2, Color colorbt2) {
  return WillPopScope(
    onWillPop: () async {
      Future.value(false);
    },
    child: Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 66),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              st == null
                  ? SizedBox(
                      height: ResponsiveFlutter.of(context).hp(5.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.all(
                                ResponsiveFlutter.of(context).wp(2),
                              ),
                              //color: Colors.grey[100],
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              st != null
                  ? Container(
                      margin: EdgeInsets.only(
                          top: st != null
                              ? MediaQuery.of(context).size.height * .03
                              : 0.0),
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .15,
                          left: MediaQuery.of(context).size.width * .07,
                          right: MediaQuery.of(context).size.width * .07),
                      height: MediaQuery.of(context).size.width * .16,
                      width: MediaQuery.of(context).size.width * .16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.height * 0.065),
                          image: DecorationImage(
                              image: st
                                  ? AssetImage("assets/images/PeticionesOK.gif")
                                  : AssetImage(
                                      "assets/images/PeticionesError.gif"),
                              fit: BoxFit.cover)),
                    )
                  : SizedBox(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  msj,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .0195,
                      color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .07,
                      right: MediaQuery.of(context).size.width * .07,
                      bottom: st != null
                          ? MediaQuery.of(context).size.height * .03
                          : 0),
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Color(0xff1ba6d2),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // To close the dialog
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.014,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.014,
                              ),
                              child: Text(
                                nombreb1,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .0195),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              onpress2 != null
                  ? SizedBox(height: MediaQuery.of(context).size.height * 0.01)
                  : SizedBox(),
              onpress2 != null
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * .03,
                            left: MediaQuery.of(context).size.width * .07,
                            right: MediaQuery.of(context).size.width * .07),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: colorbt2,
                          onPressed: () {
                            onpress2();
                            // To close the dialog
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.014,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.014,
                                  ),
                                  child: Text(
                                    nombreb2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .0195),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
    ),
  );
}

class CustomDialogLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogV2(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContentLoading(context),
    );
  }
}

dialogContentLoading(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * .03,
            bottom: MediaQuery.of(context).size.height * .03,
            left: MediaQuery.of(context).size.width * .07,
            right: MediaQuery.of(context).size.width * .07),
        margin: EdgeInsets.only(top: 66),
        decoration: new BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Container(
              color: Colors.transparent,
              child: SpinKitFadingCircle(
                color: Color(0xff1ba6d2),
                size: 90.0,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Espere...",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .0195,
                  color: Colors.white),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ],
        ),
      ),
    ],
  );
}
