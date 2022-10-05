import 'package:flame/components.dart';

class BackpackComponent extends SpriteComponent {

  @override
  bool get isHud => true;

  BackpackComponent() : super(
    size: Vector2(80,160),
    position: Vector2(150, 60),
  );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('f03_backpack_set.png');
  }

}
