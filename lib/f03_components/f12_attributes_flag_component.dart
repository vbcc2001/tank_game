import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class AttributesFlagComponent extends SpriteComponent with Tappable {

  Sprite? spriteClosed;
  Sprite? spriteOpened;
  /// 点击 Callback
  final ValueChanged<bool>? onTapComponent;
  /// 打开标识
  bool isOpen = false;
  @override
  bool get isHud => true;

  AttributesFlagComponent(this.onTapComponent) : super(
    size: Vector2(40,40),
    position: Vector2(200, 20),
  );

  @override
  Future<void> onLoad() async {
    spriteClosed = await Sprite.load('f02_book.png');
    spriteOpened = await Sprite.load('f01_backpack.png');
    sprite = spriteClosed;
  }

  @override
  bool onTapDown(_) {
    isOpen = ! isOpen;
    isOpen ? sprite = spriteOpened : sprite = spriteClosed;
    onTapComponent?.call(isOpen);
    return true;
  }


}
