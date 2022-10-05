import 'dart:ui';
import 'package:flame/components.dart';
import 'f12_assets_loader.dart';



enum DirectionAnimationEnum {
  idleLeft,
  idleRight,
  idleUp,
  idleDown,
  idleTopLeft,
  idleTopRight,
  idleDownLeft,
  idleDownRight,
  runUp,
  runRight,
  runDown,
  runLeft,
  runUpLeft,
  runUpRight,
  runDownLeft,
  runDownRight,
  custom,
}

/// Class responsible to manager animation on `SimplePlayer` and `SimpleEnemy`
class DirectionAnimation {
  late SpriteAnimation idleLeft;
  late SpriteAnimation idleRight;
  late SpriteAnimation runLeft;
  late SpriteAnimation runRight;

  SpriteAnimation? idleUp;
  SpriteAnimation? idleDown;
  SpriteAnimation? idleUpLeft;
  SpriteAnimation? idleUpRight;
  SpriteAnimation? idleDownLeft;
  SpriteAnimation? idleDownRight;
  SpriteAnimation? runUp;
  SpriteAnimation? runDown;
  SpriteAnimation? runUpLeft;
  SpriteAnimation? runUpRight;
  SpriteAnimation? runDownLeft;
  SpriteAnimation? runDownRight;

  // Map<String, SpriteAnimation> others = {};

  final _loader = AssetsLoader();

  late SpriteAnimation current ;
  late DirectionAnimationEnum currentType = DirectionAnimationEnum.idleRight;
  // AnimatedObjectOnce? _fastAnimation;
  Vector2 position  = Vector2.all(0);
  Vector2 size  = Vector2.all(32);
  bool runToTheEndFastAnimation = false;

  double opacity = 1.0;

  DirectionAnimation({
    required Future<SpriteAnimation> idleLeft,
    required Future<SpriteAnimation> idleRight,
    required Future<SpriteAnimation> runRight,
    required Future<SpriteAnimation> runLeft,
    Future<SpriteAnimation>? idleUp,
    Future<SpriteAnimation>? idleDown,
    Future<SpriteAnimation>? idleUpLeft,
    Future<SpriteAnimation>? idleUpRight,
    Future<SpriteAnimation>? idleDownLeft,
    Future<SpriteAnimation>? idleDownRight,
    Future<SpriteAnimation>? runUp,
    Future<SpriteAnimation>? runDown,
    Future<SpriteAnimation>? runUpLeft,
    Future<SpriteAnimation>? runUpRight,
    Future<SpriteAnimation>? runDownLeft,
    Future<SpriteAnimation>? runDownRight,
    // Map<String, Future<SpriteAnimation>>? others,
  }) {
    _loader.add(AssetToLoad(idleLeft, (value) => this.idleLeft = value));
    _loader.add(AssetToLoad(idleRight, (value) => this.idleRight = value));
    _loader.add(AssetToLoad(idleDown, (value) => this.idleDown = value));
    _loader.add(AssetToLoad(idleUp, (value) => this.idleUp = value));
    _loader.add(AssetToLoad(idleUpLeft, (value) => this.idleUpLeft = value));
    _loader.add(AssetToLoad(idleUpRight, (value) => this.idleUpRight = value));
    _loader.add(AssetToLoad(idleDownLeft, (value) => this.idleDownLeft = value));
    _loader.add(AssetToLoad(idleDownRight, (value) => this.idleDownRight = value));
    _loader.add(AssetToLoad(runUp, (value) => this.runUp = value));
    _loader.add(AssetToLoad(runRight, (value) => this.runRight = value));
    _loader.add(AssetToLoad(runDown, (value) => this.runDown = value));
    _loader.add(AssetToLoad(runLeft, (value) => this.runLeft = value));
    _loader.add(AssetToLoad(runUpLeft, (value) => this.runUpLeft = value));
    _loader.add(AssetToLoad(runUpRight, (value) => this.runUpRight = value));
    _loader.add(AssetToLoad(runDownLeft, (value) => this.runDownLeft = value));
    _loader.add(AssetToLoad(runDownRight, (value) => this.runDownRight = value));

    // others?.forEach((key, anim) {
    //   _loader.add(AssetToLoad(anim, (value) {
    //     return this.others[key] = value;
    //   }));
    // });
  }

