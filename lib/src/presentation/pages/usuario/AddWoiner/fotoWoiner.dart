import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';


import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:woin/src/helpers/DatosSesion/UserDetalle.dart';

class WoinerPicture extends StatefulWidget {
  final String img;

  WoinerPicture({this.img});

  @override
  _WoinerPictureState createState() => _WoinerPictureState();
}

class _WoinerPictureState extends State<WoinerPicture> {
  userdetalle sesion = new userdetalle();
  File imf;

  _openGallery(BuildContext context) async {
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);
    //setState(() {
    //  imf = img;
    //  List<int> imageBytes = img.readAsBytesSync();
    //  //widget.img = base64Encode(imageBytes);
    //});
    //Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var img = await ImagePicker.pickImage(source: ImageSource.camera);
    //setState(() {
    //  imf = img;
    //  List<int> imageBytes = img.readAsBytesSync();
    //  //widget.img = base64Encode(imageBytes);
    //  // print("IMAGEN 1" + imagen);
    //});
    // Navigator.of(context).pop();
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "Photo",
      child: Scaffold(
        appBar: _appBar(context),
        backgroundColor: Colors.grey[300],
        body: _body(context),
      ),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
          horizontal: ResponsiveFlutter.of(context).wp(2),
          vertical: ResponsiveFlutter.of(context).hp(1.5)),
          child: Container(
            height: 85.0.h,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:2.0.h ),
                  Text(
                    "Seleccione una foto para mostrar",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize:14.0.sp
                    ),
                  ),
                  SizedBox(height:3.0.h ),
                  _avatarCircle(),
                  Expanded(child:Container())
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Center _avatarCircle() {
    return Center(
      child: GestureDetector(
        onTap: () {
          // showBotomModal();
        },
        child: Container(
          width: 45.0.w,
          height: 45.0.w,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  width: 45.0.w,
                  height: 45.0.w,
                  child: CircleAvatar(
                    backgroundImage:   NetworkImage(widget.img),
                    radius:20.0.sp,
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(
        "Foto",
        style: TextStyle(color: Color(0xff1ba6d2)),
      ),
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.dashboard,
            size: 30,
            color: Colors.grey[400],
          ),
          alignment: Alignment.centerRight,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
      leading: IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(
          Icons.chevron_left,
          size: 35,
          color: Colors.grey[400],
        ),
        alignment: Alignment.centerLeft,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
