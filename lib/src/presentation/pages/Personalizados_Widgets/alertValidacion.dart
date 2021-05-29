import 'package:flutter/material.dart';
import 'package:woin/src/presentation/pages/Personalizados_Widgets/Dialogv2.dart';

class alertValidation extends StatelessWidget {
  String msj;
  alertValidation(this.msj);

  @override
  Widget build(BuildContext context) {
    return DialogV2(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        padding: EdgeInsets.all(0),
        height: MediaQuery.of(context).size.height * .25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Validación",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        )),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[700]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * .2 * .1,
                    vertical: MediaQuery.of(context).size.height * .2 * .2),
                child: Text(
                  msj,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                color: Colors.grey[200],
                padding: EdgeInsets.all(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
