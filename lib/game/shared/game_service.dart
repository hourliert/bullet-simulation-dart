import 'dart:html';
import 'dart:async';

import 'package:angular2/core.dart';

import 'package:bullet_simulation/game/shared/renderer_service.dart';
import 'package:bullet_simulation/game/shared/physic_service.dart';

@Injectable()
class GameService {
  RendererService _rendererService;
  PhysicService _physicService;

  DateTime _lastFrameTime;

  GameService(this._rendererService, this._physicService) {
    _lastFrameTime = new DateTime.now();
  }

  Future<Null> loop([num _]) async {
    DateTime now = new DateTime.now();
    Duration timeBudget = now.difference(_lastFrameTime);
    _lastFrameTime = now;

    _physicService.nextPositions(timeBudget);

    await window.animationFrame;
    _rendererService.render();

    loop();
  }
}
