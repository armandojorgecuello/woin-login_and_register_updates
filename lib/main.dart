import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:woin/src/presentation/pages/splashScreen/start_page.dart';

import 'package:woin/src/presentation/pages/usuario/Login.dart';

import 'package:flutter/material.dart';
import 'package:woin/src/services/serviceSplash/ServiceSplash.dart';

import 'src/presentation/pages/tab-principal/home_page.dart';
import 'src/providers/current_account_provider.dart';
import 'src/providers/login_provider.dart';
import 'src/services/serviceSplash/ServiceSplash.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context,orientation,deviceType ){
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<LoginProvider>(
              create: (context) => LoginProvider()
            ),
            ChangeNotifierProvider<CurrentAccount>(
              create: (context) => CurrentAccount()
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0,
                brightness: Brightness.light
              ),
              brightness: Brightness.light,
              accentColor: Color(0xff1ba6d2),
            ),
            debugShowCheckedModeBanner: false,
            title: "Woin SAS",
            home: Scaffold(
              body: FirstPage()
            ),
          )
        );
      }
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    final bool _isLogin = Provider.of<LoginProvider>(context).isLogin ?? false;
    return Scaffold(
      body: _isLogin == true ? HomePage() : LoginOrSplash()
    );
  }
}


class LoginOrSplash extends StatefulWidget {
  LoginOrSplash({Key key}) : super(key: key);

  @override
  _LoginOrSplashState createState() => _LoginOrSplashState();
}



class _LoginOrSplashState extends State<LoginOrSplash> {
  SplashProviderDB _db;
  @override
  void initState() {
    super.initState();
    _db = SplashProviderDB();
  }

  Future<int> isViewSplash() async{
    SplashSQLite view = await _db.getViewSplash();
    if (view!= null) {
      return 1;
    }else{
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
         future: isViewSplash(),
         builder: (BuildContext context,AsyncSnapshot<int> snapshot){
          return snapshot.hasData ? snapshot.data == 1 ? Login() : StartPage() : WoinLoading();
        },
      ),
    );
  }
}