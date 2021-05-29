class RespUserLoguin {
  String message;
  bool status;
  List<dynamic> entities;
  int code;

  RespUserLoguin({this.message, this.status, this.entities, this.code});

  RespUserLoguin.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    entities =json['entities'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.entities != null) {
      data['entities'] = this.entities.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;

    return data;
  }
}