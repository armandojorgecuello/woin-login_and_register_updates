class WoinLocation {
  double latitude;
  double longitude;
  double altitude;

  WoinLocation({
    this.latitude,
    this.longitude,
    this.altitude,
  });

  WoinLocation.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;

    return data;
  }
}