import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatars {
  String message;
  bool status;
  List<Avatar> entities;

  Avatars({this.message, this.status, this.entities});

  Avatars.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Avatar>();
      json['entities'].forEach((v) {
        entities.add(new Avatar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Avatar {
  int id;
  String name;
  int type;
  String url;
  int state;
  int createdAt;
  int updatedAt;
  IconData icono;
  Color color;

  Avatar(
        this.id,
        this.name,
        this.type,
        this.url,
        this.state,
        this.createdAt,
        this.updatedAt){

  }

  Avatar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    url = json['url'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if(this.id==2){
      this.icono=Icons.unarchive;
      this.color=Colors.red;
    }else if(this.id==1){
      this.icono=Icons.cloud;
      this.color=Colors.blue;
    }else if(this.id==4){

      this.icono=Icons.print;
      this.color=Colors.grey;
      //PRINT
    }else if(this.id==5){
      this.icono=Icons.people;
      this.color=Colors.blueAccent;
      //PEOPLE

    }else if(this.id==6){

      this.icono=Icons.group;
      this.color=Colors.cyan;
      //GROUP
    }else if(this.id==7){

      this.icono=Icons.account_box;
      this.color=Colors.lightGreen;
      //ACOUNT BOX

    }else if(this.id==8){
      this.icono=Icons.assignment_ind;
      this.color=Colors.orange;
      //assigment_ind


    }else if(this.id==10){
      this.icono=Icons.transfer_within_a_station;
      this.color=Colors.deepPurple;
      //transfer_within_a_station
    }else if(this.id==11){

      this.icono=Icons.local_laundry_service;
      this.color=Colors.pink;

      //local_laundry_service

    }else if(this.id==12){

      this.icono=Icons.beach_access;
      this.color=Colors.indigo;
      //beach_access
    }else if(this.id==13){

      this.icono=Icons.camera_roll;
      this.color=Colors.lightGreenAccent;
      //camera_roll

    }else if(this.id==9){
      this.icono=Icons.enhanced_encryption;
      this.color=Colors.teal;
      //enhanced_encryption
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['url'] = this.url;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;

    return data;
  }
}