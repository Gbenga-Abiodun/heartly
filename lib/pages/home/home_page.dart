import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/gemini_controller.dart';
import 'package:heartly/controllers/speech_controller.dart';
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/app_constants.dart';
import 'package:heartly/utils/colors.dart';
import 'package:heartly/widgets/big_text.dart';

import '../../utils/dimensions.dart';

class HomePage extends GetView<SpeechController> {
  HomePage({Key? key}) : super(key: key);

  var geminiController = Get.find<GeminiController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: Dimensions.height10 * 8,
        backgroundColor: AppColors.heartColor,
        title: Text(
          "HomePage",
          style: TextStyle(
            fontSize: Dimensions.height12 * 2.5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            // onTap: () => geminiController.generateTips(),
            child: Container(
              margin: EdgeInsets.only(
                right: Dimensions.height10 * 2,
              ),
              width: Dimensions.height10 * 5,
              height: Dimensions.height10 * 5,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                FontAwesomeIcons.bell,
                color: AppColors.heartColor,
                size: Dimensions.height12 * 2.166666666666667,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: geminiController.tipsModel.length,
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            leading: Container(
              width: Dimensions.height10 * 6,
              height: Dimensions.height10 * 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  Dimensions.height12 * 1.333333333333333,
                ),
              ),
              child: Center(
                child: Image.memory(
                  geminiController.tipsModel[index].image,
                  fit: BoxFit.cover,
                ),
              ),
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
                  controller.speakText(
                    geminiController.tipsModel[index].content,
                  );
                },
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.play,
                    size: Dimensions.height12 * 2,
                    color: Colors.white,
                  ),
                ),
              )),
            ),
            title: BigText(
              text: geminiController.tipsModel[index].title,
              size: Dimensions.height12 * 2,
              color: Colors.red,
              // fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.heartColor,
        // isExtended: true,

        onPressed: () {
          // geminiController.generateHeartImage();
        },
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.add,
            color: Colors.white,
            size: Dimensions.height12 * 2,
          ),
        ),
      ),
    );
  }
}
