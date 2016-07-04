import 'dart:html';
import 'dart:async';

import 'package:bullet_simulation/game_objects/bullet.dart';

class PopupsManager {
  static const Duration POPUP_DURATION = const Duration(seconds: 1);

  DivElement _popupsContainer;

  PopupsManager(this._popupsContainer);

  void addPopup(Bullet b) {
    DivElement popup = document.createElement('div');
    popup.className = 'popup';
    popup.text = _computeBulletText(b);

    _popupsContainer.append(popup);

    new Future.delayed(POPUP_DURATION, () {
      popup.remove();
    });
  }

  String _computeBulletText(Bullet b) {
    return 'bullet: ${b.id} start: ${b.initialPosition} end: ${b.position}';
  }
}
