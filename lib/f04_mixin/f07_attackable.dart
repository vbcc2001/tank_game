import 'package:flame/components.dart';
import 'package:flutter/material.dart';

enum ReceivesAttackFromEnum { all, enemy, player }
enum AttackFromEnum { enemy, player}
/// Mixin responsible for adding damage-taking behavior to the component.
mixin Attackable on PositionComponent {
  /// Used to define which type of component can be damaged
  ReceivesAttackFromEnum receivesAttackFrom = ReceivesAttackFromEnum.all;
  double _life = 100;
  double _maxLife = 100;
  double attack = 20;
  double get maxLife => _maxLife;
  double get life => _life;
  set life(double life) => _life = life;
  void die() => _life=0;
  bool get isDead => _life<=0;
  ///初始化Life
  void initLife(double life) {
    _life = life;
    _maxLife = life;
  }
  /// 添加Life
  void addLife(double life) {
    _life = _life + life > maxLife ? maxLife : _life + life;
  }

  void damage(double damage) {
    _life = _life-damage>=0? _life-damage:0;
  }

  bool receivesAttackFromPlayer() {
    return receivesAttackFrom == ReceivesAttackFromEnum.all || receivesAttackFrom == ReceivesAttackFromEnum.player;
  }

  bool receivesAttackFromEnemy() {
    return receivesAttackFrom == ReceivesAttackFromEnum.all || receivesAttackFrom == ReceivesAttackFromEnum.player;
  }

  static const double widthBar = 32;
  static const double strokeWidth = 6;
  static const double xBar = 0+3;
  static const double yBar = 0-3;
  Paint lifePaint = Paint()..color = Colors.green..strokeWidth = strokeWidth..style = PaintingStyle.fill;
  Paint maxLifePaint = Paint()..color = Colors.blueGrey[800]!..strokeWidth = strokeWidth..style = PaintingStyle.fill;
  void drawDefaultLifeBar(Canvas canvas){
    /********************** drawLife ************************/
    canvas.drawLine(const Offset(xBar, yBar), const Offset(xBar + widthBar, yBar), maxLifePaint);
    double currentBarLife = (life * widthBar) / maxLife;
    if ( currentBarLife > widthBar * 2 / 3 )  {
      lifePaint.color = Colors.green;
    } else if ( currentBarLife > widthBar / 3 ) {
      lifePaint.color = Colors.yellow;
    } else {
      lifePaint.color = Colors.red;
    }
    canvas.drawLine(const Offset(xBar, yBar), Offset(xBar + currentBarLife, yBar), lifePaint);
  }
}
