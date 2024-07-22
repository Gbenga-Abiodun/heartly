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
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
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
            title: const Text(
              "Heart rate Device",
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            subtitle: const Text(
              "Arduino heart beat device",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            trailing: Obx(() {
              return GestureDetector(
                onTap: () {
                  geminiController.generateBmpRate();
                },
                child: Container(
                    width: 80,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.heartColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      geminiController.isTapped.value == 0
                          ? "Connect"
                          : "Connected",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
              );
            }),
          );
        },
      ),
    );
  }
}
