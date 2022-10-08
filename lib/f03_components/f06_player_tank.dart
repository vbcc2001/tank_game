
import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' show Alignment, BuildContext, Colors;
import 'package:flutter/services.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f02_rive_canvas.dart';
import '../f01_utils/f03_game.dart';
import '../f01_utils/f06_audio.dart';
import '../f01_utils/f10_direction_animation.dart';
import '../f04_mixin/f02_component.dart';
import '../f04_mixin/f07_attackable.dart';
import '../f04_mixin/f09_movement.dart';
import '../f04_mixin/f11_lighting.dart';
import '../f05_map/f01_tiles.dart';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import '../f06_pages/f04_scene_01/game.dart';
import 'f01_flying_attack_component.dart';
import 'f04_bullet_component.dart';

// class PlayerTank extends PositionComponent with HasGameRef<MyGame1>,MyComponent,Lighting,KeyboardHandler,HasHitboxes,Collidable, Attackable {
class PlayerTank extends PositionComponent with HasGameRef<MyGame1>,MyComponent,Lighting,KeyboardHandler, Attackable {
  /// The file to draw on the canvas
  late RiveFile riveFile;
  /// If this is non Null, this will be drawn instead of [riveFile.mainArtboard]
  late String artboardName;
  /// If the [animationController] is non Null it will be automatically animated
  late RiveAnimationController fireAnimation = SimpleAnimation('fire');
  late RiveAnimationController runAnimation = SimpleAnimation('run');
  final alignment = Alignment.center;
  final fit = BoxFit.contain;

  late RiveCanvas riveCanvas;
  late Artboard artboard;
  late Vector2 canvasSize;

  static final spriteSize = Vector2(64, 64);
  final Vector2 velocity = Vector2(0, 0);

  double maxStamina = 100.0;
  double stamina = 100;
  double maxSpeed = 100.0;
  double speed = 100.0;
  Direction direction = Direction.right;
  Vector2 displacement = Vector2(0, 0);

  @override
  int get priority => LayerPriority.components;

