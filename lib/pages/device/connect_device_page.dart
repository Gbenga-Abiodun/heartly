import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/bluetooth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class ConnectDevicePage extends StatelessWidget {
  ConnectDevicePage({Key? key}) : super(key: key);
  var bleController = Get.find<BluetoothController>();

  @override
  Widget build(BuildContext context) {
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
          init: BluetoothController(),
          builder: (_) {
            return StreamBuilder(stream: bleController.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: ListTile(
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
                            data.device.id.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                          ),
                          trailing: Obx(() {
                            return GestureDetector(
                              onTap: () {
                                bleController.selectedItemIndex.value = index;
                                bleController.connectToDevice(
                                  data.device,
                                );

                              },


                              child: Container(
                                width: 80,
                                height: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.heartColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: bleController.isConnecting.isFalse && bleController.selectedItemIndex.value == index                                    ? Text(
                                  bleController.isConnected.isFalse&& bleController.selectedItemIndex.value == index
                                      ? "Connect"
                                      : "Connected",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )
                                    : CircularProgressIndicator(
                                  color: Colors.white,),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text("No Device Found", style: TextStyle(
                      color: AppColors.heartColor,
                      fontSize: 18,
                    ),),
                  );
                }
              },);
          }),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: AppColors.heartColor,
      //   // isExtended: true,
      //
      //   onPressed: () =>bleController.isRefreshing.isFalse ? bleController.onRefresh() : null,
      //   child: Obx(() {
      //     return Center(
      //       child: bleController.isRefreshing.isFalse ? FaIcon(
      //         FontAwesomeIcons.repeat,
      //         color: Colors.white,
      //         size: Dimensions.height12 * 2,
      //       ) : const CircularProgressIndicator(
      //         color: Colors.grey,
      //         backgroundColor: Colors.white,
      //       ),
      //     );
      //   }),
      // ),
    );
  }
}
