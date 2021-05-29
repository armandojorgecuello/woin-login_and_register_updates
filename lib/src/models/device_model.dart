class Device {
  int id;
  String name;
  int state;
  String mac;
  String ip;
  int userId;
  int createdAt;
  int updatedAt;

  Device(
      {this.id,
      this.name,
      this.state,
      this.mac,
      this.ip,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    mac = json['mac'];
    ip = json['ip'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['mac'] = this.mac;
    data['ip'] = this.ip;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
