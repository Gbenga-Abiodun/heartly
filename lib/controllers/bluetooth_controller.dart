import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  var isConnected = false.obs;
  var isScanning = false.obs;

  var isRefreshing = false.obs;

  // List<ScanResult> scanResultList = [];
  // late StreamSubscription<List<ScanResult>> scanResultsSubscription;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   scanResult();
  //   // scanDevices();
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   // flutterBlue.stopScan();
  // }
  //
  // void scanResult() {
  //   scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
  //     scanResultList = results;
  //   }, onError: (e) {
  //     print(e.toString());
  //   });
  // }
  //
  //
  // Future onScanPressed() async {
  //   try {
  //     _systemDevices = await FlutterBluePlus.systemDevices;
  //   } catch (e) {
  //    print(e.toString());
  //   }
  //   try {
  //     await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  // }

  Future scanDevices() async {
    isScanning.value = true;
    try {
      if (await Permission.bluetoothScan.request().isGranted) {
              if (await Permission.bluetoothConnect.request().isGranted) {
                flutterBlue.startScan(timeout: const Duration(seconds: 5));

// Listen to scan results
                var subscription = flutterBlue.scanResults.listen((results) {
                  print('scanResults: ${results}');
                  // do something with scan results
                  for (ScanResult r in results) {
                    print('${r.device.name} found! rssi: ${r.rssi}');
                  }
                });
              } else {}
            } else {
              print("permission not granted");
            }

      // subscription.cancel();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;

  Future onRefresh() {
    if (isScanning.isFalse) {
      flutterBlue.startScan(
          timeout: const Duration(
        seconds: 40,
      ));
      isRefreshing.value = true;
    }
    isRefreshing.value = false;
    Get.snackbar(
      "scanning is still in progress",
      "Scanning is still in progress please refresh after a minute",
    );

    return Future.delayed(const Duration(milliseconds: 500));
  }

  // //
  // //
  // // Future scanDevices() async {
  // //   try {
  // //     if (await Permission.bluetoothScan.request().isGranted) {
  // //       if (await Permission.bluetoothConnect.request().isGranted) {
  // //         ble.startScan(
  // //           timeout: const Duration(
  // //             seconds: 10,
  // //           ),
  // //         );
  // //
  // //         ble.stopScan();
  // //         print("scan result" + scanResults.length.toString(),);
  // //       } else {}
  // //     } else {
  // //       print("permission not granted");
  // //     }
  // //   } catch (e) {
  // //     Get.snackbar(
  // //       e.toString(),
  // //       e.toString(),
  // //     );
  // //   }
  // // }
  //
  // Future<List<BluetoothDevice>> scanDevices() async {
  //   // List<BluetoothDevice> devices = [];
  //
  //   try {
  //     // Start scanning for Bluetooth devices
  //     await flutterBlue.startScan(timeout: const Duration(seconds: 10));
  //
  //     // Listen for discovered devices
  //     flutterBlue.scanResults.listen((results) {
  //       for (ScanResult result in results) {
  //         if (!devices.contains(result.device)) {
  //           devices.add(result.device);
  //         }
  //       }
  //     });
  //
  //     // Wait for the scan to complete
  //     await Future.delayed(Duration(seconds: 4));
  //
  //     // Stop scanning
  //     await flutterBlue.stopScan();
  //   } catch (e) {
  //     print('Error scanning for devices: $e');
  //   }
  //
  //   return devices;
  // }

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    Get.snackbar(
      "Connected!",
      "Please Send your string",
    );
    isConnected.value = true;
    // Once connected, you can perform operations on the device.
  }
}
