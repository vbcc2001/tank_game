import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';

import '../f06_pages/f04_scene_01/game.dart';

/// The way you cand raw things like life bars, stamina and settings. In another words, anything that you may add to the interface to the game.
class JoystickLayer extends PositionComponent with  HasGameRef<MyGame> {

  @override
  PositionType positionType = PositionType.viewport;
  @override
  int get priority => LayerPriority.joystickPriority;

  late final JoystickComponent joystick;
  late final HudButtonComponent fireButton;

  JoystickLayer({ Vector2? position, Vector2? size}) : super(
      position:position,size: size
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: BasicPalette.blue.withAlpha(200).paint()),
      background: CircleComponent(radius: 60, paint: BasicPalette.blue.withAlpha(100).paint()),
      position: Vector2( 80, gameRef.size.y*gameRef.camera.zoom-80)
      // margin: const EdgeInsets.only(left: 20, bottom: 20),
    );
    add(joystick);

    fireButton = HudButtonComponent(
      button: CircleComponent(radius: 30 ,paint: BasicPalette.white.withAlpha(200).paint()),
      buttonDown: CircleComponent(radius: 30,paint: BasicPalette.green.withAlpha(200).paint()),
        position: Vector2( gameRef.size.x*gameRef.camera.zoom -100, gameRef.size.y*gameRef.camera.zoom-100)
      // margin: const EdgeInsets.only(right: 20, bottom: 20,),
      // onPressed: gameRef.player.startFireAnimation
    );
    add(fireButton);
  }
}
