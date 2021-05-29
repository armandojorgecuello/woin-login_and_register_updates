import 'dart:async';

import 'package:flutter/material.dart';

import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/presentation/pages/splashScreen/splash_screen.dart';


class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  double _scale= 5.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        _scale=1;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;


    double getHeihgt(){
      return ResponsiveFlutter.of(context).wp(32)*_scale;
    }

    double getWidth(){
      return  ResponsiveFlutter.of(context).wp(32)*_scale;
    }

    double getLetter(){
      return ResponsiveFlutter.of(context).verticalScale(45)*_scale;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(
        children:[
          AnimatedPositioned(
            width: getWidth(),
            height: getHeihgt(),
            duration: const Duration(seconds: 5),
            top: ResponsiveFlutter.of(context).hp(100)/2-getHeihgt()/2,
            left: ResponsiveFlutter.of(context).wp(100)/2-getWidth()/2,
            child:Image.asset("assets/images/LOGO_WOIN_DEF.png"),
            onEnd: (){
              irSplash(){}
              Timer(
                Duration(seconds: 5), 
                (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context)=>SplashScreenPage()
                    )
                  );
                }
              );
            },
          ),
          Positioned(
            width: ResponsiveFlutter.of(context).wp(50),
            height: ResponsiveFlutter.of(context).wp(32),
            bottom: ResponsiveFlutter.of(context).hp(2),
            left: ResponsiveFlutter.of(context).wp(100)/2-ResponsiveFlutter.of(context).wp(50)/2,
            child: TweenAnimationBuilder<double>(
              duration: const Duration(seconds: 1),
              tween: Tween(begin: 1,end: 0),
              builder: (context,value,widget){
                return Transform(
                  transform: Matrix4.identity()..translate(-ResponsiveFlutter.of(context).scale(250)*value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Woin",style: TextStyle(color:Color(0xff1ba6d2),fontSize: ResponsiveFlutter.of(context).fontSize(4.2),fontFamily: 'Arial-Rounded' ),),
                      Text("Suma puntos a tu vida",style: TextStyle(color: Colors.grey[500],fontSize: ResponsiveFlutter.of(context).fontSize(1.8),fontWeight: FontWeight.w300),)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
