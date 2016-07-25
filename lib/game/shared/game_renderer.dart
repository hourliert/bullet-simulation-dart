import 'dart:html';
import 'package:bullet_simulation/game/shared/circle_model.dart';
import 'package:bullet_simulation/game/shared/stage_model.dart';

abstract class GameRenderer {
  void createDom(Element parentElement);
  void destroyDom();
  void updateSize(Rectangle<int> boundaries);
  void clearStage(Stage _);
  void drawCircle(Circle circle);
}
