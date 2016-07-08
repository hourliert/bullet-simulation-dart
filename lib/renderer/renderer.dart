/// A base class for representing a 2D game renderer
abstract class Renderer {
  /// bullet radius
  static const int bulletRadius = 4;

  /// The bullet color
  static const String bulletColor = 'red';

  /// Initializes the renderer.
  ///
  /// It setups the DOM and subscribe to streams
  void initialize();

  /// Renders one step of the game
  void render();
}
