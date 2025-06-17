import 'package:api_user_repository/api_user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:design_test/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'app.dart';
import 'app_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //verify anything in the project is initialize
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load(); // Charge les variables d'environnement
  await getDeviceUUID();
  runApp(MyApp(
    apiUserRepo: ApiUserRepo(),
  ));
}

Future<String> getDeviceUUID() async {
  final prefs = await SharedPreferences.getInstance();
  String? uuid = prefs.getString('device_uuid');

  if (uuid == null) {
    uuid = const Uuid().v4(); // Génère un UUID unique
    await prefs.setString('device_uuid', uuid);
  }

  return uuid;
}
