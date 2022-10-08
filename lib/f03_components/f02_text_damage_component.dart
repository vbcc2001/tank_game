import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/cupertino.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';

import '../f06_pages/f04_scene_01/game.dart';


enum DirectionTextDamage { left, right, random, none }

class TextDamageComponent extends TextComponent with HasGameRef<MyGame> {
  final DirectionTextDamage direction;
  final double maxDownSize;
  late double _initialY;
  late double _velocity;
  final double gravity;
  double _moveAxisX = 0;
  final bool onlyUp;
  @override
  int get priority => LayerPriority.components;

  TextDamageComponent( String text,
    Vector2 position, {
    this.onlyUp = false,
    TextStyle? style,
    double initVelocityTop = -4,
    this.maxDownSize = 20,
    this.gravity = 0.5,
    this.direction = DirectionTextDamage.random,
  }) : super(
          text:text,
          textRenderer: TextPaint(style: style ?? const TextStyle(), ),
          position: position,
        ) {
    _initialY = position.y;
    _velocity = initVelocityTop;
    switch (direction) {
      case DirectionTextDamage.left:
        _moveAxisX = 1;
        break;
      case DirectionTextDamage.right:
        _moveAxisX = -1;
        break;
      case DirectionTextDamage.random:
        _moveAxisX = Random().nextInt(100) % 2 == 0 ? -1 : 1;
        break;
      case DirectionTextDamage.none:
        break;
    }
  }

  @override
  void render(Canvas c) {
    // if (shouldRemove) return;
    super.render(c);
  }
  @override
  void update(double t) {
    // if (shouldRemove) return;
    position.y += _velocity;
    position.x += _moveAxisX;
    _velocity += gravity;
    if (onlyUp && _velocity >= 0) {
      removeFromParent();
    }
    if (position.y > _initialY + maxDownSize) {
      removeFromParent();
    }
    super.update(t);
  }
}
