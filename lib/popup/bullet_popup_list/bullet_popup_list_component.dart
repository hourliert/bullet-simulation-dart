import 'package:angular2/core.dart';

import 'package:bullet_simulation/popup/bullet_popup/bullet_popup_component.dart';

import 'package:bullet_simulation/shared/bullet_model.dart';
import 'package:bullet_simulation/shared/temp_list_service.dart';

@Component(
    selector: 'bs-bullet-popup-list',
    templateUrl: './bullet_popup_list_component.html',
    styleUrls: const ['./bullet_popup_list_component.css'],
    directives: const [BulletPopupComponent])
class BulletPopupListComponent {
  TempListService<Bullet> _removedBulletsService;

  BulletPopupListComponent(this._removedBulletsService);

  List<Bullet> get bullets => _removedBulletsService.list;
}
