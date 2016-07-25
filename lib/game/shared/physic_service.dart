import 'dart:math';
import 'dart:async';

import 'package:angular2/core.dart';

import 'package:bullet_simulation/shared/bullet_model.dart';
import 'package:bullet_simulation/shared/list_service.dart';

/// Manages the game physic
///
/// It computes scene bullet position according to a pseudo ballistic trajectory
@Injectable()
class PhysicService {
  ListService<Bullet> _bulletService;

  MutableRectangle<int> _boundaries;
  StreamController<Rectangle<int>> _onResizeController;
  StreamController<Bullet> _onBulletHitBorderStreamController;

  /// Creates a physic engine
  ///
  /// A [BulletStore] and a [Scene] must be injected into it.
  PhysicService(this._bulletService) {
    _boundaries = new MutableRectangle<int>(0, 0, 0, 0);

    _onResizeController = new StreamController<Rectangle<int>>.broadcast();
    _onBulletHitBorderStreamController =
        new StreamController<Bullet>.broadcast();
  }

  Rectangle<int> get boundaries => _boundaries;
  int get width => _boundaries.width;
  int get height => _boundaries.height;

  /// The stream that represents a bullet hitting a border
  Stream<Bullet> get onBulletHitBorder =>
      _onBulletHitBorderStreamController.stream;

  Stream<Rectangle<int>> get onResize => _onResizeController.stream;

  void updateBoundaries(int width, int height) {
    _boundaries.width = width;
    _boundaries.height = height;

    _onResizeController.add(_boundaries);
  }

  /// Computes the next bullet positions using a finit [timeBudget]
  void nextPositions(Duration timeBudget) {
    _bulletService.list.forEach((Bullet b) {
      _nextBulletPosition(b, timeBudget);
    });
  }

  void _nextBulletPosition(Bullet b, Duration timeBudget) {
    if (!_boundaries.containsPoint(b.position)) {
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
