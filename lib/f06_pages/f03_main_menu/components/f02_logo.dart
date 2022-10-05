import 'dart:ui';
import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class LogoSprite extends SpriteComponent{

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Image image = await Flame.images.load('assets/images/f07_logo.png');
    var images = Images(prefix:'');
    Image image = await images.load('assets/images/f07_logo.png');
    sprite =  Sprite(image);
    size = Vector2(116, 54);
  }
}
