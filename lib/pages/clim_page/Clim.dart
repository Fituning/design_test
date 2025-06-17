import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/pages/clim_page/components/next_prog.dart';
import 'package:design_test/pages/clim_page/blocs/ac_prog/ac_prog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/car_bloc/car_bloc.dart';
import 'components/clim_controler_panel.dart';

class Clim extends StatelessWidget {
  const Clim({super.key});

  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          print("in Clim");
          if(state is GetCarSuccess){
            final car = state.car;
            print("in Success");
            context.read<AcProgBloc>().add(GetAllActiveProg());
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),


                NextProgList()
                // BlocProvider(
                //   create: (context) => AcProgBloc(context.read<CarBloc>().apiCarRepo)..add(GetAllActiveProg()),
                //   child: NextProgList()
                // )

              ],
            );
          }else if(state is GetCarReLoadFailure){
            final Car car = state.car;
            return CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate: ClimControl(car :car),
                ),
                BlocProvider(
                    create: (context) => AcProgBloc(context.read<CarBloc>().apiCarRepo)..add(GetAllActiveProg()),
                    child: const NextProgList()
                )
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



