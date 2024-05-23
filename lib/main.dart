import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartly/routes/route_helpers.dart';

void main() {
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

        // colorScheme: ,
        // useMaterial3: true,
      ),
      getPages: RouteHelpers.routes,
      initialRoute: RouteHelpers.getInitial(),
    );
  }
}


