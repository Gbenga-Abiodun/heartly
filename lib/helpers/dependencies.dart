import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/gemini_controller.dart';
import 'package:heartly/controllers/tips_controller.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../utils/app_constants.dart';


Future<void> init() async {

   Gemini.init(
    apiKey: AppConstants.apiKey,
  );
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.storageBox);

  // final hive = await ;
  //
  // final hiveBox  = await Hive.openBox("heartly-box");
  // // final sharedPreferences = await SharedPreferences.getInstance();
  // //
  // //
  // // Get.lazyPut(() => sharedPreferences, fenix: true,);
  // // final Gemini gemini = Gemini.init(apiKey: '--- Your Gemini Api Key ---');

  Get.lazyPut(
    () => TipsController(),
    fenix: true,
  );
  Get.lazyPut(
    () => GeminiController(),
    fenix: true,
  );
  // Get.lazyPut(
  //   () => hive,
  //   fenix: true,
  // );

  // Get.lazyPut(
  //   () => gemini,
  //   fenix: true,
  // );
}
