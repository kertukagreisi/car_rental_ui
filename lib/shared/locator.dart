import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/admin-pages/admin-bookings/admin_bookings_view_model.dart';
import 'package:car_rental_ui/page/admin-pages/admin-cars/admin_cars_view_model.dart';
import 'package:car_rental_ui/page/admin-pages/admin-users/admin_users_view_model.dart';
import 'package:car_rental_ui/page/bookings_overview/bookings_overview_view_model.dart';
import 'package:car_rental_ui/page/car-details/car_details_view_model.dart';
import 'package:car_rental_ui/page/login/login_view_model.dart';
import 'package:car_rental_ui/page/rent/rent_view_model.dart';
import 'package:car_rental_ui/page/profile/profile_view_model.dart';
import 'package:get_it/get_it.dart';

import '../navigation/nav_controller.dart';
import '../page/home/home_view_model.dart';
import 'auth_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  _setupSingletons();
  _setupViewModels();
}

void _setupViewModels() {
  // no access routes
  getIt.registerFactory(() => HomeViewModel());
  getIt.registerFactoryParam<CarDetailsViewModel, Map<String, String>, Car?>(
    (args, car) => CarDetailsViewModel(args: args, carFromExtraParameters: car),
  );

  //user access pages
  getIt.registerFactoryParam<RentViewModel, Map<String, String>, Car?>(
    (args, car) => RentViewModel(args: args, carFromExtraParameters: car),
  );
  getIt.registerFactoryParam<LoginViewModel, Map<String, String>, dynamic>(
    (args, extra) => LoginViewModel(args: args),
  );
  getIt.registerFactory(() => ProfileViewModel());
  getIt.registerFactory(() => BookingsOverviewViewModel());

  // admin pages
  getIt.registerFactoryParam<AdminCarsViewModel, Map<String, String>, dynamic>(
    (args, extra) => AdminCarsViewModel(args: args),
  );
  getIt.registerFactoryParam<AdminUsersViewModel, Map<String, String>, dynamic>(
    (args, extra) => AdminUsersViewModel(args: args),
  );
  getIt.registerFactoryParam<AdminBookingsViewModel, Map<String, String>, dynamic>(
    (args, extra) => AdminBookingsViewModel(args: args),
  );
}

void _setupSingletons() {
  getIt.registerSingleton(NavController());
  getIt.registerSingleton(AuthService());
}
