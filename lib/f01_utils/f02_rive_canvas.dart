import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rive/rive.dart';

extension CanvasExtension on Canvas {
  /// draws a non animatable rive on a canvas
  void drawStaticRiveRect(Artboard artboard, Rect rect,RiveAnimationController animationController,BuildContext context) {
    RiveCanvas(artboard: artboard, offset: rect.topLeft, animationController: animationController, context: context).draw(this, rect.size);
  }
}

/// A helper class to paint a rive on a canvas
class RiveCanvas {
  Alignment alignment;
  BoxFit fit;
  Artboard artboard;
  RiveAnimationController? animationController;
  late RenderObject _renderObject;
  Offset offset;
  double _scaleX = 1.0, _scaleY = 1.0;
  BuildContext context;
  RiveCanvas(
    {this.alignment = Alignment.center,
      this.fit = BoxFit.contain,
      required this.artboard,
      required this.context,
      this.animationController,
      this.offset = Offset.zero}) {

    _renderObject = Rive(artboard: artboard, alignment: alignment, fit: fit).createRenderObject(context);
    if(animationController!=null){
      artboard.addController(animationController!);
    }

    _renderObject.attach(PipelineOwner());
  }

  void draw(Canvas canvas, Size size, {double scale = 1})  {
    _setBoxFit(canvas, size);
    _setAlignment(canvas, size, scale);
    artboard.draw(canvas);
  }

  void _setAlignment(Canvas canvas, Size size, double scale) {
    double posX, posY, aX, aY;
    double contentWidth = artboard.width;
    double contentHeight = artboard.height;

    aX = alignment.x + ((2 - (alignment.x + 1)) / 2);
    aY = alignment.y + ((2 - (alignment.y + 1)) / 2);

    posX = size.width * aX - contentWidth * _scaleX * aX;
    posY = size.height * aY - contentHeight * _scaleY * aY;

    canvas.translate(posX + offset.dx, posY + offset.dy);
  }

  void _setBoxFit(Canvas canvas, Size size) {
    final contentWidth = artboard.width;
    final contentHeight = artboard.height;
    _scaleX = 1.0;
    _scaleY = 1.0;

    switch (fit) {
      case BoxFit.fill:
        _scaleX = size.width / contentWidth;
        _scaleY = size.height / contentHeight;
        break;
      case BoxFit.contain:
        double minScale =
        min(size.width / contentWidth, size.height / contentHeight);
        _scaleX = _scaleY = minScale;
        break;
      case BoxFit.cover:
        double maxScale =
        max(size.width / contentWidth, size.height / contentHeight);
        _scaleX = _scaleY = maxScale;
        break;
      case BoxFit.fitHeight:
        double minScale = size.height / contentHeight;
        _scaleX = _scaleY = minScale;
        break;
      case BoxFit.fitWidth:
        double minScale = size.width / contentWidth;
        _scaleX = _scaleY = minScale;
        break;
      case BoxFit.none:
        _scaleX = _scaleY = 1.0;
        break;
      case BoxFit.scaleDown:
        double minScale =
        min(size.width / contentWidth, size.height / contentHeight);
        _scaleX = _scaleY = minScale < 1.0 ? minScale : 1.0;
        break;
    }
    canvas.scale(_scaleX, _scaleY);
  }
}
