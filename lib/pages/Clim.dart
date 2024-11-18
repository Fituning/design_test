import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/components/next_prog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),
                const NextProgList()
              ],
            );
          }else if(state is GetCarReLoadFailure){
            final car = state.car;
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),
                const NextProgList()
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
    // print(context.size!.height);
    return ClimControllerPanel(expandedHeight: expandedHeight, car :car);
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent =>expandedHeight-100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

String getFormattedDate(DateTime startTime) {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  DateTime oneWeekLater = now.add(const Duration(days: 7));

  // Si c'est demain
  if (startTime.year == tomorrow.year &&
      startTime.month == tomorrow.month &&
      startTime.day == tomorrow.day) {
    return "Demain";
  }

  // Si c'est dans les 7 prochains jours
  if (startTime.isAfter(now) && startTime.isBefore(oneWeekLater)) {
    return DateFormat('EEEE')
        .format(startTime); // Jour de la semaine (Lundi, Mardi, ...)
  }

  // Si c'est plus d'une semaine à partir de maintenant
  return DateFormat('dd/MM').format(startTime); // Format DD/MM/YYYY
}

