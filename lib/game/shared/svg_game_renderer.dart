import 'dart:html';
import 'dart:math';
import 'dart:svg';

import 'package:bullet_simulation/game/shared/circle_model.dart';
import 'package:bullet_simulation/game/shared/stage_model.dart';

import 'game_renderer.dart';

class SvgGameRenderer implements GameRenderer {
  SvgElement _svg;

  @override
  void createDom(Element parentElement) {
    _svg = new SvgElement.tag('svg');
    _svg.style.width = parentElement.client.width.toString();
    _svg.style.height = parentElement.client.height.toString();

    parentElement.append(_svg);
  }

  @override
  void destroyDom() {
    _svg.remove();
  }

  @override
  void updateSize(Rectangle<int> boundaries) {
    _svg.style.width = boundaries.width.toString();
    _svg.style.height = boundaries.height.toString();
  }

  @override
  void clearStage(Stage _) {
    while (_svg.hasChildNodes()) {
      _svg.firstChild.remove();
    }
  }

  @override
  void drawCircle(Circle circle) {
    SvgElement svgCircle = new SvgElement.tag('circle')
      ..attributes['cx'] = (circle.position.x).toString()
      ..attributes['cy'] = (circle.position.y).toString()
      ..attributes['r'] = circle.radius.toString()
      ..attributes['fill'] = circle.color;

    _svg.append(svgCircle);
  }
}
