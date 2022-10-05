import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../f03_components/f06_player_tank.dart';
import '../f04_mixin/f01_pointer_detector.dart';
import '../f04_mixin/f11_lighting.dart';

import 'package:ordered_set/comparing.dart';
import 'package:ordered_set/ordered_set.dart';

/// CustomBaseGame created to use `Listener` to capture touch screen gestures.
/// Apply zoom in canvas.
/// Reorder components per time frame.
class MyGame extends FlameGame with FPSCounter,PointerDetector {
  /// 游戏上下文 Context
  final BuildContext context;
  /// 游戏玩家角色
  // final  player =  PlayerTank();
  final textConfigGreen = TextPaint(style: TextStyle(color: Colors.green, fontSize: 14));
  final textConfigRed = TextPaint( style: TextStyle(color: Colors.red, fontSize: 14));
  /// Used to show in the interface the FPS.
  bool get showFPS => false;
  // final bool showFPS = false;
  /// Components added by the [addLater] method
  final List<Component> _addLater = [];
  /// The list of components to be updated and rendered by the base game.
  OrderedSet<Component> components = OrderedSet( Comparing.on((c1) => c1.priority) );
  // List<ObjectCollision> collisions = List.empty();

  static const int INTERVAL_UPDATE_CACHE = 200;
  static const int INTERVAL_UPDATE_ORDER = 253;
  static const int INTERVAL_UPDATE_COLLISIONS = 1003;

  /// 需要显示的组件
  Iterable<Component> visibleComponents = List.empty();
  /// 需要显示的碰撞元素
  // List<ObjectCollision> visibleCollisions = List.empty();
  /// 需要显示的灯光元素
  Iterable<Lighting> visibleLights = List.empty();
  /// 网格数量
  int gridX = 0;
  int gridY = 0;

  MyGame(this.context):super();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    gridX = (size.x / 32).ceil();
    gridY = (size.y / 32).ceil();
    if (kDebugMode) {
      print("----------------------");
      print(size);
      print(gridX);
      print(gridY);
      print("+++++++++++++++++++++");
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (showFPS) {
      double fpsCount = fps(100);
      if (fpsCount >= 58) { textConfigGreen.render(canvas, 'FPS: ${fpsCount.toStringAsFixed(2)}', Vector2((canvasSize.x) - 100, 20),);}
      else { textConfigRed.render(canvas, 'FPS: ${fpsCount.toStringAsFixed(2)}', Vector2((canvasSize.x) - 100, 20),);}
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
  }
}
