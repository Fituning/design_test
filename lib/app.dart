import 'package:api_user_repository/api_user_repository.dart';
import 'package:design_test/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.apiUserRepo});

  final ApiUserRepo apiUserRepo;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthBloc>(
      create: (context) => AuthBloc(
          apiUserRepo,
      ),
      child: const MyAppView(),
    );
  }
}