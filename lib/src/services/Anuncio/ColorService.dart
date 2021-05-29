

import 'dart:async';

import 'package:find_dropdown/rxdart/behavior_subject.dart';
import 'package:flutter/material.dart';
import 'package:woin/src/entities/anuncio/Colors.dart';

class ColorService{
  //LIST GENERAL// PALETA
  List<ColorsD> colores;
  //STREAM COLORES PALETA
  BehaviorSubject<List<ColorsD>> _lcolores;


  //EVENTS
  StreamController<ColorsD> _selectedColor;
  StreamController<int> _unselectedColor;
  StreamController<List<ColorsD>> _ColorsSelected;


  //GETTER Y SETTER
  Stream get listaColores=>_lcolores.stream;
  StreamSink get listaColoresSink=>_lcolores.sink;
  StreamSink get selectionColors=>_selectedColor.sink;
  StreamSink get unselecteColors=>_unselectedColor.sink;
  StreamSink get colorsSelected=>_ColorsSelected.sink;




  ColorService(){
    colores=List();
    _lcolores=BehaviorSubject<List<ColorsD>>();
    _selectedColor=StreamController<ColorsD>();
    _unselectedColor=StreamController<int>();
    _ColorsSelected=StreamController<List<ColorsD>>();
    _selectedColor.stream.listen(seleccionarColor);
    _unselectedColor.stream.listen(deseleccionarColores);
    _ColorsSelected.stream.listen(seleccionarColores);
    crearPaleta();
  }

  seleccionarColor(ColorsD color){
    deseleccionarColores(1);
    for(ColorsD c in colores){
      if(c.codigo==color.codigo){
        c.selected=c.selected==0?c.selected=1:c.selected=0;
      }
    }
    listaColoresSink.add(colores);
  }

  seleccionarColores(List<ColorsD>lc){
    deseleccionarColores(1);
    for(ColorsD cl in lc) {
      for (ColorsD c in colores) {
        if (c.codigo == cl.codigo) {
          c.selected=1;
        }
      }
    }
    listaColoresSink.add(colores);
  }

  deseleccionarColores(int i){
    for(ColorsD c in colores){
      c.selected=0;
    }
   // listaColoresSink.add(colores);
  }


  void crearPaleta(){
    ColorsD c= ColorsD(color: Colors.red,codigo: 1,name: "Red",nombre: "Rojo");
    ColorsD c1= ColorsD(color: Colors.grey,codigo: 2,name: "Grey",nombre: "Gris");
    ColorsD c2= ColorsD(color: Colors.white,codigo: 3,name: "White",nombre: "Blanco");
    ColorsD c3= ColorsD(color: Colors.deepPurple,codigo: 4,name: "Purple",nombre: "Morado");
    ColorsD c4= ColorsD(color: Colors.blue,codigo: 5,name: "Blue",nombre: "Azul");
    ColorsD c5= ColorsD(color: Colors.green,codigo: 6,name: "Green",nombre: "Verde");
    ColorsD c6= ColorsD(color: Colors.orange,codigo: 7,name: "Orange",nombre: "Naranja");
    ColorsD c7= ColorsD(color: Colors.lightGreen,codigo: 8,name: "LightGreen",nombre: "Verde claro");
    ColorsD c8= ColorsD(color: Colors.amber,codigo: 9,name: "Amber",nombre: "Amber");
    ColorsD c9= ColorsD(color: Colors.amberAccent,codigo: 10,name: "AmberAccent",nombre: "Amber claro");
    ColorsD c10= ColorsD(color: Colors.black,codigo: 11,name: "Black",nombre: "Negro");
    ColorsD c11= ColorsD(color: Colors.brown,codigo: 12,name: "Brown",nombre: "Marron");
    ColorsD c12= ColorsD(color: Colors.cyan,codigo: 13,name: "Cyan",nombre: "Azul claro");
    ColorsD c13= ColorsD(color: Colors.deepOrange,codigo: 14,name: "DeepOrange",nombre: "Naranja Oscuro");
    ColorsD c14= ColorsD(color: Colors.deepPurpleAccent,codigo: 15,name: "PurpleDeep",nombre: "Morado oscuro");
    ColorsD c15= ColorsD(color: Colors.lightGreenAccent,codigo: 16,name: "Green Accent",nombre: "Verde Accent");
    ColorsD c16= ColorsD(color: Colors.lime,codigo: 17,name: "Lime",nombre: "Lima");
    ColorsD c17= ColorsD(color: Colors.limeAccent,codigo: 18,name: "LimeAccent",nombre: "Lima claro");
    ColorsD c18= ColorsD(color: Colors.pink,codigo: 19,name: "Pink",nombre: "Rosa");
    ColorsD c19= ColorsD(color: Colors.pinkAccent,codigo: 20,name: "PinkAccent",nombre: "Rosa claro");
    ColorsD c20= ColorsD(color: Colors.purpleAccent,codigo: 21,name: "PurpleAccent",nombre: "Morado claro");
    ColorsD c21= ColorsD(color: Colors.redAccent,codigo: 22,name: "RedAccent",nombre: "Rojo claro");
    ColorsD c22= ColorsD(color: Colors.yellow,codigo: 23,name: "Yellow",nombre: "Amarillo");
    ColorsD c23= ColorsD(color: Colors.yellowAccent,codigo: 24,name: "YellowAccent",nombre: "Amarillo claro");
    ColorsD c24= ColorsD(color: Colors.tealAccent,codigo: 25,name: "Teal",nombre: "Azul marino");
    ColorsD c25= ColorsD(color: Colors.grey[100],codigo: 25,name: "GreyAccent",nombre: "Gris Claro");

    colores.add(c);
    colores.add(c1);
    colores.add(c2);
    colores.add(c3);
    colores.add(c4);
    colores.add(c5);
    colores.add(c6);
    colores.add(c7);
    colores.add(c8);
    colores.add(c9);
    colores.add(c10);
    colores.add(c11);
    colores.add(c12);
    colores.add(c13);
    colores.add(c14);
    colores.add(c15);
    colores.add(c16);
    colores.add(c17);
    colores.add(c18);
    colores.add(c19);
    colores.add(c20);
    colores.add(c21);
    colores.add(c22);
    colores.add(c23);
    colores.add(c24);
    colores.add(c25);
    listaColoresSink.add(colores);
  }

}
final  colorService=ColorService();