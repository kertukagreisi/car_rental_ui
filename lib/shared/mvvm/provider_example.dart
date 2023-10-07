import 'view_model.dart';

//This file is only used as a show case on how to use the Provider package with the base classes implemented
//in the project. This should be removed when is no longer needed as a reference.

class ExampleViewModel extends ViewModel {
  int count = 0;
  final String staticText = 'I am static!';

  void increment() {
    count++;
    notifyListeners();
  }
}
