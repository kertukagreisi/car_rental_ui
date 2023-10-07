import 'dart:convert';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class HomeViewModel extends ViewModel {
  late List<dynamic> owners;
  Map<String, String> columnNames = {'id': 'Id', 'firstName': 'First Name', 'lastName': 'Last Name', 'phoneNumber': 'Phone Number', 'age': 'Age'};

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    await CarWashApi.ownerEndpointApi.ownersAllGetWithHttpInfo().then((response) {
      owners = json.decode(response.body);
    });
  }
}
