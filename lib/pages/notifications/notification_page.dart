import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontSize: Dimensions.height12 * 2, color: Colors.white),
        ),
        backgroundColor: AppColors.heartColor,
        automaticallyImplyLeading: false,
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
