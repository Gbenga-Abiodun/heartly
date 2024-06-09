import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_pixel/utilities/index.dart';
import 'package:get/get.dart';
import 'package:heartly/helpers/dependencies.dart' as dep;
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/app_constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  Gemini.init(
    apiKey: AppConstants.apiKey,
  );
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.storageBox);

  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heartly',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "blackBerry",
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ),
        useMaterial3: true,
      ),
      getPages: RouteHelpers.routes,
      initialRoute: RouteHelpers.getInitial(),
    );
  }
}
