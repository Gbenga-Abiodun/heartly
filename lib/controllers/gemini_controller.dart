import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

class GeminiController extends GetxController {
  final Gemini gemini = Gemini.instance;

  var response = "".obs;

  void generateTips() async {
    try {
      await gemini
          .text(
        "Give me a short heart tip",
      )
          .then((value) {
        print("${value!.output}");
      }).catchError((onError) {
        if (onError is GeminiException) {
          print(onError);
        } else {
          print("An error occured");
        }
      });
    } catch (e) {}
  }


  void generateHeartImage() async {
    try {
      await gemini
          .text("Generate an image of the heart for me ")
          .then((value) {
        print("${value!.output}");
      }).catchError((onError) {
        if (onError is GeminiException) {
          print(onError);
        } else {
          print("An error occured");
        }
      });
    } catch (e) {}
  }
}
