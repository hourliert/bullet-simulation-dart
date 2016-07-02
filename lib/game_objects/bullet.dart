import 'dart:math';

class Bullet {
  static num nextId = 0;
  static final Random rng = new Random(123456789);

  int id;

  num initialX;
  num initialY;
  num initialSpeed;
  num initialAngle;

  num x;
  num y;
  num speed;
  num angle;

  Bullet(num x, num y) {
    this.id = nextId++;

    this.initialX = x;
    this.initialY = y;
    this.initialSpeed = (rng.nextDouble() * 0.5) + 0.5;
    this.initialAngle = rng.nextDouble() * 2 * PI;

    this._copyInitial();
  }

  @override
  String toString() {
    return '''
      === Bullet ===
      Id: $id
      Pos: $x, $y
      Velocity: $speed
      Angle: $angle
    ''';
  }

  void _copyInitial() {
    this.x = this.initialX;
    this.y = this.initialY;
    this.speed = this.initialSpeed;
    this.angle = this.initialAngle;
  }
}
