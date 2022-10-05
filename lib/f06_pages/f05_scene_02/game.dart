import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart' hide Image;
import '../../f01_utils/f03_game.dart';
import '../../f02_layers/f02_map_gird.dart';
import '../../f02_layers/f05_lighting.dart';

import '../../f03_components/f15_selector_component.dart';

import '../../f02_layers/f07_joystick.dart';
import 'f01_components/f01_player/main.dart';
import 'f01_components/f01_player/model.dart';


class MyGame2 extends MyGame with MouseMovementDetector,HasKeyboardHandlerComponents,HasTappables,HasDraggables {

  @override
  bool showFPS = true;
  @override
  Color backgroundColor() => const Color(0xFF263238);
  /// Game Player 游戏玩家角色
  final player =  Player(Model(),Vector2.all(0));
  /// 操作杆
  JoystickLayer joystickLayer = JoystickLayer();
  /// 需要显示的灯光元素
  LightingLayer lightingLayer = LightingLayer();
  /// 地图网格
  MapGirdLayer mapGird = MapGirdLayer();
  ///选择器
  SelectorComponent selectorComponent = SelectorComponent()..show = true;

  MyGame2(BuildContext context):super(context);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    /****************************************** Camera 设置 **************************************/
    // camera.viewport = FixedResolutionViewport(Vector2((gridX)*32+1, (gridY)*32+1));
    camera.viewport = FixedResolutionViewport(Vector2(size.y,size.y));
    // camera.viewport = FixedResolutionViewport(size);
    // camera.zoom =2;
    /****************************************** background **************************************/
    // var background = BackgroundLayer();
    // add(background);
    /****************************************** 地图网格 **************************************/
    add(mapGird);
    /****************************************** 灯光层 **************************************/
    add(lightingLayer);
    /****************************************** 鼠标选择层 **************************************/
    add(selectorComponent);
    /****************************************** 操作杆 **************************************/
    add(joystickLayer);

    add(player..position = Vector2.all(64) );
    camera.followComponent(player);
  }
  @override
  void onMouseMove(PointerHoverInfo info) {
    super.onMouseMove(info);
    final screenPosition = info.eventPosition.game;
    final double offsetX = screenPosition.x % 32;
    final double offsetY = screenPosition.y % 32;
    //偏移x,y
    final Vector2 v = Vector2(-offsetX,-offsetY)..add(screenPosition);
    selectorComponent.position.setFrom(v/2);
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // backgroundLayer.render(canvas);
  }
}


