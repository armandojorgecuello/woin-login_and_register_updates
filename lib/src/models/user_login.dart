import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';

class UserLoguin {
  String username;
  String password;
  WoinLocation woinLocation;
  Device device;
  int code;

  UserLoguin(
      {this.username,
      this.password,
      this.woinLocation,
      this.device,
      this.code});

  UserLoguin.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    woinLocation = json['woinLocation'];
    device =json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.woinLocation != null) {
      data['woinLocation'] = this.woinLocation.toJson();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
      data['code'] = this.code;
    }

    return data;
  }
}




class objectLastConecction{
  int type;
  String fecha;
  objectLastConecction({this.type,this.fecha});
}

class objectDetalleUser{
  int type;
  String fullname;
  String birthdate;
  objectDetalleUser({this.type,this.fullname,this.birthdate});
}
