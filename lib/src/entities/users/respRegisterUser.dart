class respUserRegister {
  String message;
  bool status;
  List<UserR> usuario;

  respUserRegister({this.message, this.status, this.usuario});

  respUserRegister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      usuario = new List<UserR>();
      json['entities'].forEach((v) {
        usuario.add(new UserR.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.usuario != null) {
      data['entities'] = this.usuario.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserR {
  int id;
  String username;
  String email;
  String token;
  int state;
  int roleId;
  int createdAt;
  int updatedAt;
  String type;
  List<WoinerType> woinerType;

  UserR(
      {this.id,
      this.username,
      this.email,
      this.token,
      this.state,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.woinerType});

  UserR.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
    state = json['state'];
    roleId = json['roleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    if (json['woinerType'] != null) {
      woinerType = new List<WoinerType>();
      json['woinerType'].forEach((v) {
        woinerType.add(new WoinerType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['token'] = this.token;
    data['state'] = this.state;
    data['roleId'] = this.roleId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['type'] = this.type;
    if (this.woinerType != null) {
      data['woinerType'] = this.woinerType.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WoinerType {
  int codigo;
  String name;

  WoinerType({this.codigo, this.name});

  WoinerType.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.codigo;
    data['username'] = this.name;
    return data;
  }
}
