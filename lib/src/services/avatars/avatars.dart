

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class avatar{
  String nombre;
  IconData icono;
  Color color;

  avatar(this.nombre,this.icono,this.color);
}


class Avatars{

  List<avatar> listAvatars;

  Avatars(){
    listAvatars=new List();
    _cargarAvatars();
  }

  _cargarAvatars(){
    avatar a= new avatar("Cloud",Icons.cloud,Colors.blue);
    avatar a1= new avatar("Unarchive",Icons.unarchive,Colors.red);
    avatar a2= new avatar("Print",Icons.print,Colors.grey);
    avatar a3= new avatar("People",Icons.people,Colors.blueAccent);
    avatar a4= new avatar("Group",Icons.group,Colors.cyan);
    avatar a5= new avatar("User Box",Icons.account_box,Colors.lightGreen);
    avatar a6= new avatar("User Ind",Icons.assignment_ind,Colors.orange);
    avatar a7= new avatar("Encription",Icons.enhanced_encryption,Colors.teal);
    avatar a8= new avatar("User Transfer",Icons.transfer_within_a_station,Colors.deepPurple);
    avatar a9= new avatar("Local Service",Icons.local_laundry_service,Colors.pink);
    avatar a10= new avatar("Beach Access",Icons.beach_access,Colors.indigo);
    avatar a11= new avatar("Camera Rol",Icons.camera_roll,Colors.lightGreenAccent);
    listAvatars.add(a);
    listAvatars.add(a1);
    listAvatars.add(a2);
    listAvatars.add(a3);
    listAvatars.add(a4);
    listAvatars.add(a5);
    listAvatars.add(a6);
    listAvatars.add(a7);
    listAvatars.add(a8);
    listAvatars.add(a9);
    listAvatars.add(a10);
    listAvatars.add(a11);
  }

  List<avatar> obtenerAvatars(){
    return this.listAvatars;
  }

}