import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/mvvm/view_model.dart';

class BookingViewModel extends ViewModel {
  final Map<String, String> args;
  final Car? carFromExtraParameters;

  BookingViewModel({required this.args, required this.carFromExtraParameters});

  late Car car;

  late String id;

  double totalPrice = 0;
  int datesDifference = 1;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(const Duration(days: 1));

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
    totalPrice = car.price!;
  }

  Future<void> renatCar(Map<String, dynamic> value, BuildContext context) async {
    Booking booking = Booking(
      user: User(id: 3),
      car: Car(id: car.id),
      startDate: value['Start Date'],
      endDate: value['End Date'],
    );
    await CarRentalApi.bookingEndpointApi
        .bookingsCreatePostWithHttpInfo(carId: car.id, userId: 3, booking: booking)
        .then((value) => showSnackBar(SnackBarLevel.success, 'The booking was saved!'))
        .onError((error, stackTrace) => showSnackBar(SnackBarLevel.error, error.toString()));
  }

  void setTotalToBePayed(bool isStartDate, value) {
    if (isStartDate) {
      startDate = value;
    } else {
      endDate = value;
    }
    // Find the difference between the two dates
    datesDifference = endDate.difference(startDate).inDays;
    totalPrice = (car.price ?? 0) * datesDifference;
    notifyListeners();
  }
}
