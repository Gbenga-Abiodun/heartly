import 'dart:typed_data';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_pixel/flutter_pixel.dart';
import 'package:get/get.dart';
import 'package:heartly/utils/app_constants.dart';

class GeminiController extends GetxController {
  final Gemini gemini = Gemini.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    Authenticator.setApiToken(AppConstants.apiKeyImageGeneration,);


// Replace this with your edenai API key (currently has a free plan as of 02/03/2024).
  }

  var tip = "".obs;
  var content = "".obs;
  var imagePath = "".obs;

  void generateTips() async {
    try {
      await gemini
          .text(
        "Give me a short heart tip very short as i said and dont add any  * ",
      )
          .then((value) async{
        print("tip :${value!.output}");
        tip.value == value.output;
        generateContent(
          title: value.output.toString(),
        );
        await _generate("Generate an image based on this title ${tip}");
      }).catchError((onError) {
        if (onError is GeminiException) {
          print(onError);
        } else {
          print("An error occured");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void generateContent({required String title}) async {
    try {
      await gemini
          .text(
        "Give me an informative short content on this heart tip ${title} and dont add any * in the response you are giving me please let it be short and concise",
      )
          .then((value) {
        print("content : ${value!.output}");
        content.value == value.output;
      }).catchError((onError) {
        if (onError is GeminiException) {
          print(onError);
        } else {
          print("An error occured");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Uint8List> _generate(String query) async {
    // textController.clear();
    // setState(() {
    //   isTextEmpty = true;
    // });
    Uint8List image = await imageGenerator(query, ImageSize.medium);
    print(image);
    return image;
  }

  void storeDatabase() {}
}
