import 'dart:html';
import 'dart:async';

import 'package:bullet_simulation/game_objects/bullet.dart';

/// Manages popup displayed during the game
class PopupsManager {
  /// The popup duration
  static const Duration popupDuration = const Duration(seconds: 1);

  DivElement _popupsContainer;

  /// Creates a popup manager
  ///
  /// A [DivElement] must be injected into the popup manager. Popup will be append to it.
  PopupsManager(this._popupsContainer);

  /// Creates a new popup
  ///
  /// It will display the bullet [b] information for [popupDuration] duration
  void addPopup(Bullet b) {
    DivElement popup = document.createElement('div');
    popup.className = 'popup';
    popup.text = _computeBulletText(b);

    _popupsContainer.append(popup);

    new Future<Null>.delayed(popupDuration, () {
      popup.remove();
    });
  }

  String _computeBulletText(Bullet b) =>
      'bullet: ${b.id} start: ${b.initialPosition} end: ${b.position}';
}
