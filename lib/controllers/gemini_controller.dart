import 'dart:convert';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/bluetooth_controller.dart';
import 'package:heartly/database/sql_helper.dart';

import 'package:heartly/models/tips_model.dart';
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/app_constants.dart';

import 'package:http/http.dart' as http;

// import 'object_box_controller.dart';

class GeminiController extends GetxController {
  final Gemini gemini = Gemini.instance;

  var geminiAdvice = "".obs;

  var tipsDatabase = Get.find<SQLHelper>();

  List<String> notification = [];

  // var boxController = Get.find<ObjectBoxController>();
  // static final _tipDatabase = Hive.box(
  //   AppConstants.storageBox,
  // );

  // List<TipsModel> tipsModel = [];

  @override
  void onReady() {
    // TODO: implement onInit
    super.onInit();
    // generateTips();
  }

  // var tip = "".obs;
  // var content = "".obs;
  // // var imagePath = "".obs;

  var imageData = Rxn<Uint8List>();

  void generateTips() async {
    try {
      await gemini
          .text(
        "Give me a short heart tip very short as i said and dont add any  * ",
      )
          .then((title) async {
        await gemini
            .text(
          "Give me an informative short content on this heart tip ${title!.output} and dont add any * in the response you are giving me please let it be short and concise",
        )
            .then((content) async {
          await tipsDatabase
              .createItem(
            title.output.toString(),
            content!.output.toString(),
            "",
          )
              .then((onValue) async {
            await tipsDatabase.getItems();
          });

          print(
            title.output.toString(),
          );
          print(
            content!.output.toString(),
          );

          // print("Data : ${content!.output}");

          // content.content =value.output!;
          // print("content : ${content.value}");
        }).catchError((onError) {
          if (onError is GeminiException) {
            print(onError);
          } else {
            print("An error occured gemini content");
          }
        });
      }).catchError((onError) {
        if (onError is GeminiException) {
          print(onError);
        } else {
          print("An error occured gemini");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  String classifyHeartRate(String bpmStr) {
    int bpm = int.tryParse(bpmStr) ?? 0;
    if (bpm >= 80 && bpm <= 100) {
      return 'normal';
    } else {
      return 'stressed';
    }
  }

  void generateBmpRate({required String heartRate}) async {
    try {
      String condition = classifyHeartRate(heartRate);

      final prompt = condition == 'normal'
          ? 'Give normal medical advice.'
          : 'Give medical advice for a stressed person.';
      await gemini.text("condition").then(
        (onValue) {
          geminiAdvice.value = onValue.toString();
          notification.add(
            onValue.toString(),
          );
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: 1,
              channelKey: "heartly",
              body: "Disconnected",
              title: "Disconnected from  bluetooth device",
            ),
          );
          Get.snackbar(
            "Advice Generated!",
            "Advice Generated Successfully",
          );
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // void generateContent({required String title}) async {
  //   try {
  //     await gemini
  //         .text(
  //       "Give me an informative short content on this heart tip ${title} and dont add any * in the response you are giving me please let it be short and concise",
  //     )
  //         .then((value) {
  //
  //       print("Data : ${value!.output}");
  //
  //       content.value =value.output!;
  //       print("content : ${content.value}");
  //     }).catchError((onError) {
  //       if (onError is GeminiException) {
  //         print(onError);
  //       } else {
  //         print("An error occured");
  //       }
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void deleteTip(int id) async {
  //   boxController.deleteTip(id);
  // }

  // Uint8List convertStringToUint8List(String str) {
  //   final List<int> codeUnits = str.codeUnits;
  //   final Uint8List unit8List = Uint8List.fromList(codeUnits);
  //
  //   return unit8List;
  // }

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
}
