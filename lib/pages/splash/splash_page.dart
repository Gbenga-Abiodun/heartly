import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ),
        () => Get.offAllNamed(RouteHelpers.getHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.heartColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: TextStyle(
                fontSize: Dimensions.height10 * 6,
                fontFamily: 'blackBerry',
                fontWeight: FontWeight.bold,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Heartly',
                    speed: Duration(
                      milliseconds: 300,
                    ),
                  ),

                  // TyperAnimatedText('you must know what to do,'),
                  // TyperAnimatedText('and then do your best'),
                  // TyperAnimatedText('- W.Edwards Deming'),
                ],

                // onTap: () {
                //   print("Tap Event");
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
