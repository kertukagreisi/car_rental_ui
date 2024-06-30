import 'dart:typed_data';

import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/endpoint/file_endpoint.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:car_rental_ui/shared/snackbar_service.dart';

import '../../shared/auth_service.dart';
import '../../shared/locator.dart';
import '../../shared/mvvm/view_model.dart';

class ProfileViewModel extends ViewModel {
  late User user;
  Uint8List? profilePicture = Uint8List(0);

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    user = getIt<AuthService>().user!;
    await _getProfilePicture();
  }

  Future<void> _getProfilePicture() async {
    FileService fileService = FileService();
    await fileService.getUserProfilePicture('${user.id}').then((response) {
      profilePicture = response;
    }).onError((error, stackStace) {});
  }

  Future<bool> updateProfile(Map<String, dynamic>? value) async {
    bool success = false;
    User updatedUser = User(
        id: user.id,
        username: value?['Username'],
        name: value?['Name'],
        lastName: value?['Last Name'],
        email: value?['Email'],
        phone: value?['Phone'],
        profilePicturePath: user.profilePicturePath,
        password: '',
        role: user.role);
    await CarRentalApi.userEndpointApi.userUpdateOwnProfilePut(user: updatedUser).then((response) {
      showSnackBar(SnackBarLevel.success, 'Edited profile successfully!');
      success = true;
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when editing profile!');
    });
    return Future.value(success);
  }
}
