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
    Car editedCar = Car(
        id: car.id,
        model: formValue['model']?.value,
        brand: Brand.values.firstWhere((brand) => brand.value == formValue['brand']?.value),
        engine: formValue['engine']?.value,
        fuelType: FuelType.values.firstWhere((fuelType) => fuelType.value == formValue['fuelType']?.value),
        doors: formValue['doors']?.value,
        color: Color.values.firstWhere((color) => color.value == formValue['color']?.value),
        transmission: Transmission.values.firstWhere((transmission) => transmission.value == formValue['transmission']?.value),
        seats: formValue['seats']?.value,
        year: formValue['year']?.value,
        licencePlate: formValue['licencePlate']?.value,
        price: formValue['price']?.value,
        averageRating: car.averageRating,
        reviewsCount: car.reviewsCount,
        picturePath: car.picturePath);
    await CarRentalApi.carEndpointApi.carsUpdatePut(car: editedCar).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Edited car sucessfully!');
      await _fetchCars();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when editing car!');
    });
  }

  Future<void> deleteCar(int carId) async {
    await CarRentalApi.carEndpointApi.carsDeleteIdDelete(carId).then((response) async {
      showSnackBar(SnackBarLevel.success, 'Deleted car sucessfully!');
      await _fetchCars();
      notifyListeners();
    }).onError((error, stackTrace) {
      showSnackBar(SnackBarLevel.error, 'Error when deleting car!');
    });
  }
}
