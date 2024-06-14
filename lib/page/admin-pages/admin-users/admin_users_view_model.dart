import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../../shared/mvvm/view_model.dart';

class AdminUsersViewModel extends ViewModel {
  final Map<String, String> args;
  late List<User> _fetchedUsers = [];
  List<User> users = [];
  final Map<String, String> columnsMap = {'id': 'ID', 'fullName': 'Name', 'email': 'Email', 'phone': 'Phone', 'username': 'Username', 'role': 'Role'};

  AdminUsersViewModel({required this.args});

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    _fetchedUsers = await CarRentalApi.userEndpointApi.userAllGet() ?? [];
    users = _fetchedUsers;
  }
}
