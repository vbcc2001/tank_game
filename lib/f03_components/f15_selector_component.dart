import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import '../f01_utils/f01_layer_priority.dart';

class SelectorComponent extends PositionComponent {

  final textConfigRed = TextPaint( style: const TextStyle(color: Colors.green, fontSize: 10));
  @override
  int get priority => LayerPriority.selectorPriority;
  bool show = false;
  Paint paint = BasicPalette.green.withAlpha(100).paint();
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (show) {
      var rect = Rect.fromLTWH(position.x,position.y, 32.0, 32.0,);
      textConfigRed.render(canvas, 'X:${position.x}, Y:${position.y}', Vector2(position.x+32, position.y+32),);
      canvas.drawRect(rect, paint);
    }
  }
}