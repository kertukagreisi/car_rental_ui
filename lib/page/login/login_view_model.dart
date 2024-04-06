import 'dart:async';

import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/navigation/nav_route.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/auth_service.dart';
import '../../shared/helpers.dart';
import '../../shared/locator.dart';
import '../../shared/mvvm/view_model.dart';

class LoginViewModel extends ViewModel {
  final Map<String, String> args;
  late User user;
  bool isOnLoginForm = true;

  LoginViewModel({required this.args});

  set setForm(bool value) {
    isOnLoginForm = value;
    notifyListeners();
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    final authService = getIt<AuthService>();
    if (await authService.login(username, password) && context.mounted) {
      context.goNamedRoute(NavRoute.home);
    }
  }

  Future<void> signUp(
      Map<String, dynamic> formValues, BuildContext context) async {
    if (formValues['Password'] != formValues['Retype Password']) {
      showSnackBar(SnackBarLevel.error, 'The passwords didn\'t match!');
    } else {
      await CarRentalApi.userEndpointApi
          .userSignUpPost(
        user: User(
            name: formValues['Name'],
            lastName: formValues['Last Name'],
            email: formValues['Email'],
            phone: formValues['Phone'],
            username: formValues['Username'],
            password: formValues['Password'],
            role: Role.USER),
      )
          .then((response) {
        showSnackBar(SnackBarLevel.success, 'Signed up successfully');
        setForm = true;
      }).onError((error, stackTrace) {
        showSnackBar(SnackBarLevel.error, getErrorMessage(error));
      });
    }
  }
}
