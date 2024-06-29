import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/flutter_secure_storage_service.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';

import 'helpers.dart';

class AuthService with ChangeNotifier {
  final BehaviorSubject<bool> _isAuthenticated = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<User?> _user = BehaviorSubject<User?>.seeded(null);
  final BehaviorSubject<String?> _token = BehaviorSubject<String?>.seeded(null);

  get user => _user.value;

  get token => _token.value;

  get isAuthenticated => _isAuthenticated.value;

  AuthService() {
    _fetchAsyncData();
  }

  Future<void> _fetchAsyncData() async {
    _token.value = await getTokenFromSecureStorage();
    if (_token.value != null) {
      _decodeToken(token);
    }
  }

  Future<bool> login(String username, String password) async {
    LoginRequest loginRequest = LoginRequest(username: username, password: password);
    await CarRentalApi.userEndpointApi.userLoginPost(loginRequest: loginRequest).then((loginResponse) {
      _decodeToken(loginResponse!.token);
      saveTokenToSecureStorage(token);
      showSnackBar(SnackBarLevel.success, 'Logged in successfully!');
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, getErrorMessage(error));
      _removeUser();
    });
    return isAuthenticated;
  }

  _decodeToken(String? token) {
    Map<String, dynamic> userMap = JwtDecoder.decode(token!);
    _user.value = User(
        id: userMap['id'],
        name: userMap['name'],
        lastName: userMap['lastName'],
        email: userMap['email'],
        phone: userMap['phone'],
        username: userMap['username'],
        role: Role.values.firstWhere((role) => role.value == userMap['role'].toString()));
    _token.value = token;
    _isAuthenticated.value = true;
  }

  Future<void> logout() async {
    _removeUser();
    await removeTokenFromSecureStorage();
  }

  void _removeUser() {
    _user.value = null;
    _token.value = null;
    _isAuthenticated.value = false;
  }
}
