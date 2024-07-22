import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:heartly/controllers/gemini_controller.dart';

import '../../controllers/bluetooth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class ConnectDevicePage extends StatelessWidget {
  ConnectDevicePage({Key? key}) : super(key: key);

  var geminiController = Get.find<GeminiController>();
  var bluetoothController = Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
    bluetoothController.scanDevices();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.height10,
          ),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios,
              size: Dimensions.height12 * 2,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          "Available devices",
          style:
              TextStyle(fontSize: Dimensions.height12 * 2, color: Colors.white),
        ),
        backgroundColor: AppColors.heartColor,
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<BluetoothController>(
        builder: (_) {
          return StreamBuilder(
            stream: bluetoothController.scanResults,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];

                    return ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.heartColor,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.bluetooth,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        data.device.name,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      subtitle: Text(
                        data.rssi.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                      trailing: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            bluetoothController.selectedItem == index;
                            bluetoothController.connectToDevice(data.device);
                          },
                          child: Container(
                              width: 80,
                              height: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.heartColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: !bluetoothController.isConnecting.isFalse && bluetoothController.selectedItem == index?Text(
                                bluetoothController.isTapped.value == 0
                                    ? "Connect"
                                    : "Connected",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ) : CircularProgressIndicator(
                                color: Colors.white,
                              )
                          ),
                        );
                      }),
                    );
                  },
                );
              }
              else if(!snapshot.hasData){
                return Center(
                  child: const Text(
                    "No Data",
                  ),
                );
              }
              else {
                return const Text(
                  "No Data",
                );
              }
            },
          );
        },
      ),
    );
  }
}
