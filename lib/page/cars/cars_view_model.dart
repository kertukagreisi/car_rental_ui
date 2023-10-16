import 'dart:convert';

import 'package:car_rental_ui/api-client/api_client.dart';

import '../../shared/mvvm/view_model.dart';

class BookingViewModel extends ViewModel {
  final Map<String, String> args;
  final dynamic carFromExtraParameters;

  BookingViewModel({required this.args, required this.carFromExtraParameters});

  late dynamic car;

  late String id;

  @override
  Future<void> init() async {
    super.init();
    id = args['id']!;
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    if (carFromExtraParameters == null) {
      await CarRentalApi.carEndpointApi.carsGetIdGetWithHttpInfo(int.parse(id)).then((response) => car = jsonDecode(response.body));
    } else {
      car = carFromExtraParameters!;
    }
  }
}
