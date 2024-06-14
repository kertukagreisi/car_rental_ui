import 'package:car_rental_ui/page/admin-pages/admin-users/users_table_datasource.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';

import '../../../resources/dimens.dart';
import 'admin_users_view_model.dart';

class AdminUsersPage extends ViewModelWidget<AdminUsersViewModel> {
  final Map<String, String> args;

  const AdminUsersPage({super.key, required this.args});

  @override
  Widget builder(BuildContext context, AdminUsersViewModel viewModel, Widget? child) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Users Overview', style: Dimens.smallHeadTextStyle),
            PaginatedDataTable(columns: _getColumns(viewModel.columnsMap), source: UsersTableDatasource(users: viewModel.users))
          ],
        ),
      ),
    );
  }

  List<DataColumn> _getColumns(Map<String, String> columnsMap) {
    return columnsMap.entries
        .map((column) =>
            DataColumn(label: Text(column.value, style: Dimens.smallTextStyle.copyWith(fontWeight: FontWeight.w600)), tooltip: column.value))
        .toList();
  }

  @override
  AdminUsersViewModel viewModelBuilder() {
    return getIt.get<AdminUsersViewModel>(param1: args);
  }
}
