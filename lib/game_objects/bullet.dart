import 'dart:math';

class Bullet {
  static num nextId = 0;
  static final Random rng = new Random(123456789);

  int id;

  Point<int> initialPosition;
  Point<int> position;

  num initialSpeed;
  num initialAngle;

  num speed;
  num angle;

  Bullet(int x, int y) {
    id = nextId++;

    initialPosition = new Point<int>(x, y);
    this.initialSpeed = (rng.nextDouble() * 0.5) + 0.5;
    this.initialAngle = rng.nextDouble() * 2 * PI;

    this._copyInitial();
  }

  @override
  String toString() {
    return '''
      === Bullet ===
      Id: $id
      Pos: $position
      Velocity: $speed
      Angle: $angle
    ''';
  }

  void _copyInitial() {
    position = new Point<int>(initialPosition.x, initialPosition.y);
    this.speed = this.initialSpeed;
    this.angle = this.initialAngle;
  }
}
