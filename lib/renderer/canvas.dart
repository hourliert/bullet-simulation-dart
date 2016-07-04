import 'dart:html';
import 'dart:math';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

import 'renderer.dart';

class CanvasRenderer implements Renderer {
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;

  DivElement _playground;
  BulletStore _store;
  Scene _scene;

  CanvasRenderer(this._playground, this._store, this._scene) {
    _canvas = new CanvasElement(width: _scene.width, height: _scene.height);
    _ctx = _canvas.context2D;
  }

  void initialize() {
    _playground.append(_canvas);
    _scene.onResize.listen(_resizeRenderer);
  }

  @override
  void render() {
    _ctx.clearRect(0, 0, _canvas.width, _canvas.height);
    _store.bullets.forEach(renderBullet);
  }

  void renderBullet(Bullet b) {
    _ctx.beginPath();
    _ctx.arc(
        b.position.x - Renderer.bullet_radius / 2,
        b.position.y - Renderer.bullet_radius / 2,
        Renderer.bullet_radius,
        0,
        2 * PI);
    _ctx.fillStyle = Renderer.bullet_color;
    _ctx.fill();
  }

  void _resizeRenderer(Scene scene) {
    _canvas.width = scene.width;
    _canvas.height = scene.height;
  }
}
