import 'package:flame/components.dart';
import 'package:flame/layers.dart';
import 'package:flutter/material.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';

class BackgroundLayer extends PreRenderedLayer  {

  final Color color = const Color(0xFF263238) ;
  // @override
  int get priority => LayerPriority.background;

  BackgroundLayer() {
    preProcessors.add(ShadowProcessor());
  }
  @override
  void drawLayer() {
    canvas.save();
    canvas.drawColor(color, BlendMode.src);
    canvas.restore();
  }
}


