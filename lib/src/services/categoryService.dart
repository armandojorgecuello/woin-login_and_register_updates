/*import 'dart:async';
import 'dart:convert';

import 'package:woin/src/entities/Categories/Category.dart';
import 'package:woin/src/entities/Categories/Subcategory.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:woin/src/helpers/apiBase.dart';

/*
 * Service of Categories:
 * Get
 */
class _CategoryService {
  ApiBaseHelper _api = new ApiBaseHelper();
  List<Subcategory> entities;

  Future<List<Subcategory>> all(int id) async {
    if (id == null || id == 0) return null; /* Returning null for bads id's */

    entities = List<Subcategory>(); /* List of subcategories for subcategories of the categoryId */

    final response = await rootBundle.loadString('data/categories.json');
    Map data = json.decode(response);
    List<dynamic> ads = data['categories'];

    dynamic category = ads.firstWhere((item) => item['id'] == id, orElse: () => null);

    if (category == null) return null;
    ads = category['subcategories'];
    if (ads == null) return [];

    ads.forEach((item) {
      entities.add(Subcategory.fromJson(item));
    });

    return entities;
  }

  // Future <List<Category>> getAll() async{
  //   List<Category> categories = [];
  //   List<dynamic> jsonEntities;
  //   final resp = await rootBundle.loadString('data/categories.json');
  //   Map dataMap = json.decode(resp);
  //   jsonEntities = dataMap['categories'];
  //   if (jsonEntities == null) return [];
  //   jsonEntities.forEach((item) {
  //     categories.add(Category.fromJson(item));
  //   });
  //   return categories;
  // }

  Future<List<Category>> getAll() async{
    List<Category> categories = [];
    Map response = await _api.httpGet('woinCategory/0/10');
    List<dynamic> jsonEntities = response['entities'];
    jsonEntities.forEach((category)=>categories.add(Category.fromJson(category)));
    return categories;
  }
  Future<List<Subcategory>> getSubcategories({int categoryId, int parentId}) async{
    String ruta = "woinSubCategory/${parentId!=null?'childs/$parentId':'$categoryId'}/0/50";
    List<Subcategory> subCategories = [];
    Map response = await _api.httpGet(ruta);
    List<dynamic> jsonEntities = response['entities'];
    jsonEntities.forEach((subCategory)=>subCategories.add(Subcategory.fromJson(subCategory)));
    return subCategories;
  }
}

final categoryService = new _CategoryService();*/