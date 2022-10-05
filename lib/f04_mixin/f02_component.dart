import 'package:flame/components.dart';
import '../f06_pages/f04_scene_01/game.dart';
mixin MyComponent on PositionComponent  {
  /// Param checks if this component is visible on the screen
  bool isVisible = false;
  /// Use to set opacity in render
  /// Range [0.0..1.0]
  double opacity = 1.0;
}
