import 'package:home_storage/src/modules/service_locator_access.dart';
import 'package:home_storage/src/modules/service_locator_firebase.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void serviceLocatorSetup() {
  serviceLocatorFirebase();
  serviceLocatorAccess();
}