  PlayerTank() : super(size:spriteSize,anchor:Anchor.center){
    // addHitbox(HitboxCircle());
  }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 添加 Tank 动画
    RiveFile riveFile = await RiveFile.asset('assets/rives/tank.riv');
    artboard =  riveFile.artboardByName("01")!;
    artboard.addController(fireAnimation);
    artboard.addController(runAnimation);
    riveCanvas = RiveCanvas(artboard: artboard, context: gameRef.context);
    artboard.advance(0);
    stopFireAnimation();
    stopRunAnimation();
    // 添加 Light
    radius=width * 1.5;
    blurBorder= width * 1.5;
    color=Colors.transparent;
    gameRef.lightingLayer.lights.add(this);

  }

  void startFireAnimation(){
    fireAnimation.isActive = true;
    MyAudio.instance.playSfx('sfx/jump14.wav');
    if(direction == Direction.right){
      gameRef.add(BulletComponent("1", direction,position:Vector2(position.x+64,position.y-12)));
    }else if(direction == Direction.left) {
      gameRef.add(BulletComponent("1", direction, position: Vector2(position.x - 64, position.y-12)));
    }else if(direction == Direction.up) {
      gameRef.add(BulletComponent("1", direction, position: Vector2(position.x-12 , position.y -64)));
    }else if(direction == Direction.down) {
      gameRef.add(BulletComponent("1", direction, position: Vector2(position.x+12 , position.y +64)));
    }
  }
  void startFire2Animation(){
    fireAnimation.isActive = true;
    // 动画
    Future<SpriteAnimation> attackRangeAnimation;
    // 攻击方向
    // Direction attackDirection = direction;
    if(direction == Direction.right){
      gameRef.add(FlyingAttackComponent("1", direction,position:Vector2(position.x+64,position.y-12)));
    }else if(direction == Direction.left) {
      gameRef.add(FlyingAttackComponent("1", direction, position: Vector2(position.x - 64, position.y-12)));
    }else if(direction == Direction.up) {
      gameRef.add(FlyingAttackComponent("1", direction, position: Vector2(position.x-12 , position.y -64)));
    }else if(direction == Direction.down) {
      gameRef.add(FlyingAttackComponent("1", direction, position: Vector2(position.x+12 , position.y +64)));
    }
  }
  void stopFireAnimation() => fireAnimation.isActive = false;

  void startRunAnimation() => runAnimation.isActive = true;
  void stopRunAnimation() => runAnimation.isActive = false;

  @override
  void update(double dt) {
    super.update(dt);
    artboard.advance(dt);
    if (!gameRef.joystickLayer.joystick.delta.isZero()) {
      displacement = gameRef.joystickLayer.joystick.relativeDelta * speed * dt;
      position.add(gameRef.joystickLayer.joystick.relativeDelta * speed * dt);
      // angle = gameRef.joystick.delta.screenAngle();
      if(gameRef.joystickLayer.joystick.relativeDelta.x>=0 ){
        if(gameRef.joystickLayer.joystick.relativeDelta.x.abs()>gameRef.joystickLayer.joystick.relativeDelta.y.abs()){
          move();
        }else{
          gameRef.joystickLayer.joystick.relativeDelta.y>0?  down() : up();
        }
      }else if(gameRef.joystickLayer.joystick.relativeDelta.x<0 ){
        if(gameRef.joystickLayer.joystick.relativeDelta.x.abs()>gameRef.joystickLayer.joystick.relativeDelta.y.abs()){
          backMove();
        }else{
          gameRef.joystickLayer.joystick.relativeDelta.y>0?  down() : up();
        }
      }
    }else{
      //键盘
      displacement = velocity * speed * dt;
      position.add(velocity * (speed * dt));

    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    riveCanvas.draw(canvas, size.toSize());
  }

  @override
  void onRemove() {
    super.onRemove();
    stopFireAnimation();
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;
    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      velocity.x = isKeyDown ? -1 : 0;
      isKeyDown ? backMove() : backIdle() ;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      velocity.x = isKeyDown ? 1 : 0;
      isKeyDown ? move() : idle() ;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      velocity.y = isKeyDown ? -1 : 0;
      isKeyDown ? up() : upIdle() ;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      velocity.y = isKeyDown ? 1 : 0;
      isKeyDown ? down() : downIdle() ;
      return false;
    } else if (event.logicalKey == LogicalKeyboardKey.space) {
      isKeyDown ? startFireAnimation() : stopFireAnimation() ;
      return false;
      }
    return super.onKeyEvent(event, keysPressed);
  }

  void idle() {
    angle = 0;
    scale = Vector2(1,1);
    direction = Direction.right;
    stopRunAnimation();
  }
  void backIdle() {
    angle = 0;
    scale = Vector2(-1,1);
    direction = Direction.left;
    stopRunAnimation();
  }
  void upIdle() {
    angle = -0.5 * pi;
    scale = Vector2(1,1);
    direction = Direction.up;
    stopRunAnimation();
  }
  void downIdle() {
    angle = 0.5 * pi;
    scale = Vector2(1,1);
    direction = Direction.down;
    stopRunAnimation();
  }
  void move() {
    angle = 0;
    scale = Vector2(1,1);
    direction = Direction.right;
    startRunAnimation();
  }
  void backMove() {
    angle = 0;
    scale = Vector2(-1,1);
    direction = Direction.left;
    startRunAnimation();
  }
  void up() {
    angle = -0.5 * pi;
    scale = Vector2(1,1);
    direction = Direction.up;
    startRunAnimation();
  }
  void down() {
    angle = 0.5 * pi;
    scale = Vector2(1,1);
    direction = Direction.down;
    startRunAnimation();
  }
  // @override
  // void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  //   if (other is Collidable) {
  //     position.add(-displacement);
  //   }
  // }
}


