import 'package:car_rental_ui/navigation/nav_controller.dart';
import 'package:car_rental_ui/resources/app_colors.dart';
import 'package:car_rental_ui/resources/dimens.dart';
import 'package:car_rental_ui/shared/extensions.dart';
import 'package:car_rental_ui/shared/globals.dart';
import 'package:car_rental_ui/shared/locator.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  //comment this out when testing locally
  //await dotenv.load();
  setupLogger();
  setupLocator();
  runApp(CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  CarRentalApp({super.key});

  final NavController _navController = getIt.get<NavController>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _navController.router,
      title: 'Car Rental',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Globals.snackBarKey,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: AppColors.darkCyan.toMaterialColor(),
        primaryColor: AppColors.darkCyan,
        shadowColor: AppColors.gray,
        hoverColor: AppColors.lightBlue,
        snackBarTheme: SnackBarThemeData(
            backgroundColor: AppColors.lightGray,
            contentTextStyle:
                Dimens.smallTextStyle.copyWith(color: AppColors.green)),
      ),
    );
  }
}

void setupLogger() {
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((record) => debugPrint(
      '${record.loggerName} ${record.level.name} ${record.time} ${record.message}'));
}
