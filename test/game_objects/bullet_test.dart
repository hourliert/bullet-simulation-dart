import 'dart:math';

import "package:test/test.dart";

import 'package:bullet_simulation/game_objects/bullet.dart';

void main() {
  test("new Bullet() creates a new bullet", () {
    Bullet b = new Bullet(15, 10);

    expect(b.id, equals(0));
    expect(b.position, new Point<int>(15, 10));
  });
}
