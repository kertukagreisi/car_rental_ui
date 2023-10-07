import 'dart:convert';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class CarsViewModel extends ViewModel {
  late List<dynamic> cars;
  Map<String, String> columnNames = {'id': 'Id', 'model': 'Model', 'year': 'Year', 'owner': 'Owner'};

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    await CarWashApi.carEndpointApi.carsAllGetWithHttpInfo().then((response) {
      cars = json.decode(response.body);
    });
  }
}
