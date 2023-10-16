import 'package:car_rental_ui/page/cars/cars_view_model.dart';
import 'package:get_it/get_it.dart';

import '../navigation/nav_controller.dart';
import '../page/home/home_view_model.dart';

final getIt = GetIt.instance;

void setupLocator() {
  _setupSingletons();
  _setupViewModels();
}

void _setupViewModels() {
  getIt.registerFactory(() => HomeViewModel());
  getIt.registerFactoryParam<BookingViewModel, Map<String, String>, dynamic>(
    (args, car) => BookingViewModel(args: args, carFromExtraParameters: car),
  );
  //todo - implement code when we to got the cars overview or other lists
  /*getIt.registerFactoryParam<CarsOverviewViewModel, Map<String, String>, Owner?>(
    (args, layover) => CarsOverviewViewModel(args: args, layover: layover),
  );*/
}

void _setupSingletons() {
  getIt.registerSingleton(NavController());
}
