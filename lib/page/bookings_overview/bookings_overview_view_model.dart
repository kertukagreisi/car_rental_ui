import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../shared/flutter_secure_storage_service.dart';
import '../../shared/mvvm/view_model.dart';

class BookingsOverviewViewModel extends ViewModel {
  late User user;
  late List<Booking> bookings = [];

  BookingsOverviewViewModel();

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    user = (await getUserFromSecureStorage())!;
    bookings = (await CarRentalApi.bookingEndpointApi.bookingsUserUserIdGet(user.id!))!;
  }
}
