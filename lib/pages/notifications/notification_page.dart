import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/gemini_controller.dart';
import 'package:heartly/controllers/speech_controller.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class NotificationPage extends GetView<GeminiController> {
  NotificationPage({Key? key}) : super(key: key);

  var speechController = Get.find<SpeechController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Notifications",
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
      body: ListView.builder(
        itemCount: controller.notification.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            leading: Container(
              width: Dimensions.height10 * 6,
              height: Dimensions.height10 * 6,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1530026405186-ed1f139313f8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aHVtYW4lMjBoZWFydHxlbnwwfHwwfHx8MA%3D%3D",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(
                  Dimensions.height12 * 1.333333333333333,
                ),
              ),
              // child: Center(
              //   child: Image.memory(
              //     geminiController.tipsModel[index].image,
              //     fit: BoxFit.contain,
              //   ),
              // ),
            ),
            trailing: Container(
              width: Dimensions.height10 * 5,
              height: Dimensions.height10 * 5,
              decoration: BoxDecoration(
                color: AppColors.heartColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                  child: GestureDetector(
                onTap: () {
                  speechController.speakText(
                    controller.notification[index],
                  );
                },
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.volumeHigh,
                    size: Dimensions.height12 * 2,
                    color: Colors.white,
                  ),
                ),
              )),
            ),
            title: BigText(
              text: controller.notification[index],
              size: Dimensions.height12 * 2,
              color: Colors.red,
              // fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}
