import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class LoginViewModel extends ViewModel {
  String username = '';
  String password = '';
  String errorMessage = '';

  void updateUsername(String value) {
    username = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  Future<void> login() async {
    // Implement your login logic here, making an HTTP request to the backend
    // Set _isLoading to true while the request is in progress

    // Example of making an HTTP POST request using the http package
    // Replace 'your_backend_url' with your actual backend URL
    // Replace 'body' with your request data

    // final response = await http.post(
    //   Uri.parse('your_backend_url'),
    //   body: jsonEncode(<String, String>{
    //     'username': _username,
    //     'password': _password,
    //   }),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json',
    //   },
    // );

    // Handle the response and set _isLoading back to false

    // if (response.statusCode == 200) {
    //   // Successful login
    // } else {
    //   // Failed login, set error message and handle accordingly
    // }
  }
}
