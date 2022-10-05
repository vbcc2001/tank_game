import 'package:flutter/material.dart';

import 'f02_component.dart';

mixin Lighting on MyComponent  {

  /// Radius of the lighting
  /// 灯光半径
  double radius = 0;

  /// Color of the lighting
  /// 灯光颜色
  Color color = Colors.white;

  /// Enable pulse effect in lighting
  /// 是否支持灯光脉冲 ，默认 false
  final bool withPulse = false;

  /// Configure variation in pulse effect
  /// 脉冲效果参数 默认 0.1
  final double pulseVariation = 0.1;

  /// Configure speed in pulse effect
  /// 脉冲速度 默认 1
  final double pulseSpeed = 1;

  /// Configure curve in pulse effect
  /// 脉冲曲线
  final Curve pulseCurve = Curves.decelerate;

  /// Configure blur in lighting
  /// 模糊边界 默认 20
  double blurBorder = 20  ;

  /// 脉冲动画
  PulseAnimation _pulseAnimation  =  PulseAnimation();

  @override
  void update(double dt) {
    super.update(dt);
    _pulseAnimation.update(dt);
  }

  double get valuePulse => _pulseAnimation.value;
}
/// 脉冲动画效果
class PulseAnimation {
  final double speed;
  final Curve curve;
  double value = 0;
  bool _animIsReverse = false;
  double _controlAnim = 0;
  PulseAnimation({this.speed = 1, this.curve = Curves.decelerate});

  void update(double dt) {
    if (_animIsReverse) {
      _controlAnim -= dt * speed;
    } else {
      _controlAnim += dt * speed;
    }

    if (_controlAnim >= 1) {
      _controlAnim = 1;
      _animIsReverse = true;
    }
    if (_controlAnim <= 0) {
      _controlAnim = 0;
      _animIsReverse = false;
    }
    value = Curves.decelerate.transform(_controlAnim);
  }
}

