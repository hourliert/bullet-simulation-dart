import 'dart:html';

import 'package:bullet_simulation/scene/scene.dart';
import 'package:bullet_simulation/renderer/renderer.dart';
import 'package:bullet_simulation/renderer/canvas.dart';
import 'package:bullet_simulation/physic/engine.dart';

class Game {
  static Game _instance;

  DivElement _playground;
  Scene _scene;
  Renderer _renderer;
  PhysicEngine _engine;
  DateTime _lastFrameTime;

  factory Game() {
    if (_instance == null) {
      _instance = new Game._internal();
    }

    return _instance;
  }

  Game._internal() {
    _lastFrameTime = new DateTime.now();
    _playground = querySelector('#playground');

    // dependencies injection
    _scene = new Scene(_playground);
    _renderer = new CanvasRenderer(_scene);
    _engine = new PhysicEngine(_scene);

    //render loop
    window.requestAnimationFrame(_gameLoop);
  }

  void _gameLoop(num _) {
    DateTime now = new DateTime.now();
    Duration timeBudget = now.difference(_lastFrameTime);
    _lastFrameTime = now;

    _engine.nextPositions(timeBudget);
    _renderer.render();

    window.requestAnimationFrame(_gameLoop);
  }
}
