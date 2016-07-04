import 'dart:math';
import 'dart:async';

class Scene {
  Rectangle<int> dimensions;
  Stream<Scene> onResize;

  StreamController<Scene> _onResizeController;

  Scene(int width, int height) {
    dimensions = new Rectangle<int>(0, 0, width, height);
    _onResizeController = new StreamController<Scene>();
    onResize = _onResizeController.stream;
  }

  get width => dimensions.width;
  get height => dimensions.height;

  void updateScene(Rectangle<int> rect) {
    dimensions = rect;

    _onResizeController.add(this);
  }
}
