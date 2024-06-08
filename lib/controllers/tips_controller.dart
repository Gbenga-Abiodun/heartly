import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../models/tips_model.dart';

class TipsController extends GetxController {

  FlutterTts flutterTts = FlutterTts();


  var isSpeaking = false.obs;

  var currentVoice = <String, dynamic>{}.obs;


  TipsController(){
    flutterTts.setStartHandler(() {
      isSpeaking.value = true;
    });

    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
    });

    flutterTts.setErrorHandler((msg) {
      isSpeaking.value = false;
    });
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }
  List<TipsModel> tipsModel = [
    TipsModel(
      "https://img.freepik.com/free-vector/human-heart_1308-84059.jpg?w=740&t=st=1717829422~exp=1717830022~hmac=e876eaef5fb27387accc8cd8c807a1d9798b37892603e54f8ad280ab25e90cc2",
      "Lower your daily sodium intake",
      "Too much sodium causes you to retain water, according to a small 2017 studyTrusted Source. When it does, your heart has to work harder to move the additional fluid through your body. Choose foods labeled as “no salt added,” try to avoid foods that have more than 400 milligrams of sodium per serving, and try to stay below 1500 milligrams total per day.",
      false.obs,
    ),
    TipsModel(
      "https://img.freepik.com/free-photo/realistic-heart-shape-studio_23-2150827370.jpg?t=st=1717829489~exp=1717833089~hmac=fc51d7fda302f424e80b05cd5762b4aff4bee68d796ae056d658df11636a4dbd&w=740",
      "Lower your saturated fat intake",
      "Saturated fat can lead to atherosclerosis, where hard plaque builds up in your arteries. You can lower your intake by eating low fat cuts of meat, like the eye of round roast or sirloin tip, and avoiding high fat dairy products. Generally speaking, if it’s greasy, it’s likely higher in saturated fats.",
      false.obs,
    ),
    TipsModel(
      "https://img.freepik.com/free-photo/small-plastic-human-heart-light-table_23-2148018340.jpg?w=740&t=st=1717829516~exp=1717830116~hmac=88b95d3ce1f06ebe0b8fe9096faec1c7af84fe15fb27b5136c4aa6ed92884a9b",
      "Choose heart-healthy fats",
      "Unsaturated fats can be heart-healthy by lowering inflammation in your body. Inflammation can lead to heart disease. Heart-healthy fats include vegetable oil, low fat mayonnaise, and oil-based salad dressings.",
      false.obs,
    ),
    TipsModel(
      "https://img.freepik.com/free-photo/realistic-heart-shape-studio_23-2150827446.jpg?t=st=1717829661~exp=1717833261~hmac=891c3aefe0263109f69428ed9c9866b9c13b41be964d6ff3f58ba949423f69d8&w=740",
      "Increase your dietary fiber intake",
      "Fiber helps you feel fuller and can help lower cholesterol levels. Plus, the Department of Health and Human ServicesTrusted Source says that high fiber foods are generally healthier, including beans, fruits, vegetables, and whole grains.",
      false.obs,
    ),
    TipsModel(
      "https://img.freepik.com/free-photo/human-heart-gray-background-3d-rendering-3d-illustration_1057-32561.jpg?t=st=1717829702~exp=1717833302~hmac=5ae461b21484e54daa3d091d161e0b30a62599c64423c394a18bc48fd1fda653&w=740",
      "Eat lots of fruits and vegetables",
      "Fruits and veggies are packed with nutrients and are lower in calories to help you maintain a moderate weight and reduce inflammation. The more colorful and fresh your choices, the better.",
      false.obs,
    ),
  ];


  // void speakText(String text )async{
  //   if(!isSpeaking.value){
  //     flutterTts.speak(text);
  //   }else{
  //
  //   }
  //
  //
  // }
  Future<void> speakText(TipsModel tip) async {
    if (!tip.isSpeaking.value) {
      tip.isSpeaking.value = true;
      await flutterTts.speak(tip.TipTitle);
      tip.isSpeaking.value = false;
    }
  }


  void initTTS(){
    flutterTts.getVoices.then((onValue){
      try{
        List<Map> _voices = List<Map>.from(onValue);
        _voices = _voices.where((voice) => voice["name"].contains("en"),).toList();
        currentVoice == _voices.first;
        setVoice(currentVoice);
      }catch(e){
        print(e);
      }
    });

  }


  void setVoice(Map voice){

    flutterTts.setVoice({
      "name" : voice["name"],
      "locale" : voice["locale"],

    });
}


}
