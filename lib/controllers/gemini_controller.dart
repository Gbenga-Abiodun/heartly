import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class GeminiController extends GetxController {
  final Gemini gemini = Gemini.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var tip = "".obs;
  var content = "".obs;
  var imagePath = "".obs;

  var imageData = Rxn<Uint8List>();




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
        textToImage("Generate an image based on this title ${tip}");

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

  Future<dynamic> textToImage(String prompt) async {
    String engineId = "stable-diffusion-v1-6";
    String apiHost = 'https://api.stability.ai';
    String apiKey = AppConstants.apiKeyImageGeneration;
    debugPrint(prompt);
    final response = await http.post(
        Uri.parse('$apiHost/v1/generation/$engineId/text-to-image'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "image/png",
          "Authorization": "Bearer $apiKey"
        },
        body: jsonEncode({
          "text_prompts": [
            {
              "text": prompt,
              "weight": 1,
            }
          ],
          "cfg_scale": 7,
          "height": 1024,
          "width": 1024,
          "samples": 1,
          "steps": 30,
        }));

    if (response.statusCode == 200) {
      try {
        debugPrint(response.statusCode.toString());
        imageData.value = response.bodyBytes;
        print(response.bodyBytes);
        // loadingChange(true);
        // searchingChange(false);
        // notifyListeners();
      } on Exception {
        debugPrint("failed to generate image");
      }
    } else {
      debugPrint("failed to generate image");
    }
  }

  void storeDatabase() {



  }
}
