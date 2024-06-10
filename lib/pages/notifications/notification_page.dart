import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
            child:  Icon(
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
    );
  }
}
