import 'dart:math';
import 'dart:async';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

class PhysicEngine {
  Stream<Bullet> onBulletHitBorder;

  BulletStore _store;
  Scene _scene;
  StreamController<Bullet> _controller;

  PhysicEngine(this._store, this._scene) {
    _controller = new StreamController<Bullet>();

    onBulletHitBorder = _controller.stream;
  }

  void nextPositions(Duration timeBudget) {
    _store.bullets.forEach((Bullet b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Bullet b, Duration timeBudget) {
    if (_isBulletOutside(b)) {
      _controller.add(b);
    } else {
      b.position += new Point<int>(
          (b.speed * timeBudget.inMilliseconds * cos(b.angle)).toInt(),
          (b.speed * timeBudget.inMilliseconds * sin(b.angle)).toInt());
      // we slightly alter the bullet angle. we are using a gaussian function
      b.angle += exp(-pow((3 * b.speed - 3.5), 2)) / 10;
      // we slightly alter the bullet speed. we are using a linear function
      b.speed -= (b.speed - 0.1) / 90;
    }
  }

  bool _isBulletOutside(Bullet b) {
    return !_scene.dimensions.containsPoint(b.position);
  }
}
