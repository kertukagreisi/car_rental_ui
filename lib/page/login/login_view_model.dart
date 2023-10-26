import 'dart:async';

import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/navigation/nav_extensions.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/cupertino.dart';

import '../../navigation/nav_route.dart';
import '../../shared/flutter_secure_storage_service.dart';
import '../../shared/mvvm/view_model.dart';

class LoginViewModel extends ViewModel {
  final Map<String, String> args;
  late User user = User(id: 0);
  bool isOnLoginForm = true;

  LoginViewModel({required this.args});

  set setForm(bool value) {
    isOnLoginForm = value;
    notifyListeners();
  }

  Future<void> login(String username, String password, BuildContext context) async {
    await CarRentalApi.userEndpointApi.userLoginPost(loginRequest: LoginRequest(username: username, password: password)).then((response) {
      user = response!;
      showSnackBar(SnackBarLevel.success, 'Logged in successfully');
      if (context.mounted) {
        context.goNamedRoute(NavRoute.values.firstWhere((value) => value.name == args['navRoute']), queryParams: args);
      }
    }).onError((error, stackTrace) {
      onError(error, stackTrace);
    });
    if (user.id != null) {
      await saveUserToSecureStorage(user);
    }
  }

  Future<void> signUp(Map<String, dynamic> formValues) async {
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
            role: UserRole.USER),
      )
          .then((response) {
        user = response!;
        showSnackBar(SnackBarLevel.success, 'Signed up successfully');
      }).onError((error, stackTrace) {
        onError(error, stackTrace);
      });
    }
  }

  FutureOr<User> onError(Object? error, StackTrace stackTrace) async {
    showSnackBar(SnackBarLevel.error, error.toString().substring(error.toString().indexOf(':'), error.toString().length));
    user = User(id: null);
    return user;
  }
}
