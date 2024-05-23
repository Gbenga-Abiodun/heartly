import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:heartly/pages/home/home_page.dart';
import 'package:heartly/pages/splash/splash_page.dart';

class RouteHelpers{
  static const String initial = "/";

  static String getInitial() => '$initial';
  static const String homePage = "/notification-page";

  static String getHomePage() => '$homePage';


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


  ];
}