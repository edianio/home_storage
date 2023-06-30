import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_storage/src/modules/service_locator_setup.dart';
import 'package:home_storage/src/presentation/screens/main/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  serviceLocatorSetup();

  runApp(const AppWidget());
}
