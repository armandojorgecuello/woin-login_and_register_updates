class respTypeDocument {
  String message;
  bool status;
  List<typeDocument> tiposDocumentos;
  int code;

  respTypeDocument(
      {this.message, this.status, this.tiposDocumentos, this.code});

  respTypeDocument.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['entities'] != null) {
      tiposDocumentos = new List<typeDocument>();
      json['entities'].forEach((v) {
        tiposDocumentos.add(new typeDocument.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.tiposDocumentos != null) {
      data['entities'] = this.tiposDocumentos.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class typeDocument {
  int id;
  String type;
  String name;

  typeDocument({
    this.id,
    this.type,
    this.name,
  });

  typeDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;

    return data;
  }
}
