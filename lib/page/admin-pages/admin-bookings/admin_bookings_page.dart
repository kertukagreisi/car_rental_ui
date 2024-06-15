import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/admin-pages/admin-bookings/bookings_table_datasource.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import '../../../shared/helpers.dart';
import '../../../widgets/confirm_dialog_widget.dart';
import 'admin_bookings_view_model.dart';

class AdminBookingsPage extends ViewModelWidget<AdminBookingsViewModel> {
  final Map<String, String> args;

  const AdminBookingsPage({super.key, required this.args});

  @override
  Widget builder(BuildContext context, AdminBookingsViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Users Overview', style: Dimens.mediumHeadTextStyle),
            Dimens.mediumSizedBox,
            Row(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                      columns: getColumns(viewModel.columnsMap),
                      source: BookingsTableDatasource(
                          bookings: viewModel.bookings,
                          columnsMap: viewModel.columnsMap,
                          onButtonClick: (String button, int id) => _getActionDialog(viewModel, context, button, id))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  AdminBookingsViewModel viewModelBuilder() {
    return getIt.get<AdminBookingsViewModel>(param1: args);
  }

  _getActionDialog(AdminBookingsViewModel viewModel, BuildContext context, String button, int id) {
    bool isPending = viewModel.bookings.firstWhere((booking) => booking.id == id).bookingStatus == BookingStatus.PENDING;
    showDialog(
        context: context,
        builder: (BuildContext context) => ConfirmDialog(
              title: '${convertToCamelCase(button)} Booking',
              message: 'Are you sure you want to ${isPending ? 'activate' : 'complete'} this booking?',
              confirmCallback: () async {
                if (button == 'approve') {
                  await viewModel.approveBooking(id);
                } else if (button == 'reject') {
                  await viewModel.rejectBooking(id);
                } else {
                  await viewModel.deleteBooking(id);
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              cancelCallback: () {
                Navigator.of(context).pop();
              },
              confirmButtonText: 'Yes',
              cancelButtonText: 'No',
            ));
  }
}
