import 'package:angular2/core.dart';

import 'package:bullet_simulation/shared/bullet_model.dart';

@Component(
    selector: 'bs-bullet-popup',
    templateUrl: './bullet_popup_component.html',
    styleUrls: const ['./bullet_popup_component.css'])
class BulletPopupComponent {
  @Input()
  Bullet bullet;
}
