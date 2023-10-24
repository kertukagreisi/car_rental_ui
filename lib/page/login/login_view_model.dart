import 'dart:async';

import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';

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

  Future<void> login(String username, String password) async {
    await CarRentalApi.userEndpointApi.userLoginPost(loginRequest: LoginRequest(username: username, password: password)).then((response) {
      user = response!;
      showSnackBar(SnackBarLevel.success, 'Logged in successfully');
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
          .then((response) => user = response!)
          .onError((error, stackTrace) => onError(error, stackTrace));
      if (user.id != null) {
        showSnackBar(SnackBarLevel.success, 'Signed up successfully');
      }
    }
  }

  FutureOr<User> onError(Object? error, StackTrace stackTrace) async {
    showSnackBar(SnackBarLevel.error, error.toString().substring(error.toString().indexOf(':'), error.toString().length));
    return User(id: null);
  }
}
