import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/generated/assets.dart';
import 'package:design_test/pages/select_car/blocs/get_car/get_car_bloc.dart';
import 'package:design_test/pages/select_car/pages/add_car_screen.dart';
import 'package:design_test/pages/select_car/pages/select_car_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import 'blocs/select_car/select_car_bloc.dart';

enum AuthView { signIn, signUp }

class CarPicker extends StatefulWidget {
  const CarPicker({super.key});

  @override
  State<CarPicker> createState() => _CarPickerState();
}

class _CarPickerState extends State<CarPicker> with TickerProviderStateMixin {
  late TabController tabController;
  AuthView currentAuthView = AuthView.signIn;

  @override
  void initState() {
    tabController = TabController(
        initialIndex: context.read<AuthBloc>().state.status ==
                Authenticationstatus.noCarSelected
            ? 1
            : 0,
        length: 2,
        vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Widget authMethod = _buildAuthView();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Permet d'ajuster la vue lors de l'apparition du clavier
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(height: 76),
                    Image.asset(
                      Assets.logosLogoSoftcar,
                      width: MediaQuery.of(context).size.width / 3 * 2,
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: TabBar(
                        controller: tabController,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.primary,
                        labelColor: Theme.of(context).colorScheme.secondary,
                        indicatorColor: Theme.of(context).colorScheme.secondary,
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Add new car',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Select a car',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MultiBlocProvider(
                      providers: [
                        BlocProvider<SelectCarBloc>(
                          create: (context) => SelectCarBloc(
                              context.read<AuthBloc>().apiUserRepo),
                        ),
                        BlocProvider<GetCarBloc>(
                          create: (context) => GetCarBloc(
                              ApiCarRepo(context.read<AuthBloc>().apiUserRepo))
                            ..add(GetCars()),
                        ),
                      ],
                      child: Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: const [
                            AddCarScreen(),
                            SelectCarScreen(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
