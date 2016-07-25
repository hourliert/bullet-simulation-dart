import 'dart:async';
import 'dart:math';

import 'package:angular2/core.dart';

import 'package:bullet_simulation/shared/list_service.dart';
import 'package:bullet_simulation/shared/bullet_model.dart';

import 'circle_model.dart';
import 'stage_model.dart';

/// A base class for representing a 2D game renderer
@Injectable()
class RendererService {
  /// bullet radius
  static const int bulletRadius = 4;

  /// The bullet color
  static const String bulletColor = 'red';

  ListService<Bullet> _bulletService;

  StreamController<Stage> _onBeforeRenderController;
  StreamController<Circle> _onRenderCircleController;

  RendererService(this._bulletService) {
    _onBeforeRenderController = new StreamController<Stage>.broadcast();
    _onRenderCircleController = new StreamController<Circle>.broadcast();
  }

  Stream<Stage> get onBeforeRender => _onBeforeRenderController.stream;
  Stream<Circle> get onRenderCircle => _onRenderCircleController.stream;

  void render() {
    _onBeforeRenderController.add(new Stage());
    _bulletService.list.forEach(_renderBullet);
  }

  void _renderBullet(Bullet b) {
    _onRenderCircleController.add(new Circle(
        new Point<num>(
            b.position.x - bulletRadius / 2, b.position.y - bulletRadius / 2),
        b.radius ?? bulletRadius,
        b.color ?? bulletColor));
  }
}
