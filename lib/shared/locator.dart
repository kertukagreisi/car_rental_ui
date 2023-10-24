import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/book/book_view_model.dart';
import 'package:car_rental_ui/page/bookings_overview/bookings_overview_view_model.dart';
import 'package:car_rental_ui/page/login/login_view_model.dart';
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
  getIt.registerFactoryParam<BookViewModel, Map<String, String>, Car?>(
    (args, car) => BookViewModel(args: args, carFromExtraParameters: car),
  );
  getIt.registerFactoryParam<LoginViewModel, Map<String, String>, dynamic>(
    (args, extra) => LoginViewModel(args: args),
  );
  getIt.registerFactory(() => UserViewModel());
  getIt.registerFactory(() => BookingsOverviewViewModel());
}

void _setupSingletons() {
  getIt.registerSingleton(NavController());
}
