import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/tips_model.dart';

class SQLHelper extends GetxController implements GetxService{

  List<TipsModel> tipsList= [];
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        content TEXT,
        image TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Heartly.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

   Future<int> createItem(String title, String content, String imageData) async {
    final db = await SQLHelper.db();
    final TipsModel tipsModel = TipsModel(
      title: title,
      content: content,
      image: imageData,
    );


    final data = tipsModel.toMap();
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }


    Future<List<TipsModel>> getItems() async {
    final db = await SQLHelper.db();


    final List<Map<String, dynamic>> maps = await db.query('items', orderBy: "id");
    final data = List<TipsModel>.from(maps.map((map) => TipsModel.fromMap(map)));
    tipsList = data;
    update();

    // Convert List<Map<String, dynamic>> to List<TipsModel>
    return data;

  }


   Future<List<TipsModel>> getItem(int id) async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await  db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
    final data = List<TipsModel>.from(maps.map((map) => TipsModel.fromMap(map)));

    return data;

  }


   Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
      await getItems();
      update();
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}





