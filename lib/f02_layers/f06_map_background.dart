import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/widgets.dart' hide Image;
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';
import '../f03_components/f03_rive_component.dart';

import 'package:rive/rive.dart';
import '../f06_pages/f04_scene_01/game.dart';


class MapBackgroundLayer extends PositionComponent with HasGameRef<MyGame> {

  @override
  int get priority => LayerPriority.mapBackground;
  late RiveComponent riveComponent;
  late RiveComponent riveComponent2;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    RiveFile riveFile = await RiveFile.asset('assets/rives/sky.riv');
    SimpleAnimation animationController =  SimpleAnimation('wind');
    position = gameRef.camera.position;
    riveComponent = RiveComponent(riveFile, gameRef.context,artboardName:"02", animationController: animationController,size:Vector2(gameRef.size.x+20,gameRef.size.y+20),position: position);
    riveComponent.riveCanvas.offset = const Offset(-10,-10);
    riveComponent.riveCanvas.fit = BoxFit.fill;
    add(riveComponent);
    // RiveFile riveFile4 = await RiveFile.asset('assets/rives/sun.riv');
    // RiveComponent f = RiveComponent(riveFile4, gameRef.context,artboardName:"01", size:Vector2(100,100),position: position);
    // f.riveCanvas.offset =  const Offset(400,400);
    // add(f);
  }


  @override
  void update(double dt) {
    super.update(dt);
    position = gameRef.camera.position;
  }
}
