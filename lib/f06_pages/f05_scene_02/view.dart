import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide State;
import 'package:get/get.dart';
import 'game.dart';
import 'logic.dart';
import 'state.dart';

class GameScene02 extends StatelessWidget {
  GameScene02({Key? key}) : super(key: key);
  final Logic logic = Get.put(Logic());
  final State state = Get.find<Logic>().state;
  @override
  Widget build(BuildContext context) {
    return  GameWidget(
        game: MyGame2(context),
        mouseCursor:SystemMouseCursors.click
    );
  }
}

