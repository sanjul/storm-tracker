import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class StormsListViewContract {
  void onLoadStormsListComplete(List <Storm> stormsList);
  void onLoadStormsListError();
}

class StormsListPresenter {
  StormsListViewContract _view;
  StormsData _stormsData;

  StormsListPresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  void loadStormsList() {
    _stormsData
        .fetchStormsList()
        .then((c) => _view.onLoadStormsListComplete(c))
        .catchError((error) => _view.onLoadStormsListError());
  }
}
