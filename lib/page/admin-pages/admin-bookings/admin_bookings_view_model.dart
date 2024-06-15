import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';

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
    'timeStamp': 'Time Stamp',
    'actions': 'Actions'
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

  Future<void> approveBooking(int bookingId) async {
    Booking booking = bookings.firstWhere((booking) => booking.id == bookingId);
    booking.bookingStatus = booking.bookingStatus == BookingStatus.PENDING ? BookingStatus.ACTIVE : BookingStatus.COMPLETED;
    await CarRentalApi.bookingEndpointApi
        .bookingsUpdatePut(booking: booking)
        .then((value) =>
            showSnackBar(SnackBarLevel.success, '${booking.bookingStatus == BookingStatus.PENDING ? 'Approved' : 'Completed'} booking sucessfully!'))
        .onError((error, stackTrace) =>
            showSnackBar(SnackBarLevel.error, 'Error when ${booking.bookingStatus == BookingStatus.PENDING ? 'approving' : 'completing'} booking!'));
  }

  Future<void> rejectBooking(int bookingId) async {
    Booking booking = bookings.firstWhere((booking) => booking.id == bookingId);
    booking.bookingStatus = BookingStatus.CANCELED;
    await CarRentalApi.bookingEndpointApi
        .bookingsUpdatePut(booking: booking)
        .then((value) => showSnackBar(SnackBarLevel.success, 'Canceled booking sucessfully!'))
        .onError((error, stackTrace) => showSnackBar(SnackBarLevel.error, 'Error when canceling booking!'));
  }

  Future<void> deleteBooking(int bookingId) async {
    await CarRentalApi.bookingEndpointApi
        .bookingsDeleteIdDelete(bookingId)
        .then((value) => showSnackBar(SnackBarLevel.success, 'Deleted booking sucessfully!'))
        .onError((error, stackTrace) => showSnackBar(SnackBarLevel.error, 'Error when deleting booking!'));
  }
}
