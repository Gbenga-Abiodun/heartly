import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // scanDevices();
  }

  Stream<List<ScanResult>> get scanResults => ble.scanResults;

  Future scanDevices() async {
    try {
      if (await Permission.bluetoothScan.request().isGranted) {
        if (await Permission.bluetoothConnect.request().isGranted) {
          ble.startScan(
            timeout: const Duration(
              seconds: 10,
            ),
          );

          ble.stopScan();
        } else {}
      } else {
        print("permission not granted");
      }
    } catch (e) {
      Get.snackbar(
        e.toString(),
        e.toString(),
      );
    }
  }
}
