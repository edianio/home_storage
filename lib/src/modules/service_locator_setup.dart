import 'package:home_storage/src/modules/service_locator_access.dart';
import 'package:home_storage/src/modules/service_locator_firebase.dart';
import 'package:get_it/get_it.dart';
import 'package:home_storage/src/modules/service_locator_log_generator.dart';
import 'package:home_storage/src/modules/service_locator_product.dart';

final GetIt getIt = GetIt.instance;

void serviceLocatorSetup() {
  serviceLocatorLogGenerator();
  serviceLocatorFirebase();
  serviceLocatorAccess();
  serviceLocatorProduct();
}
