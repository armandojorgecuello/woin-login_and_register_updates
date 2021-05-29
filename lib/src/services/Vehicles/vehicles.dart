class Vehicles {
  String message;
  bool status;
  List<Vehicle > entities;

  Vehicles({this.message, this.status, this.entities});

  Vehicles.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      entities = new List<Vehicle >();
      json['entities'].forEach((v) {
        entities.add(new Vehicle .fromJson(v));
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

class Vehicle {
  int id;
  String name;
  String icon;
  int state;
  int createdAt;
  int updatedAt;

  Vehicle (
      {this.id,
        this.name,
        this.icon,
        this.state,
        this.createdAt,
        this.updatedAt});

  Vehicle .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['state'] = this.state;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}