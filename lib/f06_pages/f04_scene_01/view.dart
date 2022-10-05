import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../f03_main_menu/game.dart';
import 'game.dart';
import 'logic.dart';
import 'state.dart';

class GameScene01 extends StatelessWidget {
  GameScene01({Key? key}) : super(key: key);
  final GameScene01Logic logic = Get.put(GameScene01Logic());
  final GameScene01State state = Get.find<GameScene01Logic>().state;
  @override
  Widget build(BuildContext context) {
    return  GameWidget(
        game: MyGame1(context),
        mouseCursor:SystemMouseCursors.click
    );
  }
}


