
import 'dart:ui';

import 'package:flame/components.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f10_direction_animation.dart';
import '../f04_mixin/f07_attackable.dart';
import '../f04_mixin/f09_movement.dart';

class PlayerComponent extends PositionComponent with Attackable, Movement<DirectionAnimationEnum>{

  double maxStamina = 100.0;
  double stamina = 100;
  double maxSpeed = 100.0;

  final JoystickComponent joystick;
  @override
  int get priority => LayerPriority.components;
  PlayerComponent({
    required this.joystick,
    required Vector2 position,
    required Vector2 size,
    double life = 100,
    double speed = 100,
  }): super(position:position,size:size,){
    initLife(life);
    this.speed = speed;
    receivesAttackFrom = ReceivesAttackFromEnum.player;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      // angle = joystick.delta.screenAngle();
    }
  }
}

