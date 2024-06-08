import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/tips_controller.dart';

Future<void> init() async {
  final Gemini gemini = Gemini.init(apiKey: '--- Your Gemini Api Key ---');

  Get.lazyPut(
    () => TipsController(),
    fenix: true,
  );

  Get.lazyPut(
    () => gemini,
    fenix: true,
  );
}
