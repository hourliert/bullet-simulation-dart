import 'package:bullet_simulation/game_objects/bullet.dart';

/// Represents a bullet container
class BulletStore {
  List<Bullet> _bullets;

  /// Creates an empty bullet store
  BulletStore() {
    _bullets = new List<Bullet>();
  }

  /// Gets the bullet list
  List<Bullet> get bullets => _bullets;

  /// Adds a bullet to the store
  void add(Bullet b) {
    _bullets.add(b);
  }

  /// Removes the specified bullet from the store
  void remove(Bullet b) {
    _bullets.remove(b);
  }
}
