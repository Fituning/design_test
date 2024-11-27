import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/components/next_prog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/car_bloc/car_bloc.dart';
import '../components/clim_controler_panel.dart';

class Clim extends StatelessWidget {
  const Clim({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if(state is GetCarSuccess){
            final car = state.car;
            final progList = car.acProg
                .where((acProg) => acProg!.isActive && acProg.dateInitial.isAfter(DateTime.now()))
                .toList();
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),
                NextProgList(acProgList: progList,)
              ],
            );
          }else if(state is GetCarReLoadFailure){
            final Car car = state.car;
            final progList = car.acProg
                .where((acProg) => acProg!.isActive && acProg.dateInitial.isAfter(DateTime.now()))
                .toList();
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),
                NextProgList(acProgList: progList)
              ],
            );
          }else {
            return const Center(child: Text("An error has occurred while loading home page"));
          }
        },
      );
  }
}

class ClimControl extends SliverPersistentHeaderDelegate {
  double expandedHeight = 570;
  final Car car;

  ClimControl({required this.car});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClimControllerPanel(expandedHeight: expandedHeight, car :car);
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent =>expandedHeight-100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;//mettre a true pour reconstruire la vue si les valeurs changent
  }
}



