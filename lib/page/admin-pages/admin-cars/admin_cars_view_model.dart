import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../../shared/mvvm/view_model.dart';

class AdminCarsViewModel extends ViewModel {
  final Map<String, String> args;
  List<Car> _fetchedCars = [];
  List<Car> cars = [];
  final Map<String, String> columnsMap = {'id': 'ID', 'brand': 'Brand', 'model': 'Model', 'year': 'Year', 'price': 'Price'};

  AdminCarsViewModel({required this.args});

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await _fetchCars();
    });
  }

  Future<void> _fetchCars() async {
    _fetchedCars = (await CarRentalApi.carEndpointApi.carsAllGet()) ?? [];
    cars = _fetchedCars;
  }
}
