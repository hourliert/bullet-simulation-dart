import 'dart:async';

import 'package:angular2/core.dart';

import 'list_service.dart';

@Injectable()
class TempListService<T> extends ListService<T> {
  @override
  void add(T b) {
    super.add(b);

    new Future.delayed(const Duration(seconds: 2), () {
      super.remove(b);
    });
  }
}
