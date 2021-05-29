import 'dart:async';

import 'package:flutter/material.dart';
import 'package:woin/src/presentation/pages/splashScreen/list_screen.dart';
import 'package:woin/src/presentation/pages/usuario/Login.dart';
import 'package:woin/src/services/serviceSplash/ServiceSplash.dart';
import './slide_dots.dart';
import 'package:sizer/sizer.dart';


class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  int _currentPage = 0;
  final PageController _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: 100.0.h,
          width: 100.0.w,
          child: Stack(
            //alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  ScreenPage(
                    assetImage: "",
                    title: "Woin",
                    text: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Directorio, red social, marketing y publicidad para el ",
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]),
                        children: <TextSpan>[
                          TextSpan(
                            text: "intercambio comercial.",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.black) 
                          )
                        ]
                      )
                    ),
                  ),
                  ScreenPage(
                    assetImage: "",
                    title: "Cliwoin",
                    text: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Clientes que desean comprar y ",
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]),
                        children: <TextSpan>[
                          TextSpan(
                            text: "ganar puntos ",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.black) 
                          ),
                          TextSpan(
                            text: "para adquirir bienes, productos o servicios.",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]) 
                          )
                        ]
                      )
                    ),
                  ),
                  ScreenPage(
                    assetImage: "",
                    title: "Emwoin",
                    text: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Empresas que buscan visibilidad para incrementar sus ",
                        style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]),
                        children: <TextSpan>[
                          TextSpan(
                            text: "ventas ",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.black) 
                          ),
                          TextSpan(
                            text: "y ",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]) 
                          ),
                          TextSpan(
                            text: "fidelizar ",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.black) 
                          ),
                          TextSpan(
                            text: "clientes.",
                            style: TextStyle(fontSize: 12.0.sp, color: Colors.grey[400]) 
                          ),
                        ]
                      )
                    ),
                  ),
                ],
                //itemCount: listScreen.length,
                //itemBuilder: (context, index) => ScreenPage(screenData: listScreen[index])
              ),
              Positioned(
                bottom: 20.0.h,
                left:35.0.w,
                right: 35.0.w,
                child: Container(
                  width: 30.0.w,
                  //margin: EdgeInsets.only(bottom: 55),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < listScreen.length; i++)
                        if (i == _currentPage)
                          SlideDots(isActive: true)
                        else
                          SlideDots(isActive: false)
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 5.0.h,
                left:35.0.w,
                right: 35.0.w,
                child: Container(
                  width: 25.0.w,
                  child: FlatButton(
                    color: Color(0xff1ba6d2),
                    onPressed: () async{
                      TableSqlite tbls= TableSqlite();
                      tbls.open();
                      SplashProviderDB dbsplash= SplashProviderDB();
                      SplashSQLite sp=SplashSQLite(username: "THIS CEL",view:1);
                      await dbsplash.insert(sp);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=>Login()
                        )
                      );
                    },
                    shape: StadiumBorder(side: BorderSide(color: Color(0xff1ba6d2), width: 1.0)),
                    child: Text('Omitir', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class ScreenPage extends StatelessWidget {
  final Widget text;
  final String title;
  final String assetImage;

  const ScreenPage({Key key, @required this.text, @required this.title, @required this.assetImage}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 3.0.w),
              //child: Image.asset('assets/img/btnWmin.png'),
            ),

          ],
        ),
        //TODO:Aqui va la imagen asset de el splashscreen.
        //Image.asset(screenData.urlImg),
        SizedBox(height: 60.0.h),
        Text(
          title,
          style: TextStyle(fontSize: 20.0.sp, color: Color(0xff1ba6d2), fontWeight: FontWeight.bold)
        ),
        Container(
          padding: EdgeInsets.symmetric( horizontal: 3.0.w, vertical: 3.0.w),
          child: text 
          //Text(
          //  screenData.texto,
          //  style: TextStyle(color: Colors.grey[400])
          //)
        ),
        SizedBox(height: 3.0.w)
      ],
    );
  }
}
