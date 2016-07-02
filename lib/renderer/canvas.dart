import 'dart:html';
import 'dart:math';

import 'package:bullet_simulation/scene/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

import 'renderer.dart';

class CanvasRenderer implements Renderer {
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;

  Scene _scene;

  CanvasRenderer(this._scene) {
    _canvas = new CanvasElement(width: _scene.width, height: _scene.height);
    _scene.dom.append(_canvas);
    _ctx = _canvas.context2D;

    _scene.onResize.listen(resizeRenderer);
  }

  @override
  void resizeRenderer(Rectangle<int> rect) {
    _canvas.width = rect.width;
    _canvas.height = rect.height;
  }

  @override
  void render() {
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    _scene.bullets.forEach(renderBullet);
  }

  @override
  void renderBullet(Bullet b) {
    _ctx.beginPath();
    _ctx.arc(b.x - Renderer.bullet_radius, b.y - Renderer.bullet_radius,
        Renderer.bullet_radius, 0, 2 * PI);
    _ctx.fillStyle = Renderer.bullet_color;
    _ctx.fill();
  }
}
