import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {
  // final ApiRepository apiRepository;
  const MyApp(/*this.apiRepository,*/{super.key});

  //final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    // return RepositoryProvider<AuthenticationBloc>(
    //   create: (context) => AuthenticationBloc(
    //       userRepository : userRepository
    //   ),
    //   child: const MyAppView(),
    // );
    return const MyAppView();
  }
}