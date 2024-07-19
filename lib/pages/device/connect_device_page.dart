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
        // automaticallyImplyLeading: false,
        // actions: [
        //   GestureDetector(
        //     child: Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Icon(
        //         FontAwesomeIcons.bell,
        //         color: Colors.white,
        //         size: 26,
        //       ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<BluetoothController>(
          builder: (_) {
            return StreamBuilder(
              stream: bleController.scanResults,
              builder: (context, snapshot) {
                if (snapshot.hasData) {


                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    padding: EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final data= snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.heartColor,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.bluetooth,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            data.device.name,
                            style: TextStyle(fontSize: 18, color: Colors.red,),
                          ),
                          subtitle: Text(
                            data.device.id.toString(),
                            style: TextStyle(fontSize: 14, color: Colors.red,),
                          ),
                          trailing: Container(
                            width: 80,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.heartColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Connect",
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Bluetooth Device Found please Scan agaian",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => bleController.scanDevices(),
                        child: Container(
                          width: 100,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.heartColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Search",
                            style: TextStyle(fontSize: 18, color: Colors.white,),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.heartColor,
        // isExtended: true,

        onPressed: () => bleController.scanDevices(),
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.repeat,
            color: Colors.white,
            size: Dimensions.height12 * 2,
          ),
        ),
      ),
    );
  }
}
