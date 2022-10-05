import 'package:flame/components.dart';

class AttributesComponent extends SpriteComponent {

  @override
  bool get isHud => true;

  AttributesComponent() : super(
    size: Vector2(80,160),
    position: Vector2(200, 60),
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('f03_backpack_set.png');
  }

}
