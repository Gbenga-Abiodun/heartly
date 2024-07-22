import 'dart:math';
import 'dart:typed_data';

import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';

import 'package:heartly/database/sql_helper.dart';

import '../models/advice_model.dart';


class GeminiController extends GetxController {
  final Gemini gemini = Gemini.instance;

  var geminiAdvice = "";

  List<AdviceModel> adviceModel = [];

  var tipsDatabase = Get.find<SQLHelper>();
  var isTapped = 0.obs;

  List<String> notification = [];

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

  String classifyHeartRate(int Bpm) {
    if (Bpm >= 80 && Bpm <= 100) {
      return 'normal';
    } else {
      return 'stressed';
    }
  }

// Function to generate random BPM
  int generateRandomBpm(int min, int max) {
    final random = Random();
    return min + random.nextInt(max - min + 1);
  }

// Your generateBmpRate function
  void generateBmpRate() async {
    try {
      int heartRate = generateRandomBpm(60, 120);
      String condition = classifyHeartRate(heartRate);

      final prompt = condition == 'normal'
          ? 'Give normal medical advice nothing more than 10 words'
          : 'Give normal medical advice for a stressed person nothing more than 10 words';

     final geminiAdviceGen =  await gemini.text(prompt);

      geminiAdvice = geminiAdviceGen!.output.toString();
      adviceModel = [
        AdviceModel(advice: geminiAdviceGen.output.toString(),)
      ];
      update();

      print( "advice model" + adviceModel.toString() );
      notification.add(
        geminiAdviceGen.output.toString(),
      );

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: "heartly",
          body: "Connected to Device",
          title: "Please check notification Page for advice",
        ),
      );
      isTapped.value = 1;

      print(notification.toString(),);

      print(geminiAdviceGen.toString() + "advice");
    } catch (e) {
      print(e.toString());
    }
  }


}
