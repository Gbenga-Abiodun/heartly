

import 'dart:typed_data';

class TipsModel {
  final String title;
  final String key;

  final String content;
  final Uint8List image;

  TipsModel({
    required this.key,
    required this.title,
    required this.content,
    required this.image,
  });

  factory TipsModel.fromMap(Map<String, dynamic> map) {
    return TipsModel(
      title: map["Title"],
      content: map["Content"],
      image: map["imagePath"],
      key: map["key"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "Title": title,
      "Content": content,
      "imagePath": image,
      "key": key,
      // "phoneNumber": phoneNumber,
      // "balance": balance,
      // "hasDetails": hasDetails,
      // // "phoneNumber": phoneNumber,
      // "profilePicture": profilePicture,
      // "name": name
    };
  }
}
