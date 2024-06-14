import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../../shared/mvvm/view_model.dart';

class AdminBookingsViewModel extends ViewModel {
  final Map<String, String> args;

  late List<Booking> _fetchedBookings = [];
  List<Booking> bookings = [];
  final Map<String, String> columnsMap = {
    'id': 'ID',
    'fullName': 'Name',
    'startDate': 'Start Date',
    'endDate': 'End Date',
    'status': 'Status',
    'total': 'Total',
    'timeStamp': 'Time Stamp'
  };

  AdminBookingsViewModel({required this.args});

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    _fetchedBookings = await CarRentalApi.bookingEndpointApi.bookingsAllGet() ?? [];
    bookings = _fetchedBookings;
  }
}
