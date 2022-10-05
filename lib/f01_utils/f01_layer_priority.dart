class LayerPriority {
  static const int background = 110;  // 背景

  static const int mapBackground = 210;  // 背景
  static const int mapGird = 220; // 地图网格
  static const int map = 230; // 地图

  static const int mapDecoration = 310; //地图装饰
  static const int components = 320; //组件

  static const  int  highestPriority = 10000;
  static const  int  abovePriority = 10005;
  static const  int  lightingPriority = 10010;
  static const  int  colorFilterPriority = 10020;
  static const  int  selectorPriority = 10030;
  static const  int  interfacePriority = 10040;
  static const  int  joystickPriority = 10050;

  static int getComponentPriority(int bottom) {
    return components + bottom;
  }

}
