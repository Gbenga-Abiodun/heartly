class TipsModel {
  late String title;
  // Id id = Isar.autoIncrement;
  late int? id;

  late String content;
  late String image;

  TipsModel({
    // this.id = 0,
    required this.title,
    required this.content,
    required this.image,
    this.id,
  });

  factory TipsModel.fromMap(Map<String, dynamic> map) {
    return TipsModel(
      title: map["title"],
      content: map["content"],
      image: map["image"], id: map["id"],
      // key: map["key"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "image": image,
      "id": id,
      // "key": key,

    };
  }
}



