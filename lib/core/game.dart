import 'dart:html';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/renderer/renderer.dart';
import 'package:bullet_simulation/renderer/canvas.dart';
import 'package:bullet_simulation/physic/engine.dart';
import 'package:bullet_simulation/ui/popups_manager.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

/// Represents a 2D bullet simulation game
class Game {
  DivElement _playground;
  DivElement _popupsContainer;

  BulletStore _store;
  Scene _scene;
  Renderer _renderer;
  PhysicEngine _engine;
  PopupsManager _popupsManager;
  DateTime _lastFrameTime;

  /// Creates a bullet simulation game
  ///
  /// 2 [DivElement] should be injected into it.
  ///
  /// The first is the playground container.
  /// It will be used to setup the dom and render the game.
  ///
  /// The second is the popup container.
  /// It will be used to display short popups during the game.
  Game(this._playground, this._popupsContainer) {
    _lastFrameTime = new DateTime.now();

    // dependencies injection
    _scene = new Scene(_playground.offsetWidth, _playground.offsetHeight);
    _store = new BulletStore();
    _popupsManager = new PopupsManager(_popupsContainer);
    _renderer = new CanvasRenderer(_playground, _store, _scene);
    _engine = new PhysicEngine(_store, _scene);
  }

  /// Initializes the game.
  ///
  /// It initializes sub-component and subscribes to streams.
  void initialize() {
    _renderer.initialize();

    _playground.onClick.listen(_fireBullet);
    _engine.onBulletHitBorder.listen(_onHitBulletHitBorder);
    window.onResize.listen(_resizeGame);
  }

  /// Computes and renders one game step.
  void loop([num _]) {
    DateTime now = new DateTime.now();
    Duration timeBudget = now.difference(_lastFrameTime);
    _lastFrameTime = now;

    _engine.nextPositions(timeBudget);
    _renderer.render();

    window.animationFrame.then(loop);
  }

  void _fireBullet(MouseEvent e) {
    _store.add(new Bullet(e.client.x, e.client.y));
  }

  void _onHitBulletHitBorder(Bullet b) {
    _popupsManager.addPopup(b);
    _store.remove(b);
  }

  void _resizeGame([Event _]) {
    _scene.updateScene(new Rectangle<int>(
        0, 0, _playground.offsetWidth, _playground.offsetHeight));
  }
}
