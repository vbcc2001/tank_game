
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Animation;
import 'package:flutter/services.dart';
import '../../../../../f01_utils/f02_rive_canvas.dart';
import '../../../../../f04_mixin/f02_component.dart';
import '../../../../../f04_mixin/f07_attackable.dart';
import '../../../../../f04_mixin/f11_lighting.dart';

import '../../game.dart' ;
import 'animation.dart';
import 'model.dart';

class Player extends PositionComponent with HasGameRef<MyGame2>,MyComponent,Lighting,KeyboardHandler {

  /// 玩家数据
  final Model playerModel;
  /// 玩家动画
  late Animation playerAnimation;
  /// 移动偏移量
  final Vector2 velocity = Vector2(0, 0);

  late RiveCanvas riveCanvas;

  Player(this.playerModel,Vector2 position): super(position:position, size:Vector2.all(32),);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 添加 动画
    playerAnimation = Animation(playerModel.rivePath);
    await playerAnimation.onLoad();
    riveCanvas = RiveCanvas(artboard: playerAnimation.artboard, context: gameRef.context);
    // 添加 Light
    radius=width * 5;
    blurBorder= width * 5;
    color=Colors.transparent;
    gameRef.lightingLayer.lights.add(this);
  }
  @override
  void update(double dt) {
    super.update(dt);
    playerAnimation.artboard.advance(dt);
    if (!gameRef.joystickLayer.joystick.delta.isZero()) {
      position.add(gameRef.joystickLayer.joystick.relativeDelta * playerModel.speed * dt);
    }else{
      position.add(velocity *playerModel.speed*dt);
    }


  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    riveCanvas.draw(canvas, size.toSize());
  }
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;
      return false;
    }
    return super.onKeyEvent(event, keysPressed);
  }
}