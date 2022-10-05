import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../f03_main_menu/view.dart';

import 'logic.dart';
import 'state.dart';

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  final logic = Get.put(SplashLogic());
  final SplashState state = Get.find<SplashLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlameSplashScreen(
        showBefore: (BuildContext context) {
          return const Text('Before logo');
        },
        showAfter: (BuildContext context) {
          return const Text('After logo');
        },
        theme: FlameSplashTheme.dark,
        onFinish: (context) => Get.offAll(() => GamePage()),
      ),
    );
  }
}


