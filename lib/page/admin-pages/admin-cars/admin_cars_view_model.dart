import 'package:car_rental_ui/api-client/api_client.dart';
import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../../shared/mvvm/view_model.dart';
import '../../../shared/snackbar_service.dart';

class AdminCarsViewModel extends ViewModel {
  final Map<String, String> args;
  List<Car> _fetchedCars = [];
  List<Car> cars = [];
  final Map<String, String> columnsMap = {'id': 'ID', 'brand': 'Brand', 'model': 'Model', 'year': 'Year', 'price': 'Price', 'actions': 'Actions'};

  AdminCarsViewModel({required this.args});

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await _fetchCars();
    });
  }

  Future<void> _fetchCars() async {
    _fetchedCars = (await CarRentalApi.carEndpointApi.carsAllGet()) ?? [];
    cars = _fetchedCars;
  }

  Future<void> editCar(Map<String, dynamic> formValue, Car car) async {
    var brand = Brand.values.firstWhere((brand) => brand.value == formValue['brand']);
    var fuelType = FuelType.values.firstWhere((fuelType) => fuelType.value == formValue['fuelType']);
    var color = Color.values.firstWhere((color) => color.value == formValue['color']);
    var transmission = Transmission.values.firstWhere((transmission) => transmission.value == formValue['transmission']);
    print('$brand$fuelType$color$transmission');
    Car editedCar = Car(
        id: car.id,
        model: formValue['model'],
        brand: brand,
        engine: formValue['engine'],
        fuelType: fuelType,
        doors: formValue['doors'],
        color: color,
        transmission: transmission,
        seats: formValue['seats'],
        year: formValue['year'],
        licencePlate: formValue['licencePlate'],
        price: formValue['price'],
        averageRating: car.averageRating,
        reviewsCount: car.reviewsCount,
        picturePath: car.picturePath);
    await CarRentalApi.carEndpointApi.carsUpdatePut(car: editedCar).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Edited car successfully!');
      await _fetchCars();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when editing car!');
    });
  }

  Future<void> deleteCar(int carId) async {
    await CarRentalApi.carEndpointApi.carsDeleteIdDelete(carId).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Deleted car successfully!');
      await _fetchCars();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when deleting car!');
    });
  }
}
