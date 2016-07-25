import 'dart:math';

/// Represents a bullet in the game
class Bullet {
  static num _nextId = 0;
  static final Random _rng = new Random(123456789);

  /// The unique id
  int id;

  /// The initial position
  Point<int> initialPosition;

  /// The current position
  Point<int> position;

  /// The initial speed
  num initialSpeed;

  /// The initial angle
  num initialAngle;

  /// The current speed
  num speed;

  /// The current angle
  num angle;

  int radius;
  String color;

  /// Creates a new bullet at a specific position
  ///
  /// [x] and [y] must be both positive integer
  Bullet(int x, int y) {
    assert(x >= 0);
    assert(y >= 0);

    id = _nextId++;

    initialPosition = new Point<int>(x, y);
    this.initialSpeed = (_rng.nextDouble() * 0.5) + 0.5;
    this.initialAngle = _rng.nextDouble() * 2 * PI;

    position = new Point<int>(x, y);
    this.speed = this.initialSpeed;
    this.angle = this.initialAngle;
  }

  @override
  String toString() => '''
    === Bullet ===
    Id: $id
    Pos: $position
    Velocity: $speed
    Angle: $angle
  ''';
}
