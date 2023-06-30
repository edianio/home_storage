import 'package:flutter/material.dart';
import 'package:home_storage/src/presentation/screens/home/home_screen_dependencies.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo /,,/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreenDependencies().buildScreen(context),
    );
  }
}
