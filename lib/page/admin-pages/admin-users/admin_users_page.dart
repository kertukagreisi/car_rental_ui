import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/page/admin-pages/admin-users/users_table_datasource.dart';
import 'package:car_rental_ui/shared/helpers.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:car_rental_ui/shared/mvvm/view_model_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../resources/constants.dart';
import '../../../widgets/button_with_icon_widget.dart';
import '../../../widgets/cancel_button_widget.dart';
import '../../../widgets/confirm_dialog_widget.dart';
import '../../../widgets/save_button_widget.dart';
import '../../../widgets/ui_type/dropdown_select_widget.dart';
import '../../../widgets/ui_type/text_input_widget.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Users Overview', style: Constants.mediumHeadTextStyle),
                ButtonWithIcon(
                    text: 'Add User',
                    onPressed: () {
                      showDialog(context: context, builder: (context) => _showAddUserDialog(viewModel, context));
                    },
                    icon: Icons.add,
                    dark: false)
              ],
            ),
            Constants.largeSizedBox,
            Row(
              children: [
                Expanded(
                  child: PaginatedDataTable(
                    columns: _getColumns(viewModel.columnsMap),
                    source: UsersTableDatasource(
                        users: viewModel.users,
                        columnsMap: viewModel.columnsMap,
                        onButtonClick: (button, id) {
                          if (button == 'edit') {
                            showDialog(context: context, builder: (context) => _showEditUserDialog(viewModel, context, button, id));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => ConfirmDialog(
                                    title: 'Delete User',
                                    message: 'Are you sure you want to delete this user?',
                                    confirmButtonText: 'Yes',
                                    cancelButtonText: 'No',
                                    confirmCallback: () async {
                                      await viewModel.deleteUser(id);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    cancelCallback: () {
                                      Navigator.of(context).pop();
                                    }));
                          }
                        }),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  AlertDialog _showAddUserDialog(AdminUsersViewModel viewModel, BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return AlertDialog(
      title: const Text('Add User', style: Constants.headTextStyle),
      content: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextInputWidget(label: 'name', mandatory: true, onChange: (value) {}),
              TextInputWidget(label: 'lastName', mandatory: true, onChange: (value) {}),
              TextInputWidget(label: 'email', mandatory: true, onChange: (value) {}),
              TextInputWidget(label: 'phone', mandatory: true, onChange: (value) {}),
              TextInputWidget(label: 'username', mandatory: true, onChange: (value) {}),
              TextInputWidget(label: 'password', mandatory: true, onChange: (value) {}, obscureText: true),
              DropDownSelectWidget(label: 'role', items: roleValues, onDropDownChange: (value) {}, mandatory: true),
            ],
          ),
        ),
      ),
      actions: [
        SaveButton(
            text: 'Add',
            onPressed: () async {
              formKey.currentState?.save();
              if (formKey.currentState!.validate()) {
                await viewModel.addUser(formKey.currentState!.value);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            }),
        CancelButton(onPressed: () {
          Navigator.of(context).pop();
        }),
      ],
      titlePadding: Constants.mediumPadding,
      contentPadding: Constants.mediumPadding,
      actionsPadding: Constants.mediumPadding,
    );
  }

  AlertDialog _showEditUserDialog(AdminUsersViewModel viewModel, BuildContext context, String button, int userId) {
    final formKey = GlobalKey<FormBuilderState>();
    User user = viewModel.users.firstWhere((user) => user.id == userId);
    return AlertDialog(
      title: const Text('Edit User', style: Constants.headTextStyle),
      content: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextInputWidget(label: 'name', mandatory: true, onChange: (value) {}, initialValue: user.name),
              TextInputWidget(label: 'lastName', mandatory: true, onChange: (value) {}, initialValue: user.lastName),
              TextInputWidget(label: 'email', mandatory: true, onChange: (value) {}, initialValue: user.email),
              TextInputWidget(label: 'phone', mandatory: true, onChange: (value) {}, initialValue: user.phone),
              TextInputWidget(label: 'username', mandatory: true, onChange: (value) {}, initialValue: user.username),
              TextInputWidget(label: 'password', mandatory: true, onChange: (value) {}, obscureText: true),
              DropDownSelectWidget(label: 'role', items: roleValues, onDropDownChange: (value) {}, mandatory: true, initialValue: user.role!.value),
            ],
          ),
        ),
      ),
      actions: [
        SaveButton(
            text: 'Edit',
            onPressed: () async {
              formKey.currentState?.save();
              if (formKey.currentState!.validate()) {
                await viewModel.editUser(formKey.currentState!.value, user);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            }),
        CancelButton(onPressed: () {
          Navigator.of(context).pop();
        }),
      ],
      titlePadding: Constants.mediumPadding,
      contentPadding: Constants.mediumPadding,
      actionsPadding: Constants.mediumPadding,
    );
  }

  List<DataColumn> _getColumns(Map<String, String> columnsMap) {
    return columnsMap.entries
        .map((column) =>
            DataColumn(label: Text(column.value, style: Constants.smallTextStyle.copyWith(fontWeight: FontWeight.w600)), tooltip: column.value))
        .toList();
  }

  @override
  AdminUsersViewModel viewModelBuilder() {
    return getIt.get<AdminUsersViewModel>(param1: args);
  }
}
