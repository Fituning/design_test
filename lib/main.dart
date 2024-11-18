import 'package:bloc/bloc.dart';
import 'package:design_test/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //verify anything in the project is initialize
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load(); // Charge les variables d'environnement
  runApp(const MyAppView());
}



