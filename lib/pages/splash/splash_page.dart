import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:heartly/controllers/gemini_controller.dart';
import 'package:heartly/utils/colors.dart';
import 'package:heartly/widgets/big_text.dart';

import '../../routes/route_helpers.dart';
import '../../utils/dimensions.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Future<void> _loadData()async{
  //
  //   Get.find<GeminiController>().generateTips();
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _loadData();
    Timer(
      const Duration(
        seconds: 8,
      ),
      () => Get.find<GeminiController>().generateTips(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.heartColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // DefaultTextStyle(
            //   style: TextStyle(
            //     fontSize: Dimensions.height10 * 6,
            //     fontFamily: 'blackBerry',
            //     fontWeight: FontWeight.bold,
            //   ),
            //   child: AnimatedTextKit(
            //     animatedTexts: [
            //       TyperAnimatedText(
            //         'Heartly',
            //         speed: Duration(
            //           seconds: 3,
            //         ),
            //       ),
            //
            //       // TyperAnimatedText('you must know what to do,'),
            //       // TyperAnimatedText('and then do your best'),
            //       // TyperAnimatedText('- W.Edwards Deming'),
            //     ],
            //
            //     // onTap: () {
            //     //   print("Tap Event");
            //     // },
            //   ),
            // ),

            BigText(
              text: "Heartly",
              size: Dimensions.height10 * 6,
              fontFamily: 'blackBerry',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: Dimensions.height10 * 10,
            ),
            CircularProgressIndicator(
              color: Colors.grey,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
