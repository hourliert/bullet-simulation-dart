import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'package:bullet_simulation/game_objects/bullet.dart';

class Scene {
  List<Bullet> bullets;
  MutableRectangle<int> dimensions;
  Stream<MutableRectangle<int>> onResize;

  DivElement dom;
  StreamController<MutableRectangle<int>> _controller;

  Scene(this.dom) {
    _controller = new StreamController<MutableRectangle<int>>();

    dimensions =
        new MutableRectangle<int>(0, 0, dom.offsetWidth, dom.offsetHeight);
    bullets = [];
    onResize = _controller.stream;

    window.onResize.listen(resizeScene);
    dom.onClick.listen(fireBullet);
  }

  get width => dimensions.width;
  get height => dimensions.height;

  resizeScene(Event _) {
    assert(dom != null);

    dimensions.width = dom.offsetWidth;
    dimensions.height = dom.offsetHeight;

    _controller.add(dimensions);
  }

  fireBullet(MouseEvent e) {
    addBullet(new Bullet(e.client.x, e.client.y));
  }

  addBullet(Bullet b) {
    bullets.add(b);
  }

  removeBullet(Bullet b) {
    bullets.remove(b);
  }
}
