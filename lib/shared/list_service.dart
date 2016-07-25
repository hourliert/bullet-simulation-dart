import 'package:angular2/core.dart';

@Injectable()
class ListService<T> {
  List<T> _list;

  ListService() {
    _list = new List<T>();
  }

  /// Gets the bullet list
  List<T> get list => _list;

  /// Adds a bullet to the store
  void add(T b) {
    _list.add(b);
  }

  /// Removes the specified bullet from the store
  void remove(T b) {
    _list.remove(b);
  }
}
