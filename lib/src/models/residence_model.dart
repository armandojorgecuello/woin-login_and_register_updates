
class Residences {
  int countryId;
  String country;
  int governorateid;
  String governorate;
  int cityId;
  String city;
  String address;
  int type;

  Residences(
      {this.countryId,
      this.country,
      this.governorateid,
      this.governorate,
      this.cityId,
      this.city,
      this.address,
      this.type});

  Residences.fromJson(Map<String, dynamic> json) {
    countryId = json['countryId'];
    country = json['country'];
    governorateid = json['governorateid'];
    governorate = json['governorate'];
    cityId = json['cityId'];
    city = json['city'];
    address = json['address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryId'] = this.countryId;
    data['country'] = this.country;
    data['governorateid'] = this.governorateid;
    data['governorate'] = this.governorate;
    data['cityId'] = this.cityId;
    data['city'] = this.city;
    data['address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}