import 'dart:ui' show Image;

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

enum ButtonState { normal, selected, pressed }
class ButtonComponent extends SpriteGroupComponent<ButtonState> with Tappable,Hoverable {

  late final Function event;
  late final String  text;
  ButtonComponent(this.text, this.event);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(200, 50);
    var images = Images(prefix:'');
    // Image image = await images.load('assets/images/f07_logo.png');
    Image buttonHighLight = await images.load('assets/images/f08_button_high_light.png');
    Image buttonNormal = await images.load('assets/images/f09_button_normal.png');
    Image buttonPressed = await images.load('assets/images/f10_button_pressed.png');
    final selectedSprite =  Sprite(buttonHighLight);
    final normalSprite =  Sprite(buttonNormal);
    final pressedSprite =  Sprite(buttonPressed);
    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.selected: selectedSprite,
      ButtonState.normal: normalSprite,
    };
    current = ButtonState.normal;
    final textComponent = TextComponent(text: text, textRenderer: TextPaint(style: TextStyle(color: BasicPalette.white.color,fontSize: 22)),
    );
    add(textComponent..anchor = Anchor.center..position.setFrom(size/2));
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // mouseCursor.value = isHovered? SystemMouseCursors.grab :SystemMouseCursors.basic;
    if (current != ButtonState.pressed) {
      if (isHovered) {
        current = ButtonState.selected;
      } else {
        current = ButtonState.normal;
      }
    }
  }

  @override
  bool onTapDown(_) {
    current = ButtonState.pressed;
    event();
    return true;
  }

  @override
  bool onTapUp(_) {
    current = ButtonState.normal;
    return true;
  }

  @override
  bool onTapCancel() {
    current = ButtonState.normal;
    return true;
  }
}
