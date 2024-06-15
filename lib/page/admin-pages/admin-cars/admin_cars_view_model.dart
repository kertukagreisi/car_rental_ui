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

  Future<void> addCar(Map<String, dynamic> formValue) async {
    var brand = Brand.values.firstWhere((brand) => brand.value == formValue['brand']);
    var fuelType = FuelType.values.firstWhere((fuelType) => fuelType.value == formValue['fuelType']);
    var color = Color.values.firstWhere((color) => color.value == formValue['color']);
    var transmission = Transmission.values.firstWhere((transmission) => transmission.value == formValue['transmission']);
    var createdCar = Car(
        model: formValue['model'],
        brand: brand,
        engine: formValue['engine'],
        fuelType: fuelType,
        doors: int.parse(formValue['doors']),
        color: color,
        transmission: transmission,
        seats: int.parse(formValue['seats']),
        year: int.parse(formValue['year']),
        licencePlate: formValue['licencePlate'],
        price: double.parse(formValue['price']),
        averageRating: 0.0,
        reviewsCount: 0);
    await CarRentalApi.carEndpointApi.carsCreatePost(car: createdCar).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Created car successfully!');
      await _fetchCars();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when creating car!');
    });
  }

  Future<void> editCar(Map<String, dynamic> formValue, Car car) async {
    var brand = Brand.values.firstWhere((brand) => brand.value == formValue['brand']);
    var fuelType = FuelType.values.firstWhere((fuelType) => fuelType.value == formValue['fuelType']);
    var color = Color.values.firstWhere((color) => color.value == formValue['color']);
    var transmission = Transmission.values.firstWhere((transmission) => transmission.value == formValue['transmission']);
    var editedCar = Car(
        id: car.id,
        model: formValue['model'],
        brand: brand,
        engine: formValue['engine'],
        fuelType: fuelType,
        doors: int.parse(formValue['doors']),
        color: color,
        transmission: transmission,
        seats: int.parse(formValue['seats']),
        year: int.parse(formValue['year']),
        licencePlate: formValue['licencePlate'],
        price: double.parse(formValue['price']),
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
