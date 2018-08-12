import 'package:stormtr/data/storms_data.dart';

class GraphData{
  List <Storm> _stormsList;

  List<Storm> get stormsList => _stormsList;

  GraphData(List<Storm> stormList){
     _stormsList = stormList;
     _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));
  }
}