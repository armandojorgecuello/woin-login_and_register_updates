class Respcategory {
  String message;
  bool status;
  List<Category> categorias;
  int code;

  Respcategory({this.message, this.status, this.categorias, this.code});

  Respcategory.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      categorias = new List<Category>();
      json['entities'].forEach((v) {
        categorias.add(new Category.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.categorias != null) {
      data['entities'] = this.categorias.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Category {
  int id;
  String name;
  String description;
  int state;
  int createdAt;
  int updatedAt;

  Category(
      {this.id,
      this.name,
      this.description,
      this.state,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
