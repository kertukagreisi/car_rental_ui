import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/cupertino.dart';

import '../../../shared/auth_service.dart';
import '../../../shared/locator.dart';
import '../../../shared/mvvm/view_model.dart';

class AdminUsersViewModel extends ViewModel {
  final Map<String, String> args;
  late User user;

  AdminUsersViewModel({required this.args});

  late Car car;

  late String id;

  double totalPrice = 0;
  int datesDifference = 1;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0).add(const Duration(days: 1));

  @override
  Future<void> init() async {
    super.init();
    id = args['id']!;
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final authService = getIt<AuthService>();
    user = authService.user!;
    car = (await CarRentalApi.carEndpointApi.carsGetIdGet(int.parse(id)))!;

    totalPrice = car.price;
  }

  Future<void> rentCar(Map<String, dynamic> value, BuildContext context) async {
    Booking booking = Booking(
        name: value['Name'],
        lastName: value['Last Name'],
        email: value['Email'],
        phone: value['Phone'],
        user: user,
        car: car,
        startDate: DateTime(value['Start Date'].year, value['Start Date'].month, value['Start Date'].day).add(const Duration(days: 1)),
        endDate: DateTime(value['End Date'].year, value['End Date'].month, value['End Date'].day).add(const Duration(days: 1)),
        timeStamp: DateTime.now(),
        total: datesDifference * car.price,
        bookingStatus: BookingStatus.PENDING);
    await CarRentalApi.bookingEndpointApi.bookingsCreatePost(carId: car.id, userId: 1, booking: booking).then((value) {
      showSnackBar(SnackBarLevel.success, 'The booking was saved!');
      context.goNamedRoute(NavRoute.bookingsOverview);
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, error.toString());
    });
  }

  void setTotalToBePayed(bool isStartDate, value) {
    if (isStartDate) {
      startDate = value;
    } else {
      endDate = value;
    }
    // Find the difference between the two dates
    datesDifference = endDate.difference(startDate).inDays;
    totalPrice = car.price * datesDifference;
    notifyListeners();
  }
}
