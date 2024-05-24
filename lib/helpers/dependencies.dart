import 'package:get/get.dart';
import 'package:heartly/controllers/tips_controller.dart';

Future<void> init() async {
  Get.lazyPut(
    () => TipsController(),
    fenix: true,
  );
}
