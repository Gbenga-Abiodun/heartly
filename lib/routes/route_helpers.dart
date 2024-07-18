import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:heartly/pages/device/connect_device_page.dart';
import 'package:heartly/pages/home/home_page.dart';
import 'package:heartly/pages/notifications/notification_page.dart';
import 'package:heartly/pages/splash/splash_page.dart';

class RouteHelpers{
  static const String initial = "/";

  static String getInitial() => '$initial';
  static const String homePage = "/home-page";

  static String getHomePage() => '$homePage';
  static const String notificationPage = "/notification-page";

  static String getNotificationPage() => '$notificationPage';
  static const String connectDevicePage = "/connect-device-page";

  static String getconnectDevicePage() => '$connectDevicePage';


  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => SplashPage(),
      transition: Transition.native,
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      transition: Transition.native,
    ),
    GetPage(
      name: homePage,
      page: () => HomePage(),
      transition: Transition.native,
    ),
    GetPage(
      name: notificationPage,
      page: () => NotificationPage(),
      transition: Transition.native,
    ),
    GetPage(
      name: connectDevicePage,
      page: () => ConnectDevicePage(),
      transition: Transition.native,
    ),


  ];
}