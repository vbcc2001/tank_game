import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import '../../../../f01_utils/f06_audio.dart';
import 'package:rive/rive.dart';
import '../../f01_utils/f01_layer_priority.dart';
import '../../f01_utils/f03_game.dart';
import '../../f02_layers/f01_background.dart';
import '../../f02_layers/f02_map_gird.dart';
import '../../f02_layers/f03_interface.dart';
import '../../f02_layers/f04_color_filter.dart';
import '../../f02_layers/f05_lighting.dart';
import '../../f02_layers/f06_map_background.dart';
import '../../f02_layers/f07_joystick.dart';
import '../../f03_components/f01_flying_attack_component.dart';
import '../../f03_components/f03_rive_component.dart';
import '../../f03_components/f05_enemy_slime.dart';
import '../../f03_components/f06_player_tank.dart';
import '../../f03_components/f15_selector_component.dart';
import '../../f04_mixin/f09_movement.dart';
import '../../f05_map/f01_tiles.dart';
import '../../f05_map/f02_map_01.dart';

// class MyGame1 extends MyGame  with HasCollidables,KeyboardHandler,HasTappables,HasHoverables,MouseMovementDetector,HasDraggables {
class MyGame1 extends MyGame  with KeyboardHandler,HasTappables,HasHoverables,MouseMovementDetector,HasDraggables {

  @override
  bool showFPS = true;

  /// 界面层
  final interface = InterfaceLayer();
  /// Game Player
  /// 游戏玩家角色
  final  player =  PlayerTank();
  /// 操作杆
  JoystickLayer joystickLayer = JoystickLayer();
  /// 需要显示的灯光元素
  LightingLayer lightingLayer = LightingLayer();
  ///选择器
  SelectorComponent selectorComponent = SelectorComponent();
  ///图片资源
  static const List<String> _imageAssets = [
    'f04_player.png',
  ];


  MyGame1(BuildContext context):super(context);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    /****************************************** 初始化图片资源 **************************************/
    await images.loadAll(_imageAssets);
    /****************************************** Camera 设置 **************************************/
    // camera.viewport = FixedResolutionViewport(Vector2(64*16, 64*16));
    camera.viewport = FixedResolutionViewport(size);
    // camera.zoom =0.5;
    /****************************************** background **************************************/
    var background = BackgroundLayer();
    // add(background);
    /****************************************** Map Background **************************************/
    var mapBackgroundLayer = MapBackgroundLayer();
    add(mapBackgroundLayer);
    /****************************************** 地图网格 **************************************/
    var mapGird = MapGirdLayer();
    // add(mapGird);
    /****************************************** 灯光层 **************************************/
    // add(lightingLayer);
    /****************************************** ColorFilter **************************************/
    var _colorFilterLayer = ColorFilterLayer(Colors.blue,BlendMode.colorBurn);
    // add(_colorFilterLayer);
    /****************************************** 界面层 **************************************/
    add(interface);
    /****************************************** 鼠标选择层 **************************************/
    add(selectorComponent);
    /****************************************** 操作杆 **************************************/
    add(joystickLayer);
    /**************** ************************** map **************************************/
    var map = Map01();
    add(map);
    /****************************************** map 装饰物 **************************************/
    // MapDecoration mapDecoration = DungeonMap.decorations();
    // add(mapDecoration);
    /****************************************** enemies **************************************/
    add(EnemySlimeComponent(position:Vector2(400,350)));

    /****************************************** player **************************************/
    add(player..position = size/2);
    camera.followComponent(player);;

    RiveFile riveFile1 = await RiveFile.asset('assets/rives/grass.riv');
    SimpleAnimation animationController =  SimpleAnimation('wind');
    RiveComponent a = RiveComponent(riveFile1, context, animationController: animationController,artboardName:"01",size:Vector2(20,30),position: Vector2(300,300));
    add(a);
    RiveComponent b = RiveComponent(riveFile1, context,size:Vector2(20,30),position: Vector2(200,150));
    add(b);
    RiveFile riveFile3 = await RiveFile.asset('assets/rives/tree.riv');
    RiveComponent d = RiveComponent(riveFile3, context,artboardName:"02", size:Vector2(20,20),position: Vector2(100,400));
    add(d);
    SimpleAnimation animationController1 =  SimpleAnimation('wind');
    RiveComponent e = RiveComponent(riveFile3, context,artboardName:"01", animationController: animationController1,size:Vector2(20,20),position: Vector2(600,400));
    add(e);

    // add(MyCollidable(Vector2(600,300)));
    // RiveFile riveFile5 = await RiveFile.asset('assets/rives/wall.riv');
    // RiveComponent wall = RiveComponent(riveFile5, context,artboardName:"01", size:Vector2(64,64),position: Vector2(0,0));
    // add(wall);
    // RiveComponent wall2 = RiveComponent(riveFile5, context,artboardName:"02", size:Vector2(64,64),position: Vector2(64,0));
    // add(wall2);
    // RiveComponent wall3 = RiveComponent(riveFile5, context,artboardName:"02", size:Vector2(64,64),position: Vector2(64,64));
    // add(wall3);

    // add(TilesComponent("01",Vector2.all(64)));
  }

}


// class MyCollidable extends PositionComponent with HasGameRef<MyGame>, HasHitboxes, Collidable {
//   final _collisionColor = Colors.amber;
//   final _defaultColor = Colors.cyan;
//   bool _isWallHit = false;
//   bool _isCollision = false;
//   @override
//   int get priority => LayerPriority.components;
//
//   MyCollidable(Vector2 position) : super(
//     position: position,
//     size: Vector2.all(100),
//     anchor: Anchor.center,
//   ) {
//     addHitbox(HitboxCircle());
//   }
//
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (_isWallHit) {
//       removeFromParent();
//       return;
//     }
//     debugColor = _isCollision ? _collisionColor : _defaultColor;
//     _isCollision = false;
//   }
//
//   @override
//   void render(Canvas canvas) {
//     super.render(canvas);
//     renderHitboxes(canvas);
//   }
//
//   @override
//   void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
//     if (other is ScreenCollidable) {
//       _isWallHit = true;
//       return;
//     }
//     _isCollision = true;
//   }
// }