import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:heartly/pages/splash/splash_page.dart';

class RouteHelpers{
  static const String initial = "/";

  static String getInitial() => '$initial';


  static List<GetPage> routes = [
    GetPage(
      name: initial,
      page: () => SplashPage(),
      transition: Transition.native,
    ),


  ];
}