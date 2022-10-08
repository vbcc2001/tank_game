import 'package:get/get.dart';
import '../f06_pages/f00_splash/view.dart';
import '../f06_pages/f05_scene_02/view.dart';
import '../f06_pages/f03_main_menu/view.dart';
import '../f06_pages/f04_scene_01/view.dart';



abstract class AppRoutes {
  static const root = '/';
  static const login = '/login';
  static const main = '/main';
  static const scene01 = '/scene01';
}

class AppPages {
  AppPages._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: AppRoutes.root, page: () => GameScene02()),
    GetPage(name: AppRoutes.login, page: () => SplashPage()),
    GetPage(name: AppRoutes.main, page: () => GamePage()),
    GetPage(name: AppRoutes.scene01, page: () => GameScene01()),
  ];
}



