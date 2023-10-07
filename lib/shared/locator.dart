import 'package:car_wash_ui/page/cars/cars_view_model.dart';
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
  getIt.registerFactory(() => CarsViewModel());
  //todo - implement code when we to got the cars overview
  /*getIt.registerFactoryParam<CarsOverviewViewModel, Map<String, String>, Owner?>(
    (args, layover) => CarsOverviewViewModel(args: args, layover: layover),
  );*/
}

void _setupSingletons() {
  getIt.registerSingleton(NavController());
}
