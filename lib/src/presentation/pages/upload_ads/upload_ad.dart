//Entities
import 'dart:math';

import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Categories/Subcategory.dart';

import 'package:woin/src/entities/Countries/Country.dart';

//Providers
import 'package:woin/src/presentation/providers/upload_ad_provider.dart';
//Widgets
import 'package:woin/src/presentation/widgets/searchDropdown.dart';
// Services
import 'package:woin/src/services/categoryService.dart';
import 'package:woin/src/services/Scope/countryService.dart';
import 'package:woin/src/services/Scope/countryService.dart';

// Libraries
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*class UploadAd extends StatefulWidget {
  @override
  _UploadAdState createState() => _UploadAdState();
}

class _UploadAdState extends State<UploadAd> {
  RangeValues _ageRange = RangeValues(18.0, 100.0);
  UploadAdProvider adInfo;

  // List of resources
  List<Subcategory> subcategories;
 // List<Country> countries;
  // List<Governorate> governorates;
  //List<City> cities;

  void fillSubcategories(int id) async {
    var mysubcategories = await categoryService.all(id) ?? [];
    setState((){
      subcategories = mysubcategories;
    });
  }

/*  void fillCountries() async {
    var mycountries = await countryService.all() ?? [];
    setState(() {
      countries = mycountries;
    });
  }

  void fillGovernorates(int id) async {
    var myGovernorates = await governorateService.ofCountry(id) ?? [];
    setState(() {
      governorates = myGovernorates;
    });
  }

  @override
  void initState() {
    fillCountries();
    super.initState();
  }

  void fillCities(int id) async {
    var mycities = await cityService.ofGovernorate(id) ?? [];
    setState(() {
      cities = mycities;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    adInfo = Provider.of<UploadAdProvider>(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width * 1,
                child: FutureBuilder(
                  future: categoryService.getAll(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Category> categories = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: GestureDetector(
                              child: Text(
                                categories[index].name,
                                style: adInfo.ad.categoryId == categories[index].id ? TextStyle(color: Colors.blue, fontSize: 12.0) : TextStyle(color: Colors.black, fontSize: 12.0),
                              ),
                              onTap: () {
                                setState(() {
                                  if (adInfo.ad.categoryId != categories[index].id) {
                                    adInfo.ad.categoryId = categories[index].id;
                                    adInfo.ad.subcategoryId = 0;
                                    adInfo.ad.subcategory = null;
                                    adInfo.ad.secondSubcategoryId = 0;
                                    adInfo.ad.secondSubcategory = null;
                                    fillSubcategories(categories[index].id);
                                  }
                                });
                              },
                            ), 
                            margin: EdgeInsets.only(right: 20.0),
                          );
                        }
                      );
                    }
                    return Center(child: Text("No se econtraron categorías para seleccionar"));
                  },
                ),
              ),
              SearchDropdown<Subcategory>(
                entity: adInfo.ad.subcategory,
                items: subcategories,
                searchBoxDecoration: InputDecoration(
                  labelText: "Subcategoría"
                ),
                onChanged: (value) {
                  setState(() {
                    adInfo.ad.subcategory = value;
                    adInfo.ad.subcategoryId = value.id;
                  });
                },
                other: adInfo.ad.secondSubcategory,
              ),
              SearchDropdown<Subcategory>(
                entity: adInfo.ad.secondSubcategory,
                items: subcategories,
                searchBoxDecoration: InputDecoration(
                  labelText: "Subcategoría 2 (Opcional)"
                ), 
                onChanged: (value) {
                  setState(() {
                    adInfo.ad.secondSubcategory = value;
                    adInfo.ad.secondSubcategoryId = value.id;
                  });
                },
                other: adInfo.ad.subcategory,
              ),
              SearchDropdown<Country>(
                entity: adInfo.ad.scope.country,
                items: countries,
                searchBoxDecoration: InputDecoration(
                  labelText: "País"
                ),
                onChanged: (value) {
                  setState((){
                    if (adInfo.ad.scope.countryId != value.id) {
                      adInfo.ad.scope.country = value;
                      adInfo.ad.scope.countryId = value.id;
                      adInfo.ad.scope.governorate = null;
                      adInfo.ad.scope.governorateId = 0;
                      adInfo.ad.scope.city = null;
                      adInfo.ad.scope.cityId= 0;
                      fillGovernorates(value.id);
                    }
                  });
                },
              ),
              SearchDropdown<Governorate>(
                entity: adInfo.ad.scope.governorate,
                items: governorates,
                searchBoxDecoration: InputDecoration(
                  labelText: "Departamento"
                ),
                onChanged: (value) {
                  setState((){
                    if (adInfo.ad.scope.governorateId != value.id) {
                      adInfo.ad.scope.governorate = value;
                      adInfo.ad.scope.governorateId = value.id;
                      adInfo.ad.scope.city = null;
                      adInfo.ad.scope.cityId = 0;
                      fillCities(value.id);
                    }
                  });
                },
              ),
              SearchDropdown<City>(
                entity: adInfo.ad.scope.city,
                items: cities,
                searchBoxDecoration: InputDecoration(
                  labelText: "Ciudad"
                ),
                onChanged: (value) {
                  setState((){
                    adInfo.ad.scope.city = value;
                    adInfo.ad.scope.cityId = value.id;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(child: borderedItem(Text("Hombre"), fill: toogleColorGender(0), radius: 7.0,), onTap: () {
                        setState(() {
                          adInfo.ad.genderWoiner += toogleN(adInfo.ad.genderWoiner, 0);
                        });
                      }),
                      GestureDetector(child: borderedItem(Text("Mujer"), fill: toogleColorGender(1), radius: 7.0), onTap:() {
                        setState(() {
                          adInfo.ad.genderWoiner += toogleN(adInfo.ad.genderWoiner, 1);
                        });
                      }),
                      GestureDetector(child: borderedItem(Text("Niño"), fill: toogleColorGender(2), radius: 7.0), onTap:() {
                        setState(() {
                          adInfo.ad.genderWoiner += toogleN(adInfo.ad.genderWoiner, 2);
                        });
                      }),
                      GestureDetector(child: borderedItem(Text("Niña"), fill: toogleColorGender(3), radius: 7.0), onTap:() {
                        setState(() {
                          adInfo.ad.genderWoiner += toogleN(adInfo.ad.genderWoiner, 3);
                        });
                      }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.0,),
              Column(
                children: <Widget>[
                  Text("Edad (Opcional)"),
                  SizedBox(height: 5.0,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.blue.withOpacity(0.8),
                        inactiveTrackColor: Colors.grey,
                        trackHeight: 2.0,
                        valueIndicatorColor: Colors.grey,
                        disabledThumbColor: Color.fromRGBO(107, 107, 107, 1),
                        thumbColor: Colors.blue,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0),
                        overlayColor: Colors.blue,
                        valueIndicatorShape: SliderComponentShape.noThumb,
                      ),
                      child: RangeSlider(
                        divisions: 82,
                        min: 18.0,
                        max: 100.0,
                        values: _ageRange,
                        activeColor: Color.fromRGBO(107, 107, 107, 1),
                        inactiveColor: Color.fromRGBO(145, 145, 145, 1),
                        labels: RangeLabels("${_ageRange.start~/1} años", "${_ageRange.end~/1} años"),
                        onChanged: (values) {
                          setState(() {
                            _ageRange = values;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Gratis", style: TextStyle(color: Color.fromRGBO(0, 117, 177, 1))),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      side: BorderSide(color: Color.fromRGBO(0, 117, 177, 1))
                    ),
                    color: Colors.white,
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      Navigator.pushNamed(context, "upFreeAd");
                    },
                  ),
                  RaisedButton(
                    child: Text("Pago", style: TextStyle(color: Colors.white)),
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      side: BorderSide(color: Color.fromRGBO(0, 117, 177, 1))
                    ),
                    color: Color.fromRGBO(0, 117, 177, 1),
                    colorBrightness: Brightness.dark,
                    onPressed: () {
                      Navigator.pushNamed(context, "upPaidAd");
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget borderedItem(Widget child, {double radius = 50.0, Color color = Colors.grey, Color fill = Colors.transparent}) {
    return Container(
      child: child,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: color.withOpacity(0.4), style: BorderStyle.solid, width: 1,
        ),
      ),
    );
  }

  String binary(int number, int lenght) {
    String binario = number.toRadixString(2);
    return binario.padLeft(lenght, '0');
  }

  bool containOneBinary(String binary, int position)
  {
    return binary[position] == '1';
  }

  int toogleN(int number, int position)
  {
    int value = pow(2, (3- position));
    String _binary = binary(number, 4);
    return containOneBinary(_binary, position) ? - value : value;
  }

  Color toogleColorGender(int position)
  {
    return containOneBinary(binary(adInfo.ad.genderWoiner, 4), position) ? Colors.blue[200] : Colors.transparent;
  }
}
*/
