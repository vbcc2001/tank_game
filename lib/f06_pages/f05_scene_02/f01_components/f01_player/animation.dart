import '../../../../f01_utils/f02_rive_canvas.dart';
import 'package:rive/rive.dart';

class Animation{
  String filePath;
  late RiveFile riveFile;
  late Artboard artboard;
  late RiveCanvas riveCanvas;
  final RiveAnimationController fireAnimation = SimpleAnimation('fire');
  final RiveAnimationController runAnimation = SimpleAnimation('run');

  Animation(this.filePath);
  Future<void> onLoad() async {
    riveFile = await RiveFile.asset(filePath);
    assert(riveFile.artboardByName("01")!=null,'riveFile must have artboard: 01 ');
    artboard = riveFile.artboardByName("01")!;
    artboard.addController(fireAnimation);
    artboard.addController(runAnimation);
    artboard.advance(0);
  }
}