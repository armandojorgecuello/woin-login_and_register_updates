/*import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Categories/Subcategory.dart';
import 'package:woin/src/presentation/providers/CategoryProvider.dart';
import 'package:woin/src/presentation/widgets/fadeAnimation.dart';
import 'package:woin/src/services/categoryService.dart';

class AdPage extends KFDrawerContent {

  @override
  _AdPageState createState() => _AdPageState();
}

class _AdPageState extends State<AdPage> {
  int selectCategory;
  int subcategorySelected;
  int idCategory;
  int lengthColumn1, lengthColumn2;
  List<Subcategory> subCategoriesSelected = [];
  List<Subcategory> subSubCategoriesSelected = [];
  List<Subcategory> subCategories = [];
  List<Subcategory> subSubCategories = [];
  List<Subcategory> subCategoriesAux = [];
  List<Category> categories;
  String search = '';
  int step = 1;
  @override
  void initState() { 
    this.lengthColumn1 = 0;
    super.initState();
    
  }
  Widget futureCategories(){
    return FutureBuilder<List<Category>>(
      future: categoryService.getAll(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          this.categories = snapshot.data;
          Color textColorSelect;
          Icon icon;
          int id;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(categories.length, (int index){
              switch (categories[index].name.toLowerCase()) {
                case ('productos'):
                  textColorSelect = Colors.indigo;
                  icon = Icon(Icons.shopping_basket, color: textColorSelect,);
                  id = categories[index].id;
                  break;
                case 'servicios':
                  textColorSelect = Colors.blue;
                  icon = Icon(Icons.local_gas_station, color: textColorSelect,);
                  id = categories[index].id;
                  break;
                case 'inmuebles':
                  textColorSelect = Colors.greenAccent;
                  icon = Icon(Icons.location_city, color: textColorSelect,);
                  id = categories[index].id;
                  break;
                case 'vehículos':
                  textColorSelect = Colors.indigo;
                  icon = Icon(Icons.directions_car, color: textColorSelect,);
                  id = categories[index].id;
                  break;
                case 'eventos':
                  textColorSelect = Colors.blue[300];
                  icon = Icon(Icons.cake, color: textColorSelect,);
                  id = categories[index].id;
                  break;
                default:
              }
              // return listCategory(categories[index].name,icon,textColorSelect, index, id);
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectCategory = index;
                        getSubcategories(categories[index].id);
                      });

                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: selectCategory==index?Colors.grey[100] :Colors.grey[300],
                        boxShadow: selectCategory==index?[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ]:null,
                      ),
                      child: icon
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Text(categories[index].name, style: TextStyle(color: selectCategory==index?textColorSelect :Colors.grey[400], fontSize: 12.0)),
                ],
              );
            }),
          );
        } else if(snapshot.hasError){
          return Text('${snapshot.error}');
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }

  Future getSubcategories(int id)async{
    this.subCategories = await categoryService.getSubcategories(categoryId: id);
    setState(() {
      this.subCategoriesAux = this.subCategories;
    });
    if(this.subCategories.length > 1){
      this.lengthColumn1 = int.parse((this.subCategories.length/2).toStringAsPrecision(1));
      this.lengthColumn2 = this.subCategories.length - lengthColumn1;
    }else{
      this.lengthColumn1 = 1;
      this.lengthColumn2 = 0;
    }
  }

  Future getSubSubcategories(int id)async{
    this.subSubCategories = await categoryService.getSubcategories(parentId: id);
    print('subsub ${this.subSubCategories.length}');
    if (this.subSubCategories.length!=0) {
      setState(() {
        if(this.subSubCategories.length > 1){
          this.lengthColumn1 = int.parse((this.subSubCategories.length/2).toStringAsPrecision(1));
          this.lengthColumn2 = this.subSubCategories.length - lengthColumn1;
          print('tamaño Colum1 d ${lengthColumn1}');
          print('tamaño Colum1 d ${lengthColumn2}');
        }else{
          this.lengthColumn1 = 1;
          this.lengthColumn2 = 0;
        }
      });
    }
  }

  Widget listCategory(String categoryName, Icon icon, Color textColor, int index, int categoryId){
    print(categoryId);
    return Column(
      children: <Widget>[
        InkWell(
          onTap: (){
            setState(() {
              selectCategory = index;
              this.idCategory = categoryId;
              getSubcategories(categoryId);
            });

          },
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: selectCategory==index?Colors.grey[100] :Colors.grey[300],
              boxShadow: selectCategory==index?[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ]:null,
            ),
            child: icon
          ),
        ),
        SizedBox(height: 5.0,),
        Text(categoryName, style: TextStyle(color: selectCategory==index?textColor :Colors.grey[400], fontSize: 12.0)),
      ],
    );
  }
  
  Widget selectSubcategory(String subCategoryName, Subcategory subcategory, int index,  List<dynamic> list, int lenthMax){
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (list.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null || list.length<lenthMax)?(){
        setState(() {
          if(list.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null){
            list.removeWhere((t)=>t.id==subcategory.id);
          }else{
            if (list.length < lenthMax+1) {      
              list.add(subcategory);
            }
          }
        });
      }:null,
      child: Card(
        elevation: list.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null?20.0:0.0,
        child: Container(
          width: size.width*1,
          height: size.height*0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: (list.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)==null && list.length>lenthMax+1)?Colors.grey:Colors.white
          ),
          child: Center(
            child: Text(
              subCategoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: list.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null?Colors.blue:Colors.grey,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0),
        ),
      ),
    );
  }

  Widget selectSubSubcategory(String subCategoryName, Subcategory subcategory, int index){
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (subSubCategoriesSelected.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null || subSubCategoriesSelected.length<2)?(){
        setState(() {
          if(subSubCategoriesSelected.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null){
            this.subCategoriesSelected.removeWhere((t)=>t.id==subcategory.id);
          }else{
            if (this.subCategoriesSelected.length < 3) {      
              this.subCategoriesSelected.add(subcategory);
            }
          }
        });
      }:null,
      child: Card(
        elevation: subCategoriesSelected.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null?20.0:0.0,
        child: Container(
          width: size.width*1,
          height: size.height*0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: (subCategoriesSelected.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)==null && subCategoriesSelected.length>3)?Colors.grey:Colors.white
          ),
          child: Center(
            child: Text(
              subCategoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subCategoriesSelected.firstWhere((t)=>t.id==subcategory.id, orElse:()=> null)!=null?Colors.blue:Colors.grey,
                fontWeight: FontWeight.bold
              ),
            )
          ),
          margin: EdgeInsets.only(left: 10.0, top: 10.0, right: 5.0),
        ),
      ),
    );
  }
  
  
  Widget step1(){
    if (this.subCategories.length != 0) {
        if(this.subCategories.length > 1){
        this.lengthColumn1 = int.parse((this.subCategories.length/2).toStringAsPrecision(1));
        this.lengthColumn2 = this.subCategories.length - lengthColumn1;
      }else{
        this.lengthColumn1 = 1;
        this.lengthColumn2 = 0;
      }
    }
    return this.subCategories.length==0?Container(child: Center(child: Text('Seleccionar la subcategoria'),),):  Row(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: List.generate(this.lengthColumn1, (int index){
              return selectSubcategory(this.subCategories[index].name, this.subCategories[index], index, this.subCategoriesSelected, 2);
            }),
          ),
        ),
        Expanded(
          child: ListView(
            children: List.generate(this.lengthColumn2, (int index){
              return selectSubcategory(this.subCategories[index+lengthColumn1].name, this.subCategories[index+lengthColumn1],index+lengthColumn1, this.subCategoriesSelected, 2);
            }),
          ),
        ),
      ],
    );
  }
  Widget step2(){
    
    if (this.subcategorySelected != null) {
      this.lengthColumn1 = int.parse((this.subSubCategories.length/2).toStringAsPrecision(1));
      this.lengthColumn2 = this.subSubCategories.length - lengthColumn1;
    }else{
      this.lengthColumn1 = 0;
      this.lengthColumn2 = 0;
    }
    if (this.subCategoriesSelected.length<2) {
      getSubSubcategories(this.subCategoriesSelected[0].id);
    }
    return this.subSubCategories.length==0?Container(child: Center(child: Text('Seleccionar la subcategoria'),),): Row(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: List.generate(lengthColumn1, (int index){
              return selectSubcategory(this.subSubCategories[index].name, this.subSubCategories[index], index, this.subSubCategoriesSelected, 4);
            }),
          ),
        ),
        Expanded(
          child: ListView(
            children: List.generate(lengthColumn2, (int index){
              return selectSubcategory(this.subSubCategories[index+lengthColumn1].name, this.subSubCategories[index+lengthColumn1], index, this.subSubCategoriesSelected, 4);
            }),
          ),
        ),
      ],
    );
  }
  
  Widget step3(){
    return Container();
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    Widget steps(){
      Widget page;
      switch (this.step) {
        case 1:
          page = step1();
          break;
        case 2:
          categoryProvider.changeSubcategories(this.subCategoriesSelected);
          page = step2();
          break;
        case 3:
          categoryProvider.changeSubSubcategories(this.subSubCategoriesSelected);
          page = step3();
          break;
        default: page = Container();
      }
      return page;
    }
    
    Widget textSearch = Container(
      padding: EdgeInsets.only(left: 3.0),
      width: size.width * 1, // 0.77 en true // 1 en false
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey
        )
      ),
      child: TextField(
        onChanged: (text){
          setState(() {
            if (text == '' || text.isEmpty) {
              // this.subCategories = this.subCategoriesAux;
            }else{
              // this.search = text;
              this.subCategories = this.subCategoriesAux.where((subCat){
                return subCat.name.toLowerCase().indexOf(text)>-1;
              }).toList();
              
              if (this.subCategories.length>0) {
                this.lengthColumn1 = int.parse((this.subCategories.length/2).toStringAsPrecision(1));
                this.lengthColumn2 = this.subCategories.length - lengthColumn1;
              }
            }
          });
        },
        // controller: _searchText,
        onSubmitted: (String t){
          Navigator.pop(context);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, size: 16.0,),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(bottom: 1.0),
            icon: Icon(Icons.cancel, color: Colors.grey[700], size: 16.0,),
            onPressed: () {
              // setState(() {
              //   _searchText.clear();
              // });
            },
          ),
          hintText: 'Buscar subcategoría',
          hintStyle: TextStyle(fontSize: 15.0),
          // contentPadding: EdgeInsets.only(left: -13, top: -10.0),
        ),
      ),
    );
    Widget duration(){
      Widget wid = Container();
      var time = new Timer(const Duration(milliseconds: 20), ()=>wid = textSearch);
      print(wid);
      return wid;
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(0.0),
              elevation: 10.0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(top: size.height *0.08),
                padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                height: this.step>1?size.height*0.23:size.height *0.16, 
                width: size.width*1,
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: size.width*1,
                      child: futureCategories()
                    ),
                    SizedBox(height: size.width*0.01,),
                    this.step<2?Container():Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: this.step==3?null: (){
                                  setState(() {
                                    getSubSubcategories(this.subCategoriesSelected[0].id);
                                    this.subcategorySelected = 0;
                                  });
                                },
                                child: Card(
                                  elevation: this.subcategorySelected==0 || this.step==3?10.0:0.0,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        this.subCategoriesSelected[0].name,
                                        style: TextStyle(color: this.subcategorySelected==0 || this.step==3?Colors.blue: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      border: this.subcategorySelected==0 || this.step==3?null:Border.all(
                                        color: Colors.grey
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              this.step!=3?Container():Row(
                                children: List.generate(this.subSubCategoriesSelected.where((test)=>test.parentId == this.subCategoriesSelected[0].id).toList().length,(int index){
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text( this.subSubCategoriesSelected.where((test)=>test.parentId == this.subCategoriesSelected[0].id).toList()[index].name, style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                                    )
                                  );
                                })
                              )
                            ],
                          ),
                        ),
                        this.subCategoriesSelected.length<2?Container():SizedBox(width: 10.0,),
                        this.subCategoriesSelected.length<2?Container():Expanded(
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: this.step==3?null: (){
                                  setState(() {
                                    getSubSubcategories(this.subCategoriesSelected[1].id);
                                    this.subcategorySelected = 1;
                                  });
                                },
                                child: Card(
                                  elevation: this.subcategorySelected==1 || this.step==3?10.0:0.0,
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        this.subCategoriesSelected[1].name,
                                        style: TextStyle(color: this.subcategorySelected==1 || this.step==3?Colors.blue: Colors.grey, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      border: this.subcategorySelected==1 || this.step==3?null:Border.all(
                                        color: Colors.grey
                                      )
                                    ),
                                  ),
                                ),
                              ),
                              this.step!=3?Container():Row(
                                children: List.generate(this.subSubCategoriesSelected.where((test)=>test.parentId == this.subCategoriesSelected[1].id).toList().length,(int index){
                                  return Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text( this.subSubCategoriesSelected.where((test)=>test.parentId == this.subCategoriesSelected[1].id).toList()[index].name, style: TextStyle(color: Colors.grey), textAlign: TextAlign.center,),
                                    )
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0,),
                    this.step>2?Container():FadeAnimation(1,textSearch),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: this.step==2?size.height*0.32:size.height*0.26),
              height: size.height*1,
              width: size.width*1,
              // color: Colors.green,
              child: this.subCategoriesAux.length==0?Container(child: Center(child: Text('No hay subcategoría Seleccioná una categoría')),):Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: steps()
            ),
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: AppBar(
                title: Text('Subir anuncio', style: TextStyle(color: Colors.blue)),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(Icons.menu, color: Theme.of(context).primaryColor,),
                      onPressed: widget.onMenuPressed,
                    );
                  },
                ),
              )
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.height*0.025),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  child: Text('< Atras'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Colors.grey
                    )
                  ),
                  onPressed: this.step==1?null: (){
                    setState(() {
                      this.step--;
                      // this.subSubCategories = [];
                      // this.lengthColumn1 = int.parse((this.subCategories.length/2).toStringAsPrecision(1));
                      // this.lengthColumn2 = this.subCategories.length-this.lengthColumn1;
                      // print(this.lengthColumn1);
                    });
                  }
                )
              ),
              SizedBox(width: 10.0,),
              Expanded(
                child: MaterialButton(
                  child: Text('Siguiente >'),
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  onPressed: (this.subCategoriesSelected.length==0 || this.subSubCategoriesSelected.length == 0)?null: (){
                  // aquí utilizas el metodo
                  //onPressed: (this.subCategoriesSelected.length==0 || validateSubSubcategoriesSelected())?null:(){}
                    setState(() {
                      this.step++;
                    });
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  bool validateSubSubcategoriesSelected(){
    // si hay dos SubCategoriesSelected, en la lista SubSubCategoriesSelected debe tener por lo menos un elemto de las subcategorias
    // para avanzar al siguiente paso ya que si no, se ve raro el diseño y también si selecciono dos subcategory debe utilizarla
    // suerte es sencillo creo jajajaja.
  }
}*/
