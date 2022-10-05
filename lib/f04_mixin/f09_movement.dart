import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import '../f01_utils/f10_direction_animation.dart';

/// Mixin responsible for adding movements
enum Direction { left, right, up, down, upLeft, upRight, downLeft, downRight }
mixin Movement<T extends DirectionAnimationEnum> on PositionComponent {
  bool isIdle = true;
  double dtUpdate = 0;
  double speed = 100;
  Direction lastDirection = Direction.right;
  Direction lastDirectionHorizontal = Direction.right;
  DirectionAnimation? directionAnimation;
  // @override
  // set animations(Map<dynamic, SpriteAnimation> _animations) {
  //   // TODO: implement animations
  //   super.animations = _animations;
  // }


  // @override
  // void update(double dt) {
  //   super.update(dt);
  //   // dtUpdate = dt;
  //   // if (isVisible) {
  //   //   directionAnimation?.opacity = opacity;
  //   //   directionAnimation?.update(dt, position);
  //   // }
  // }
  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   directionAnimation?.render(canvas);
  // }
  @override
  Future<void> onLoad() async {
    await directionAnimation?.onLoad();
    idle();
    return super.onLoad();
  }
  void idle() {
    isIdle = true;
    switch (lastDirection) {
      case Direction.left:
        // if(T is DirectionAnimationEnum )  animations as Map<DirectionAnimationEnum, SpriteAnimation> ;
        // animations
        directionAnimation?.play(DirectionAnimationEnum.idleLeft);
        break;
      case Direction.right:
        directionAnimation?.play(DirectionAnimationEnum.idleRight);
        break;
      case Direction.up:
        directionAnimation?.play(DirectionAnimationEnum.idleUp);
        break;
      case Direction.down:
        directionAnimation?.play(DirectionAnimationEnum.idleDown);
        break;
      case Direction.upLeft:
        directionAnimation?.play(DirectionAnimationEnum.idleTopLeft);
        break;
      case Direction.upRight:
        directionAnimation?.play(DirectionAnimationEnum.idleTopRight);
        break;
      case Direction.downLeft:
        directionAnimation?.play(DirectionAnimationEnum.idleDownLeft);
        break;
      case Direction.downRight:
        directionAnimation?.play(DirectionAnimationEnum.idleDownRight);
        break;
    }
  }
  void moveUp() {
    position.add(Vector2(0, speed * dtUpdate * -1));
    isIdle = false;
    lastDirection = Direction.up;
    lastDirectionHorizontal = Direction.right;
    directionAnimation?.play(DirectionAnimationEnum.runUp);
    // this.current = DirectionAnimationEnum.runUp;
  }


  void moveDown() {
    position.add(Vector2(0, speed * dtUpdate * 1));
    isIdle = false;
    lastDirection = Direction.down;
    lastDirectionHorizontal = Direction.right;
    directionAnimation?.play(DirectionAnimationEnum.runDown);
    // this.current = DirectionAnimationEnum.runDown;
  }
  void moveLeft() {
    position.add(Vector2(speed * dtUpdate * -1, 0));
    isIdle = false;
    lastDirection = Direction.left;
    lastDirectionHorizontal = Direction.left;
    directionAnimation?.play(DirectionAnimationEnum.runLeft);
    // this.current = DirectionAnimationEnum.runLeft;
  }
  void moveRight() {
    position.add(Vector2(speed * dtUpdate * 1, 0));
    isIdle = false;
    lastDirection = Direction.right;
    lastDirectionHorizontal = Direction.right;
    directionAnimation?.play(DirectionAnimationEnum.runRight);
    // this.current = DirectionAnimationEnum.runRight;
  }

  void moveUpRight() {
    position.add(Vector2(speed * dtUpdate * 1, speed * dtUpdate * -1));
    isIdle = false;
    lastDirection = Direction.upRight;
    lastDirectionHorizontal = Direction.right;
    directionAnimation?.play(DirectionAnimationEnum.runUpRight);
    // this.current = DirectionAnimationEnum.runUpRight;
  }
  void moveUpLeft() {
    position.add(Vector2(speed * dtUpdate * -1, speed * dtUpdate * -1));
    isIdle = false;
    lastDirection = Direction.upLeft;
    lastDirectionHorizontal = Direction.left;
    directionAnimation?.play(DirectionAnimationEnum.runUpLeft);
    // this.current = DirectionAnimationEnum.runUpLeft;
  }
  void moveDownRight() {
    position.add(Vector2(speed * dtUpdate * 1, speed * dtUpdate * 1));
    isIdle = false;
    lastDirection = Direction.downRight;
    lastDirectionHorizontal = Direction.right;
    directionAnimation?.play(DirectionAnimationEnum.runDownRight);
    // this.current = DirectionAnimationEnum.runDownRight;
  }
  void moveDownLeft() {
    position.add(Vector2(speed * dtUpdate * -1, speed * dtUpdate * 1));
    isIdle = false;
    lastDirection = Direction.downLeft;
    lastDirectionHorizontal = Direction.left;
    directionAnimation?.play(DirectionAnimationEnum.runDownLeft);
    // this.current = DirectionAnimationEnum.runDownLeft;
  }
  /// Move Player to direction by radAngle
  void moveFromAngle(double angle) {
    double nextX = (speed * dtUpdate) * cos(angle);
    double nextY = (speed * dtUpdate) * sin(angle);
    Offset nextPoint = Offset(nextX, nextY);
    Offset diffBase = Offset(center.x + nextPoint.dx, center.y + nextPoint.dy,) - center.toOffset();
    position = Vector2(position.x + diffBase.dx, position.y + diffBase.dy);
    isIdle = false;
  }
  /// Move to direction by radAngle with dodge obstacles
  void moveFromAngleDodgeObstacles(double angle) {
    double innerSpeed = (speed * dtUpdate);
    double nextX = innerSpeed * cos(angle);
    double nextY = innerSpeed * sin(angle);
    Offset nextPoint = Offset(nextX, nextY);
    Offset diffBase = Offset(center.x + nextPoint.dx, center.y + nextPoint.dy) - center.toOffset();
    Offset newDiffBase = diffBase;

    // var collisionX = _verifyTranslateCollision(
    //   diffBase.dx,
    //   0,
    // );
    // var collisionY = _verifyTranslateCollision(
    //   0,
    //   diffBase.dy,
    // );

    // if (collisionX) {
    //   newDiffBase = Offset(0, newDiffBase.dy);
    // }
    // if (collisionY) {
    //   newDiffBase = Offset(newDiffBase.dx, 0);
    // }

    // if (collisionX && !collisionY && newDiffBase.dy != 0) {
    //   var collisionY = _verifyTranslateCollision(
    //     0,
    //     innerSpeed,
    //   );
    //   if (!collisionY) newDiffBase = Offset(0, innerSpeed);
    // }
    //
    // if (collisionY && !collisionX && newDiffBase.dx != 0) {
    //   var collisionX = _verifyTranslateCollision(
    //     innerSpeed,
    //     0,
    //   );
    //   if (!collisionX) newDiffBase = Offset(innerSpeed, 0);
    // }
    position = Vector2(position.x + newDiffBase.dx, position.y + newDiffBase.dy);
    isIdle = false;
  }
}
