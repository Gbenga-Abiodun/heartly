import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  // FlutterBlue flutterBlue = FlutterBlue.instance;
  var isConnecting = false.obs;
  var isScanning = false.obs;

  var selectedItemIndex = 0.obs;

  var isConnected = false.obs;

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
          if (await FlutterBluePlus.isSupported == false) {
            print("Bluetooth not supported by this device");
            return;
          }

          var subscription = FlutterBluePlus.adapterState
              .listen((BluetoothAdapterState state) async {
            print(state);
            if (state == BluetoothAdapterState.on) {
              await FlutterBluePlus.startScan(
                  timeout: const Duration(
                seconds: 10,
              ));
              // usually start scanning, connecting, etc
            } else {
              Get.snackbar(
                "an error occured",
                "an error occured",
              );
              // show an error to the user, etc
            }
          });

          if (Platform.isAndroid) {
            await FlutterBluePlus.turnOn();
          }

          subscription.cancel();
        } else {}
      } else {
        print("permission not granted");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

  Future onRefresh() {
    if (isScanning.isFalse) {
      FlutterBluePlus.startScan(
          timeout: const Duration(
        seconds: 40,
      ));
      isRefreshing.value = true;
    }
    isRefreshing.value = false;

    return Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    isConnecting.value = true;
    try {
      await device.connect(
        autoConnect: false,
      );
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "heartly",
          body: "Connected to a bluetooth device please send in your string data",
          title: "Connected to a bluetooth device",

        ),
      );
      Get.snackbar(
        "Connected!",
        "Connected to bluetooth device",
      );

      isConnected.value = true;

// Disconnect from device
      await device.disconnect();
      isConnecting.value = false;
// // cancel to prevent duplicate listeners
//       subscription.cancel();
    } catch (e) {
      isConnecting.value = false;
      print(e.toString());
    }
  }
}
