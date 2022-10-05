import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import '../f01_utils/f01_layer_priority.dart';
import '../f01_utils/f03_game.dart';

import '../f06_pages/f04_scene_01/game.dart';
import 'f01_tiles.dart';

class Map01 extends PositionComponent  with HasGameRef<MyGame>  {
  
  final Map<int, TilesComponent> tileset = {};
  late List<List<int>> matrix;
  static const double destTileSize = 64;
  final tileSize = Vector2.all(destTileSize);
  @override
  int get priority => LayerPriority.map;
  // @override
  // bool get isHud => true;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // debugMode =true;
    tileset[0] = TilesComponent("01",Vector2.all(0));
    tileset[1] = TilesComponent("02",Vector2.all(0));
    tileset[2] = TilesComponent("03",Vector2.all(0));
    // await tileset[0]?.onLoad();
    // await tileset[1]?.onLoad();
    matrix = await readCsvTile('assets/maps/map01.csv');


    for (var i = 0; i < matrix.length ; i++) {
      for (var j = 0; j < matrix[i].length; j++) {
        final element = matrix[i][j];
        if (element != -1) {
          var position = Vector2(j.toDouble(), i.toDouble())..multiply(Vector2.all(destTileSize));
          if(element==3)  add(TilesComponent("03",position));
          if(element==2)  add(TilesComponent("02",position));
          if(element==1)  add(TilesComponent("01",position));
        }
      }
    }
  }

  @override
  void preRender(Canvas canvas) {
    //计算显示范围
    // final int starX = (gameRef.camera.position.x / 64).ceil() ;
    // final int starY = (gameRef.camera.position.y / 64).ceil() ;
    // final int endX = starX + gameRef.gridX ;
    // final int endY =  starY +gameRef.gridY ;
    // //四周增加显示内容
    // final offsetStarX = starX-4>0?starX-4:0;
    // final offsetStarY = starY-4>0?starY-4:0;
    // final offsetEndX = endX + 4;
    // final offsetEndY = endY + 4;
    // for (var i = 0; i < 1 ; i++) {
    //   for (var j = 0; j < 1; j++) {
    //     final element = matrix[i][j];
    //     if (element != -1) {
    //       final sprite = tileset[element];
    //       sprite?.position = Vector2(i.toDouble(), j.toDouble())..multiply(Vector2.all(destTileSize));
    //       print(sprite?.position);
    //       sprite?.render(canvas);
    //     }
    //   }
    // }
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // TilesComponent("01",Vector2(641,641)).render(canvas);
  }
  //获取Csv格式Tile
  Future<List<List<int>>> readCsvTile(String fileName) async {
    final string = await rootBundle.loadString(fileName);
    List<List<int>> list = [];
    List<String> row  = string.split('\n');
    for (var element in row) {
      if(element.isNotEmpty && element.trim().isNotEmpty) {
        element = element.trim();
        element = element.lastIndexOf(',') == element.length-1 ? element.substring(0,element.length-1):element;
        List <String> index = element.split(',');
        List <int> rowInt = index.map(int.parse).toList();
        list.add(rowInt);
      }
    }
    return list;
  }
}