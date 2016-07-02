import 'dart:math';

import 'package:bullet_simulation/game_objects/bullet.dart';

abstract class Renderer {
  static const int bullet_radius = 4;
  static const String bullet_color = 'red';

  void resizeRenderer(Rectangle<int> rect);
  void render();
  void renderBullet(Bullet b);
}
