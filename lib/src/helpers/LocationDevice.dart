import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_ip/get_ip.dart';
import 'package:get_mac/get_mac.dart';
import 'package:woin/src/models/user_login.dart';
import 'package:woin/src/models/device_model.dart';
import 'package:woin/src/models/woin_location_model.dart';

class geoLocation {
  WoinLocation _location;
  Device _device;
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  static geoLocation _instance = geoLocation._internal();
  String macAddress;
  String ipAddress;

  geoLocation._internal() {}

  getCurentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    WoinLocation location = new WoinLocation(
      altitude: position.altitude,
      latitude: position.latitude,
      longitude: position.longitude
    );
    _location = location;
  }

  obtenerGeolocalizacion() async {
    await getCurentLocation();
    await getIpAndMac();
    await getDevice();
  }

  getIpAndMac() async {
    final ip = await GetIp.ipAddress;
    final mac = await GetMac.macAddress;
    macAddress = mac;
    ipAddress = ip;
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  
  getDevice() async {
    Map<String, dynamic> deviceData;
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {}
    _deviceData = deviceData;
    Device device = new Device(
        name: _deviceData['SO'] + " " + _deviceData['model'],
        ip: ipAddress,
        mac: macAddress,
        state: 0);

    _device = device;

    //print("DEVICE=>"+_deviceData['model']);
    //print("SO=>"+_deviceData['SO']);
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
      'SO': "Andorid",
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      'SO': 'IOS',
    };
  }

  WoinLocation get getLocation => _location;
  Device get getDevices => _device;

  factory geoLocation() {
    return _instance;
  }

  set setLocation(WoinLocation loc) {
    _location = loc;
  }

  set setDevice(Device dev) {
    _device = dev;
  }
}
