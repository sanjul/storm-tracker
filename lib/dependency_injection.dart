import 'package:stormtr/data/mock/storms_data_mock.dart';
import 'package:stormtr/data/storms_data.dart';

enum DataSource { MOCK, SQLLITE }

//DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static DataSource _primaryDataSource;

  static void configure({DataSource primaryDataSource}) {
    _primaryDataSource = primaryDataSource;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  StormsData get stormsData {
    switch (_primaryDataSource) {
      case DataSource.MOCK:
        return new MockStormsData();
      default:
        return null;
    }
  }
}