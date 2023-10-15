import 'dart:convert';

import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class HomeViewModel extends ViewModel {
  late List<dynamic> cars;

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    await CarRentalApi.carEndpointApi.carsAllGetWithHttpInfo().then((response) {
      cars = json.decode(response.body);
    });
  }
}
