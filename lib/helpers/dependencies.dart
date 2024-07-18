import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/bluetooth_controller.dart';
import 'package:heartly/controllers/gemini_controller.dart';

import 'package:heartly/controllers/speech_controller.dart';
import 'package:heartly/database/sql_helper.dart';


import '../utils/app_constants.dart';

Future<void> init() async {

  Get.lazyPut(
    () => SpeechController(),
    fenix: true,
  );
  // Get.lazyPut(
  //   () => TipDatabase(),
  // );

  // Get.lazyPut(
  //   () => ObjectBoxController,
  //   // fenix: true,
  // );
  Get.lazyPut(
    () => GeminiController(),
    fenix: true,
  );
  Get.lazyPut(
    () => SQLHelper(),
    // fenix: true,
  );
  Get.lazyPut(
    () => BluetoothController(),
    // fenix: true,
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
