import 'package:home_storage/src/modules/service_locator_setup.dart';
import 'package:log_generator/log_generator.dart';

void serviceLocatorLogGenerator() {
  getIt.registerLazySingleton<LogGenerator>(() => LogGenerator());
}
