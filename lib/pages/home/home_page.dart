import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/colors.dart';

import '../../utils/dimensions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(fontSize: Dimensions.height12 * 2, color: Colors.white),
        ),
        backgroundColor: AppColors.heartColor,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(RouteHelpers.getNotificationPage()),
            child: Padding(
              padding:  EdgeInsets.all(Dimensions.height8,),
              child: Icon(
                FontAwesomeIcons.bell,
                color: Colors.white,
                size: Dimensions.height12 * 2.166666666666667,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
