import 'dart:html';
import 'dart:svg';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

import 'renderer.dart';

/// A 2D game renderer using the SVG API
class SvgRenderer implements Renderer {
  SvgElement _svg;

  DivElement _playground;
  BulletStore _store;
  Scene _scene;

  /// Creates a svg renderer
  ///
  /// A [DivElement], [BulletStore] and [Scene] must be injected into it.
  SvgRenderer(this._playground, this._store, this._scene) {
    _svg = new SvgElement.tag('svg');
    _svg.style.width = _scene.width.toString();
    _svg.style.height = _scene.height.toString();
  }

  @override
  void initialize() {
    _playground.append(_svg);
    _scene.onResize.listen(_resizeRenderer);
  }

  @override
  void render() {
    _clearRenderer();
    _store.bullets.forEach(_renderBullet);
  }

  void _clearRenderer() {
    while (_svg.hasChildNodes()) {
      _svg.firstChild.remove();
    }
  }

  void _renderBullet(Bullet b) {
    SvgElement circle = new SvgElement.tag('circle')
      ..attributes['cx'] = (b.position.x - Renderer.bulletRadius / 2).toString()
      ..attributes['cy'] = (b.position.y - Renderer.bulletRadius / 2).toString()
      ..attributes['r'] = Renderer.bulletRadius.toString()
      ..attributes['fill'] = Renderer.bulletColor;

    _svg.append(circle);
  }

  void _resizeRenderer(Scene scene) {
    _svg.style.width = scene.width.toString();
    _svg.style.height = scene.height.toString();
  }
}
