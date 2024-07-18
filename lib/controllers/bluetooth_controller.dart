import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;

  Stream<List<ScanResult>> get scanResults => ble.scanResults;

  Future scanDevices() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        ble.startScan(
          timeout: Duration(
            seconds: 10,
          ),
        );

        ble.stopScan();
      } else {}
    } else {}
  }
}
