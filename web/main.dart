// Copyright (c) 2016, Thomas Hourlier. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:bullet_simulation/core/game.dart';

void main() {
  DivElement playground = querySelector('#playground');
  DivElement popupsContainer = querySelector('#popups-container');

  Game game = new Game(playground, popupsContainer);
  game.initialize();
  game.loop();

  print('The game is started');
}
