/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:woin/src/presentation/providers/keyboardProvider.dart';
import 'package:woin/src/presentation/widgets/pin.dart';

class Keyboard extends StatefulWidget {
  Keyboard({Key key}) : super(key: key);

  @override
  _KeyboardState createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  bool _isAuthenticating = false;
  @override
  void initState() { 
    
    super.initState();
    _checkBiometrics();
  }
  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      // if (keyboardProvider.huella) {
      //   switch (widget.page) {
      //       case 'transfers':
      //         sendTransaction();
      //         break;
      //       default:
      //     }
      // }
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    Future<void> _authenticate() async {
    bool authenticated = false;
    const authMessage = const AndroidAuthMessages(
      cancelButton: "cancelar",
      goToSettingsButton: "ajustes",
      signInTitle: "Autenticarse",
      fingerprintHint: "toque el sensor",
      fingerprintNotRecognized: "Huella es reconocida",
      fingerprintRequiredTitle: "Huella reconocida",
      goToSettingsDescription: "Por favor configure su huella"
    );
    try {     
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Escanea tu huella para autenticarte',
        useErrorDialogs: true,
        stickyAuth: false,
        androidAuthStrings: authMessage
      );
      setState(() {
        _isAuthenticating = authenticated;
        keyboardProvider.changeHuella(authenticated);
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
  }
  Widget buttonNumbers(Widget keyboardOpt, String number){
    int numberInt = int.parse(number);
    return InkWell(
      splashColor: Colors.blue,
      borderRadius: BorderRadius.circular(50.0),
      onTap: (){
        if (numberInt == -1) {
          _authenticate();
        }
        numberInt >= 0 && numberInt < 10?keyboardProvider.getNumbers(number):keyboardProvider.clearNumber();
      },
      child: Container(       
        
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        child: FittedBox(
          child: keyboardOpt,
        )
      ),
    );
  }
  Widget listButtons(List<int> buttons){
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(buttons.length, (int i){
          if (buttons[i] < 0) {
            return buttonNumbers(_canCheckBiometrics?Icon(Icons.fingerprint, color: Colors.grey,):Text(''), '-1');
          } else {
            return buttonNumbers(
              (buttons[i]<10?Text(buttons[i].toString(), style: TextStyle(color: Colors.grey),) : Icon(Icons.backspace,color: Colors.grey,)), buttons[i].toString()
            );
          }
        }),
      )
    );

  }

  Widget keyboard() {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      // child: FittedBox(
        // fit: BoxFit.cover,
              child: Column(
          children: <Widget>[
            listButtons([1,2,3]),
            listButtons([4,5,6]),
            listButtons([7,8,9]),
            listButtons([-1,0,10]),
          ],
        // ),
      ),
    );
  }
    return keyboard();
  }
}*/
