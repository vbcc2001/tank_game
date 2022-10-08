import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';
import '../f01_utils/f03_interval_tick.dart';
import '../f04_mixin/f02_component.dart';
import '../f04_mixin/f07_attackable.dart';
import '../f04_mixin/f09_movement.dart';
import '../f04_mixin/f11_lighting.dart';
import 'package:rive/rive.dart';

import '../f06_pages/f04_scene_01/game.dart';
import 'f03_rive_component.dart';
import 'f06_player_tank.dart';

// class FlyingAttackComponent extends PositionComponent with HasGameRef<MyGame>,MyComponent,Lighting,HasHitboxes,Collidable {
  class FlyingAttackComponent extends PositionComponent with HasGameRef<MyGame>,MyComponent,Lighting {
  final dynamic id;
  final Direction direction;
  final double speed = 200;
  final double mixDistance = 600;
  final double damage = 10;
  final AttackFromEnum attackFrom  = AttackFromEnum.player;
  // 位置
  Vector2 startPosition;
  // final bool withDecorationCollision;
  // final VoidCallback? onDestroyedObject;
  // final bool enableDiagonal;

  bool _isWallHit = false;
  bool _isCollision = false;

  final IntervalTick _timerVerifyCollision = IntervalTick(50);



  @override
  int get priority => LayerPriority.components;

  FlyingAttackComponent(this.id, this.direction, {required Vector2 position}):
    startPosition =  Vector2.copy(position),
    super(size:Vector2(54,14),position:position,anchor: Anchor.center){
      // addHitbox(HitboxRectangle());
    }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    RiveFile riveFile1 = await RiveFile.asset('assets/rives/bullet.riv');
    SimpleAnimation animationController =  SimpleAnimation('flying');
    RiveComponent a = RiveComponent(riveFile1, gameRef.context, animationController: animationController,artboardName:"01",size:Vector2(54,14));
    add(a);
    switch (direction) {
      case Direction.right:
        angle = 1 * pi;
        break;
      case Direction.up:
        angle = 0.5 * pi;
        break;
      case Direction.down:
        angle = -0.5 * pi;
        break;
    }
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // renderHitboxes(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // if (!_timerVerifyCollision.update(dt)) return;
    switch (direction) {
      case Direction.left:
        position.add(Vector2((speed * dt) * -1, 0));
        break;
      case Direction.right:
        position.add(Vector2((speed * dt), 0));
        break;
      case Direction.up:
        position.add(Vector2(0, (speed * dt) * -1));
        break;
      case Direction.down:
        position.add(Vector2(0, (speed * dt)));
        break;
    }

    if (_isWallHit) {
      removeFromParent();
      return;
    }
    if (_isCollision) {
      //
      removeFromParent();
      return;
    }
    if(position.distanceTo(startPosition)>600) removeFromParent();

  }
  // @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   if (other is ScreenCollidable) {
  //     _isWallHit = true;
  //     return;
  //   }
  //   if(other is PlayerTank || other is FlyingAttackComponent){
  //
  //   }else{
  //     _isCollision = true;
  //   }
  // }
}
