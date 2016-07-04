import 'dart:html';

import 'package:bullet_simulation/models/bullet_store.dart';
import 'package:bullet_simulation/models/scene.dart';
import 'package:bullet_simulation/renderer/renderer.dart';
import 'package:bullet_simulation/renderer/canvas.dart';
import 'package:bullet_simulation/physic/engine.dart';
import 'package:bullet_simulation/ui/popups_manager.dart';
import 'package:bullet_simulation/game_objects/bullet.dart';

class Game {
  DivElement _playground;
  DivElement _popupsContainer;

  BulletStore _store;
  Scene _scene;
  Renderer _renderer;
  PhysicEngine _engine;
  PopupsManager _popupsManager;
  DateTime _lastFrameTime;

  Game(this._playground, this._popupsContainer) {
    _lastFrameTime = new DateTime.now();

    // dependencies injection
    _scene = new Scene(_playground.offsetWidth, _playground.offsetHeight);
    _store = new BulletStore();
    _popupsManager = new PopupsManager(_popupsContainer);
    _renderer = new CanvasRenderer(_playground, _store, _scene);
    _engine = new PhysicEngine(_store, _scene);
  }

  void initialize() {
    _playground.onClick.listen(_fireBullet);
    _engine.onBulletHitBorder.listen(_onHitBulletHitBorder);
    window.onResize.listen(_resizeGame);

    _renderer.initialize();
  }

  void loop([num _]) {
    DateTime now = new DateTime.now();
    Duration timeBudget = now.difference(_lastFrameTime);
    _lastFrameTime = now;

    _engine.nextPositions(timeBudget);
    _renderer.render();

    window.animationFrame.then(loop);
  }

  void _fireBullet(MouseEvent e) {
    _store.addBullet(new Bullet(e.client.x, e.client.y));
  }

  void _onHitBulletHitBorder(Bullet b) {
    _popupsManager.addPopup(b);
    _store.removeBullet(b);
  }

  void _resizeGame([Event _]) {
    Rectangle<int> rect = new Rectangle<int>(
        0, 0, _playground.offsetWidth, _playground.offsetHeight);

    _scene.updateScene(rect);
  }
}
