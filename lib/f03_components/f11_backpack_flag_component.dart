import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
class BackpackFlagComponent extends  SpriteComponent with Tappable  {

  Sprite? spriteClosed;
  Sprite? spriteOpened;
  /// 点击 Callback
  final ValueChanged<bool>? onTapComponent;
  /// 打开标识
  bool isOpen = false;
  @override
  bool get isHud => true;

  BackpackFlagComponent(this.onTapComponent) : super(
    size: Vector2(40,40),
    position: Vector2(150, 20),
  );

  @override
  Future<void> onLoad() async {
    spriteClosed = await Sprite.load('f01_backpack.png');
    spriteOpened = await Sprite.load('f02_book.png');
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
