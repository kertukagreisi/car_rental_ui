import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../../endpoint/user_endpoint.dart';
import '../../../shared/auth_service.dart';
import '../../../shared/locator.dart';
import '../../../shared/mvvm/view_model.dart';
import '../../../shared/snackbar_service.dart';

class AdminUsersViewModel extends ViewModel {
  final Map<String, String> args;
  late List<User> _fetchedUsers = [];
  List<User> users = [];
  late User user;
  final Map<String, String> columnsMap = {
    'id': 'ID',
    'fullName': 'Name',
    'email': 'Email',
    'phone': 'Phone',
    'username': 'Username',
    'role': 'Role',
    'actions': 'Actions'
  };

  AdminUsersViewModel({required this.args});

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await _fetchUsers();
    });
  }

  Future<void> _fetchUsers() async {
    _fetchedUsers = await CarRentalApi.userEndpointApi.userAllGet() ?? [];
    users = _fetchedUsers;
    user = getIt.get<AuthService>().user;
  }

  Future<void> addUser(Map<String, dynamic> formValue) async {
    var role = Role.values.firstWhere((role) => role.value == formValue['Role']);
    var createdUser = User(
        name: formValue['Name'],
        lastName: formValue['Last Name'],
        email: formValue['Email'],
        phone: formValue['Phone'],
        username: formValue['Username'],
        password: formValue['Password'],
        role: role);
    await CarRentalApi.userEndpointApi.userCreatePost(user: createdUser).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Created user successfully!');
      await _fetchUsers();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when creating user!');
    });
  }

  Future<void> editUser(Map<String, dynamic> formValue, User user) async {
    var role = Role.values.firstWhere((role) => role.value == formValue['Role']);
    var editedUser = User(
        id: user.id,
        name: formValue['Name'],
        lastName: formValue['Last Name'],
        email: formValue['Email'],
        phone: formValue['Phone'],
        username: formValue['Username'],
        password: formValue['Password'],
        role: role,
        profilePicturePath: user.profilePicturePath);
    await CarRentalApi.userEndpointApi.userUpdatePut(user: editedUser).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Edited user successfully!');
      await _fetchUsers();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when editing user!');
    });
  }

  Future<void> deleteUser(int userId) async {
    final UserService userService = UserService();
    await userService.deleteUser(userId).then((value) async {
      showSnackBar(SnackBarLevel.success, 'Deleted user sucessfully!');
      await _fetchUsers();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when deleting user!');
    });
  }
}
