import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../shared/mvvm/view_model.dart';

class CarDetailsViewModel extends ViewModel {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  CarDetailsViewModel({required this.args, required this.carFromExtraParameters});

  late Car car;

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
      car = (await CarRentalApi.carEndpointApi.carsGetIdGet(int.parse(id)))!;
    } else {
      car = carFromExtraParameters!;
    }
  }
}
