import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import '../model/device_model.dart';

class DeviceController {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceModel> getDeviceInfo() async {
    String id = "unknown";

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      id = androidInfo.id; // ANDROID_ID
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? "unknown";
    }

    return DeviceModel(deviceId: id);
  }
}
