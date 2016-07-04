import 'package:bullet_simulation/game_objects/bullet.dart';

class BulletStore {
  List<Bullet> bullets;

  BulletStore() {
    bullets = [];
  }

  void addBullet(Bullet b) {
    bullets.add(b);
  }

  void removeBullet(Bullet b) {
    bullets.remove(b);
  }
}
