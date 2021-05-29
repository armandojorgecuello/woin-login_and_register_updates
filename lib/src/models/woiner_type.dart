
class WoinerType {
  String typeName;
  int type;
  int defaultType;
  double calification;

  WoinerType({this.typeName, this.type, this.defaultType, this.calification});

  WoinerType.fromJson(Map<String, dynamic> json) {
    typeName = json['typeName'];
    type = json['type'];
    defaultType = json['default'];
    calification = double.parse(json['calification'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeName'] = this.typeName;
    data['type'] = this.type;
    data['default'] = this.defaultType;
    data['calification'] = this.calification;
    return data;
  }
}
