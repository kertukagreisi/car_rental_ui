import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:rxdart/rxdart.dart';

import 'helpers.dart';

class AuthService {
  final BehaviorSubject<bool> _isAuthenticated = BehaviorSubject<bool>.seeded(false);
  User? user;
  String? token;

  Stream<bool> get isAuthenticated => _isAuthenticated.stream;

  Future<bool> login(String username, String password) async {
    LoginRequest loginRequest = LoginRequest(username: username, password: password);
    await CarRentalApi.userEndpointApi.userLoginPost(loginRequest: loginRequest).then((loginResponse) {
      Map<String, dynamic> userMap = JwtDecoder.decode(loginResponse!.token!);
      user = User(
          id: userMap['id'],
          name: userMap['name'],
          lastName: userMap['lastName'],
          email: userMap['email'],
          phone: userMap['phone'],
          username: userMap['username'],
          role: Role.values.firstWhere((role) => role.value == userMap['role'].toString()));
      token = loginResponse.token!;
      _isAuthenticated.add(true);
      showSnackBar(SnackBarLevel.success, 'Logged in successfully!');
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, getErrorMessage(error));
      _isAuthenticated.add(false);
    });
    return isAuthenticated.first;
  }

  Future<void> logout() async {
    user = null;
    token = null;
    _isAuthenticated.add(false);
  }
}
