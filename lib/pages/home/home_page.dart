import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/tips_controller.dart';
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/colors.dart';
import 'package:heartly/widgets/big_text.dart';

import '../../utils/dimensions.dart';

class HomePage extends GetView<TipsController> {
  const HomePage({Key? key}) : super(key: key);

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
          Container(
            margin: EdgeInsets.only(
              right: Dimensions.height10 * 2,
            ),
            width: Dimensions.height10 * 5,
            height: Dimensions.height10 * 5,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {},
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
        itemCount: controller.tipsModel.length,
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
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: CachedNetworkImageProvider(
                    controller.tipsModel[index].TipImage,
                  ),
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
              child: Obx(() {
                return Center(
                  child: controller.tipsModel[index].isSpeaking.isFalse
                      ? GestureDetector(
                          onTap: () {
                            controller.speakText(
                              controller.tipsModel[index],
                            );
                          },
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.play,
                              size: Dimensions.height12 * 2,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.flutterTts.pause();
                          },
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.pause,
                              size: Dimensions.height12 * 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                );
              }),
            ),
            title: BigText(
              text: controller.tipsModel[index].TipTitle,
              size: Dimensions.height12 * 2,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.heartColor,
        // isExtended: true,

        onPressed: () {},
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
