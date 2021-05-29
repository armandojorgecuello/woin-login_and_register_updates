class respSubcategoria {
  String message;
  bool status;
  List<Subcategoria> lsubcategorias;

  respSubcategoria({this.message, this.status, this.lsubcategorias});

  respSubcategoria.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      lsubcategorias = new List<Subcategoria>();
      json['entities'].forEach((v) {
        lsubcategorias.add(new Subcategoria.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.lsubcategorias != null) {
      data['entities'] = this.lsubcategorias.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategoria {
  int id;
  String name;
  int state;
  int categoryId;
  int parentId;
  int selected;
  int createdAt;
  int updatedAt;

  Subcategoria (
      {this.id,
        this.name,
        this.state,
        this.categoryId,
        this.parentId,
        this.createdAt,
        this.updatedAt,this.selected});

  Subcategoria .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    categoryId = json['categoryId'];
    parentId = json['parentId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    selected=0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['categoryId'] = this.categoryId;
    data['parentId'] = this.parentId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}