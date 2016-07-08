import 'dart:math';
import 'dart:async';

/// Represents the game scene
///
/// It has a dimensions and can notify other when it has be resized
class Scene {
  Rectangle<int> _dimensions;
  StreamController<Scene> _onResizeStreamController;

  /// Creates a new scene with a specified size
  ///
  /// [width] and [height] must be both positive integer
  Scene(int width, int height) {
    assert(width > 0);
    assert(height > 0);

    _dimensions = new Rectangle<int>(0, 0, width, height);
    _onResizeStreamController = new StreamController<Scene>();
  }

  /// The stream that represents a scene size change
  Stream<Scene> get onResize => _onResizeStreamController.stream;

  /// The width of the scene
  int get width => _dimensions.width;

  /// The height of the scene
  int get height => _dimensions.height;

  /// Updates the scene size
  /// It broadcasts this change through the stream [onResize]
  void updateScene(Rectangle<int> rect) {
    _dimensions = rect;
    _onResizeStreamController.add(this);
  }

  /// Determines if a point is contained in the scene
  bool containPoints(Point<int> p) {
    return _dimensions.containsPoint(p);
  }
}
