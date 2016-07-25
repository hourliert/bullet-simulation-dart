import 'dart:html';
import 'dart:math';

import 'package:bullet_simulation/game/shared/circle_model.dart';
import 'package:bullet_simulation/game/shared/stage_model.dart';

import 'game_renderer.dart';

class CanvasGameRenderer implements GameRenderer {
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;

  @override
  void createDom(Element parentElement) {
    _canvas = new CanvasElement(
        width: parentElement.client.width, height: parentElement.client.height);
    _ctx = _canvas.context2D;

    parentElement.append(_canvas);
  }

  @override
  void destroyDom() {
    _canvas.remove();
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _canvas.width = boundaries.width;
    _canvas.height = boundaries.height;
  }

  @override
  void clearStage(Stage _) {
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
  }

  @override
  void drawCircle(Circle circle) {
    _ctx.beginPath();
    _ctx.arc(circle.position.x, circle.position.y, circle.radius, 0, 2 * PI);
    _ctx.fillStyle = circle.color;
    _ctx.fill();
  }
}
