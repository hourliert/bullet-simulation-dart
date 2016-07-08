import 'dart:math';
import 'dart:async';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
class PhysicEngine {
  BulletStore _store;
  Scene _scene;
  StreamController<Bullet> _onBulletHitBorderStreamController;

  /// Creates a physic engine
  ///
  /// A [BulletStore] and a [Scene] must be injected into it.
  PhysicEngine(this._store, this._scene) {
    _onBulletHitBorderStreamController = new StreamController<Bullet>();
  }

  /// The stream that represents a bullet hitting a border
  Stream<Bullet> get onBulletHitBorder =>
      _onBulletHitBorderStreamController.stream;

  /// Computes the next bullet positions using a finit [timeBudget]
  void nextPositions(Duration timeBudget) {
    _store.bullets.forEach((Bullet b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Bullet b, Duration timeBudget) {
    if (!_scene.containPoints(b.position)) {
      _onBulletHitBorderStreamController.add(b);
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
}
