import 'dart:convert';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class CarsViewModel extends ViewModel {

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {

  }
}
