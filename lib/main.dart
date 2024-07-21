import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:heartly/controllers/notification_controller.dart';

import 'package:heartly/helpers/dependencies.dart' as dep;
import 'package:heartly/routes/route_helpers.dart';
import 'package:heartly/utils/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelGroupKey: "heartly_channel_group",
      playSound: true,
      channelKey: "heartly",
      channelName: "heartly",
      channelDescription: "heartly notification channel",
    )
  ], channelGroups: [
    NotificationChannelGroup(
      channelGroupKey: "heartly_channel_group",
      channelGroupName: "heartly Group",
    ),
  ]);

  bool isAllowedToSendNotifications = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotifications){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  Gemini.init(
    apiKey: AppConstants.apiKey,
  );
  await dep.init();
  // Hive.box(AppConstants.storageBox).clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<NotificationController>();
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
