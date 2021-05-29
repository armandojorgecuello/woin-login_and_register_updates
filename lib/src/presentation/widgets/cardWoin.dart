import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 6, size.height / 6);
    var firstdEndPoint = Offset(size.width / 2, size.height /5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 3.25);
    var secondEndPoint = Offset(size.width, size.height/1.5);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 70);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
class BottomGreyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 0.0);
    var firstControlPoint = Offset(size.width / 6, size.height / 6);
    var firstdEndPoint = Offset(size.width / 2.5, size.height /4.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstdEndPoint.dx, firstdEndPoint.dy);

    var secondControlPoint = Offset(size.width, size.height / 3.38);
    var secondEndPoint = Offset(size.width, size.height / 1.35);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardWoin extends StatefulWidget {
  final Container body;
  CardWoin({Key key, @required this.body}) : super(key: key);
  @override
  _CardWoinState createState() => _CardWoinState();
}

class _CardWoinState extends State<CardWoin> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget tarjeta(int index){
      return Container(
        height: size.height * 1,
        width: size.width *1,
        child: Stack(
              children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.46,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(235, 237, 242, 1),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  clipper: BottomGreyClipper(),
                ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ClipPath(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      gradient: index == 0?
                        LinearGradient(
                          colors: [Color.fromRGBO(0, 255, 229, 1), Color.fromRGBO(13, 183, 203, 1), Color.fromRGBO(0, 117, 177, 1)],
                          stops: [0.01,0.15,0.5],
                          begin: FractionalOffset.topRight,
                          end: FractionalOffset.bottomLeft
                        ):
                        LinearGradient(
                          colors: [Color.fromRGBO(255, 238, 0, 1),Color.fromRGBO(194, 159, 0, 1),  Color.fromRGBO(128, 73, 0, 1)],
                          stops: [0.08,0.22, 0.8],
                          begin: FractionalOffset.topRight,
                          end: FractionalOffset.bottomLeft
                        ),
                      // color: index == 0?Colors.blue[700]:Colors.amber[500],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
                    ),
                  ),
                  clipper: BottomWaveClipper(),
                ),
            ),
            Positioned(
              right: 10.0,
              top: 5.0,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                decoration: BoxDecoration(
                  gradient: index == 0? LinearGradient(
                    colors: [Color.fromRGBO(0, 255, 229, 1), Color.fromRGBO(13, 183, 203, 1), Color.fromRGBO(0, 117, 177, 1)],
                    stops: [0.2,0.55,0.8],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft
                  ):LinearGradient(
                    colors: [Color.fromRGBO(255, 238, 0, 1),Color.fromRGBO(194, 159, 0, 1),  Color.fromRGBO(128, 73, 0, 1)],
                    stops: [0.08,0.6, 0.9],
                    begin: FractionalOffset.topRight,
                    end: FractionalOffset.bottomLeft
                  ),
                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(50.0)
                ),
                child: Center(child: Text('W', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,))),
              ),
            ),
            Container(
              height: size.height * 1,
              // width: size.width * 4,
              padding: EdgeInsets.all(size.height * 0.02),
              child: FittedBox(
                fit: BoxFit.fill,
                child: widget.body,
              ),
            )
            // Container(
            //     padding: EdgeInsets.all(10.0),
            //     alignment: Alignment.centerLeft,
            //     width: MediaQuery.of(context).size.width * 0.9,
            //     height: MediaQuery.of(context).size.height * 0.12,
            //     child: FittedBox(
            //       fit: BoxFit.fill,
            //       child:Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.max,
            //         children: <Widget>[
            //           Text( index==0?'Cli':'Em', style: TextStyle( fontWeight: FontWeight.bold)),
            //           SizedBox(height: 5.0),
            //           Text('Points', style: TextStyle(fontSize: 16.0),),
            //           SizedBox(height: 5.0),
            //           Text('105.000.000.000.000.000.000.000,00', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            //         ],
            //       ),
            //     )
            //   ),
            // SizedBox(height: 50.0,),
          ],
          // ),
        )
      );
    }
    Widget swiperTypeWoiner(){
      return Container(
        height: MediaQuery.of(context).size.height * 1,
        margin: EdgeInsets.only(left: size.width * 0.02),
        child: Swiper(
          
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4.0,
              child: tarjeta(index)
            );
          },
          onTap: (int i){
            
          },
          index: 1,
          itemCount: 2,
          // itemHeight: MediaQuery.of(context).size.height * 0.2,
          itemWidth: MediaQuery.of(context).size.width * 0.9,
          layout: SwiperLayout.STACK,
        ),
      );
    }
    return swiperTypeWoiner();
  }
}