import 'dart:math';

import 'package:bullet_simulation/scene/scene.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

class PhysicEngine {
  Scene _scene;

  PhysicEngine(this._scene);

  void nextPositions(Duration timeBudget) {
    _scene.bullets.forEach((Bullet b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Bullet b, Duration timeBudget) {
    if (_isBulletOutside(b)) {
      print('bullet outside');
    } else {
      b.position = new Point<int>(
          (b.position.x + b.speed * timeBudget.inMilliseconds * cos(b.angle))
              .toInt(),
          (b.position.y + b.speed * timeBudget.inMilliseconds * sin(b.angle))
              .toInt());
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