  Future<void> onLoad() async {
    current = this.idleRight;
    return _loader.load();
  }

  // SimpleAnimationEnum? get currentType => _currentType;
  /// Method used to play specific default animation
  void play(DirectionAnimationEnum animation) {
    currentType = animation;
    // if (!runToTheEndFastAnimation) {
    //   _fastAnimation = null;
    // }
    switch (animation) {
      case DirectionAnimationEnum.idleLeft:
        current = idleLeft;
        break;
      case DirectionAnimationEnum.idleRight:
        current = idleRight;
        break;
      case DirectionAnimationEnum.idleUp:
        if (idleUp != null) current = idleUp!;
        break;
      case DirectionAnimationEnum.idleDown:
        current = idleDown!;
        break;
      case DirectionAnimationEnum.idleTopLeft:
        current = idleUpLeft!;
        break;
      case DirectionAnimationEnum.idleTopRight:
        current = idleUpRight!;
        break;
      case DirectionAnimationEnum.idleDownLeft:
        current = idleDownLeft!;
        break;
      case DirectionAnimationEnum.idleDownRight:
        current = idleDownRight!;
        break;
      case DirectionAnimationEnum.runUp:
        current = runUp!;
        break;
      case DirectionAnimationEnum.runRight:
        current = runRight;
        break;
      case DirectionAnimationEnum.runDown:
        current = runDown!;
        break;
      case DirectionAnimationEnum.runLeft:
        current = runLeft;
        break;
      case DirectionAnimationEnum.runUpLeft:
        current = runUpLeft!;
        break;
      case DirectionAnimationEnum.runUpRight:
        current = runUpRight!;
        break;
      case DirectionAnimationEnum.runDownLeft:
        current = runDownLeft!;
        break;
      case DirectionAnimationEnum.runDownRight:
        current = runDownRight!;
        break;
      case DirectionAnimationEnum.custom:
        break;
    }
  }

  // /// Method used to play specific animation registred in `others`
  // void playOther(String key) {
  //   if (others.containsKey(key) == true) {
  //     if (!runToTheEndFastAnimation) {
  //       _fastAnimation = null;
  //     }
  //     _current = others[key];
  //     _currentType = SimpleAnimationEnum.custom;
  //   }
  // }

  // /// Method used to play animation once time
  // Future playOnce(
  //     Future<SpriteAnimation> animation, {
  //       VoidCallback? onFinish,
  //       bool runToTheEnd = false,
  //     }) async {
  //   if (position != null) {
  //     runToTheEndFastAnimation = runToTheEnd;
  //     final anim = AnimatedObjectOnce(
  //       position: position!,
  //       animation: animation,
  //       onFinish: () {
  //         onFinish?.call();
  //         _fastAnimation = null;
  //       },
  //     );
  //     await anim.onLoad();
  //     _fastAnimation = anim;
  //   }
  // }

  /// Method used to register new animation in others
  // Future<void> addOtherAnimation(
  //     String key,
  //     Future<SpriteAnimation> animation,
  //     ) async {
  //   others[key] = await animation;
  // }

  void render(Canvas canvas) {
    // if (position == null) return;
    // if (_fastAnimation != null) {
    //   _fastAnimation?.render(canvas);
    // } else {
    current.getSprite().paint.color = current.getSprite().paint.color.withOpacity(opacity);
    current.getSprite().render(canvas, position: position, size: size );
    // }
  }


  void update(double dt, Vector2 position) {
    this.position = position;
    // _fastAnimation?.opacity = opacity;
    // _fastAnimation?.position = position;
    // _fastAnimation?.update(dt);
    current.update(dt);
  }


}
