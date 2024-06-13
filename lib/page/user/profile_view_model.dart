import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../shared/auth_service.dart';
import '../../shared/locator.dart';
import '../../shared/mvvm/view_model.dart';

class ProfileViewModel extends ViewModel {
  late User user;

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    final authService = getIt<AuthService>();
    user = authService.user!;
  }
}
