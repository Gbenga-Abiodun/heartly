import 'dart:async';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'package:get/get.dart';
import 'package:heartly/controllers/gemini_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  // FlutterBlue flutterBlue = FlutterBlue.instance;
  var isConnecting = false.obs;
  var isScanning = false.obs;

  var selectedItemIndex = 0.obs;

  var heartRate = "".obs;

  BluetoothCharacteristic? hearRateCharacteristics;

  var isConnected = false.obs;

  final GeminiController _geminiController;

  var isRefreshing = false.obs;

  BluetoothController({required GeminiController geminiController})
      : _geminiController = geminiController;

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
                "turn on your bluetooth",
                "bluetooth is not on",
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
          timeout: const Duration(
            seconds: 10,
          ));

      device.connectionState.listen((BluetoothConnectionState state) async {
        if (state == BluetoothConnectionState.connecting) {
          isConnecting.value = true;

          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: "heartly",
              body: "Connecting to bluetooth device ",
              title: "Connecting to a bluetooth device",
            ),
          );
          Get.snackbar(
            "connecting!",
            "connecting to bluetooth device",
          );
        } else if (state == BluetoothConnectionState.connected) {
          isConnected.value = true;

          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: "heartly",
              body:
                  "Connected to a bluetooth device please send in your string data",
              title: "Connected to a bluetooth device",
            ),
          );
          Get.snackbar(
            "Connected!",
            "Connected to bluetooth device",
          );
          _discoverServices(device);
        } else {
          isConnected.value = false;
          isConnected.value = false;
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: "heartly",
              body: "Disconnected",
              title: "Disconnected from  bluetooth device",
            ),
          );
          Get.snackbar(
            "Disconnected!",
            "Disconnected from bluetooth device",
          );
        }
      });
    } catch (e) {
      isConnecting.value = false;
      print(e.toString());
    }
  }

  void _discoverServices(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
     if(services.isEmpty){
       AwesomeNotifications().createNotification(
         content: NotificationContent(
           id: 1,
           channelKey: "heartly",
           body: "Empty Service",
           title: "No Service try sending a data",
         ),
       );
       Get.snackbar(
         "Service!",
         "no service to use",
       );
     }else{
       for (BluetoothService service in services) {
         for (BluetoothCharacteristic characteristic
         in service.characteristics) {
           print('Discovered Characteristic: ${characteristic.uuid}');
           hearRateCharacteristics = characteristic;
           // You can temporarily print the properties to help identify the characteristic
           print('Characteristic properties: ${characteristic.properties}');
           _readCharacteristic(characteristic);
         }
       }
     }
    } catch (e) {
      print(e.toString());
    }
  }

  void _readCharacteristic(BluetoothCharacteristic characteristic) async {
    try {
      characteristic.value.listen((value) {
        heartRate.value = String.fromCharCodes(value);
        _geminiController.generateBmpRate(
          heartRate: heartRate.value.toString(),
        );
        print(heartRate.value.toString());
      });
      await characteristic.setNotifyValue(true);
    } catch (e) {
      print(e.toString());
    }
  }
}
