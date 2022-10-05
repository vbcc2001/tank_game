import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'f01_utils/f04_logger.dart';
import 'f01_utils/f05_routes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscapeLeftOnly();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      title: "Tank Game",
      // theme: AppThemes.lightTheme,
      // darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      enableLog: true,
      logWriterCallback: Logger.write,
      initialRoute: AppRoutes.root, //initial
      getPages: AppPages.routes,
      // locale: LanguageController.to.getLocale,
      //fallbackLocale: TranslationService.fallbackLocale,
      // translations: Localization(),
    );
  }
}


