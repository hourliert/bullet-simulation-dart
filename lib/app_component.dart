import 'dart:async';

import 'package:angular2/core.dart';

import 'package:bullet_simulation/game/playground/playground_component.dart';
import 'package:bullet_simulation/popup/bullet_popup_list/bullet_popup_list_component.dart';
import 'package:bullet_simulation/shared/list_service.dart';
import 'package:bullet_simulation/shared/temp_list_service.dart';
import 'package:bullet_simulation/shared/renderer_type.dart';
import 'package:bullet_simulation/shared/bullet_model.dart';

@Component(
    selector: 'bs-app',
    templateUrl: './app_component.html',
    directives: const [BulletPopupListComponent, PlaygroundComponent],
    providers: const [ListService, TempListService])
class AppComponent implements OnInit {
  RendererType rendererType = RendererType.CANVAS;

  TempListService<Bullet> _removedBulletsService;

  AppComponent(this._removedBulletsService);

  @override
  ngOnInit() {
    new Future.delayed(const Duration(seconds: 10), () {
      print('replacing renderer');
      rendererType = RendererType.SVG;
    });
  }

  void onBulletHitsBorder(Bullet b) {
    _removedBulletsService.add(b);
  }
}
