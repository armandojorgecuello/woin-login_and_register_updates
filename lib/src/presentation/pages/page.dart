import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageHome extends StatelessWidget {
  const PageHome({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: <Widget>[
            Center(
              child: Tooltip(                
                message: 'esto es una página',
                child: Text('Pagína'),
              ),
            ),
            SizedBox(height: 50.0,),
            RaisedButton(
              onPressed: (){
                print('hola');
              },
              child: Text('boton'),
            ),
            SizedBox(
              height: 50.0,
            ),
            TooltipTheme(
              data: TooltipThemeData(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.9),
                  borderRadius: BorderRadius.zero,
                ),
              ),
              child: Tooltip(
                height: 40.0,
                verticalOffset: 30.0,
                message: 'Hola',
                showDuration: Duration(seconds: 5),
                preferBelow: true,
                child: IconButton(
                  iconSize: 36.0,
                  icon: Icon(Icons.touch_app),
                  onPressed: () {},
                ),
              ),
            )
          ],
        )
      ),
      appBar: AppBar(
        title: Text('Pagína')
      ),
    );
  }
}