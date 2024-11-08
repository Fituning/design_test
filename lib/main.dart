import 'package:api_car_repository/api_car_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:design_test/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'app_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //verify anything in the project is initialize
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyAppView());
}



