import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../f01_utils/f03_game.dart';
import 'package:rive/rive.dart';
import '../f06_pages/f04_scene_01/game.dart';
import 'f03_rive_component.dart';

class BarLifeComponent extends PositionComponent with HasGameRef<MyGame> {

  static const double widthBar = 90;
  static const double strokeWidth = 12;

  double maxLife = 100;
  double life = 0;
  double maxStamina = 100;
  double stamina = 0;

  Paint maxLifePaint = Paint()..color = Colors.blueGrey[800]!..strokeWidth = strokeWidth..style = PaintingStyle.fill;
  Paint lifePaint = Paint()..color = Colors.green..strokeWidth = strokeWidth..style = PaintingStyle.fill;
  Paint staminaPaint = Paint()..color = Colors.yellow..strokeWidth = strokeWidth..style = PaintingStyle.fill;

  @override
  bool get isHud => true;

  BarLifeComponent() : super(
    position: Vector2(20, 20),
    size: Vector2(120, 40),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    RiveFile riveFile = await RiveFile.asset('assets/rives/health_ui.riv');
    RiveComponent riveComponent = RiveComponent(riveFile, gameRef.context,artboardName:"01", size:size, position: Vector2(0, 0));
    add(riveComponent);
  }

  @override
  void update(double t) {
    super.update(t);
    // life = gameRef.player.life ;
    // maxLife = gameRef.player.maxLife;
    // maxStamina = gameRef.player.maxStamina;
    // stamina = gameRef.player.stamina;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    /********************** drawLife ************************/
    double xBar = position.x -20 + 25;
    double yBar = position.y -20 + 10;
    canvas.drawLine(Offset(xBar, yBar), Offset(xBar + widthBar, yBar), maxLifePaint);
    double currentBarLife = (life * widthBar) / maxLife;
    if ( currentBarLife > widthBar * 2 / 3 )  {
      lifePaint.color = Colors.green;
    } else if ( currentBarLife > widthBar / 3 ) {
      lifePaint.color = Colors.yellow;
    } else {
      lifePaint.color = Colors.red;
    }
    canvas.drawLine(Offset(xBar, yBar), Offset(xBar + currentBarLife, yBar), lifePaint);
    /********************** drawStamina ************************/
    double y2Bar = position.y -20 + 28;
    double currentBarStamina = (stamina * widthBar) / maxStamina;
    canvas.drawLine(Offset(xBar, y2Bar), Offset(xBar + currentBarStamina, y2Bar),staminaPaint);
  }
}
