import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/bookings/bookings_view_model.dart';
import 'package:car_rental_ui/page/user/user_view_model.dart';
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
  getIt.registerFactoryParam<BookingViewModel, Map<String, String>, Car?>(
    (args, car) => BookingViewModel(args: args, carFromExtraParameters: car),
  );
  getIt.registerFactory(() => UserViewModel());
}

void _setupSingletons() {
  getIt.registerSingleton(NavController());
}
