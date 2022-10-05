import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';

class MapGirdLayer extends Component with HasGameRef<MyGame>  {

  Color color = const Color(0xFF263238) ;
  Size size = const Size(0,0);
  int column = 0;
  int row = 0 ;
  static const double gridSize = 32 ;
  //網格
  final paint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke //线
    ..color = const Color(0x22e1e9f0)
    ..strokeWidth = 0.5;
  @override
  int get priority => LayerPriority.mapGird;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    size = Size(gameRef.size.x,gameRef.size.y);
    row = ( gameRef.size.x / gridSize ).ceil() + 1;
    column = ( gameRef.size.y / gridSize ).ceil() + 1;
  }


  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.save();
    for (int i = 0; i < column-1; i++) {
      double dx = gameRef.camera.position.x;
      double dy = gridSize * ( i + (gameRef.camera.position.y/gridSize).ceil());
      canvas.drawLine(Offset(dx, dy), Offset(size.width+dx, dy), paint);
    }
    for (int i = 0; i < row-1; i++) {
      double dx = gridSize * (i + (gameRef.camera.position.x/gridSize).ceil());
      double dy = gameRef.camera.position.y;
      canvas.drawLine(Offset(dx, dy), Offset(dx, size.height+dy), paint);
    }
    canvas.restore();
  }
}


