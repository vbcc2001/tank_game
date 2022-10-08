import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f02_rive_canvas.dart';
import '../f01_utils/f03_game.dart';
import '../f03_components/f03_rive_component.dart';
import '../f04_mixin/f02_component.dart';
import 'package:rive/rive.dart';

import '../f06_pages/f04_scene_01/game.dart';

// class TilesComponent extends PositionComponent with HasGameRef<MyGame>,MyComponent,HasHitboxes,Collidable {
  class TilesComponent extends PositionComponent with HasGameRef<MyGame>,MyComponent {
  @override
  int get priority => LayerPriority.map;
  final String tileName;
  late RiveCanvas riveCanvas;

  TilesComponent(this.tileName, Vector2 position):super(size:Vector2(64,64),position:position){
    // addHitbox(HitboxRectangle());
  }
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // debugMode =true;
    RiveFile riveFile = await RiveFile.asset('assets/rives/wall.riv');
    var artboard =  riveFile.artboardByName(tileName)!;
    artboard.advance(0);
    riveCanvas = RiveCanvas(artboard: artboard, context: gameRef.context);

    // RiveComponent a = RiveComponent(riveFile1, gameRef.context, artboardName:tileName,size:size);
    // add(a);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    riveCanvas.draw(canvas, size.toSize());
  }

}
