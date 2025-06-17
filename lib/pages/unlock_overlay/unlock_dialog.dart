import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/car_bloc/car_bloc.dart';
import '../../components/ElevatedButton.dart';

class CarLockDialog extends StatefulWidget {
  const CarLockDialog({super.key});

  @override
  State<CarLockDialog> createState() => _CarLockDialogState();
}

class _CarLockDialogState extends State<CarLockDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: BlocBuilder<CarBloc, CarState>(
            builder: (context, state) {
              if (state is CarLoadedState) {
                var car = state.car;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ... haut du dialog
                    Flexible(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Image.asset(
                                "assets/images/softcar_top.png",
                                fit: BoxFit.fitWidth,
                                width: constraints.maxWidth - 40,
                                height: constraints.maxHeight - 40,
                              ),
                              // Bouton capot
                              Positioned(
                                top: 10,
                                child: CircularElevatedButton(
                                  icon: const FaIcon(FontAwesomeIcons.unlock),
                                  iconClicked:
                                      const FaIcon(FontAwesomeIcons.lock),
                                  onPressed: () {
                                    setState(() {
                                      car.hood = toggleDoorStatus(car.hood);
                                      context.read<CarBloc>().add(
                                          const UpdateDoorState(
                                              door: DoorEnum.hood));
                                    });
                                  },
                                  iconSize: 28,
                                  padding: const EdgeInsets.all(16),
                                  elevation: 6,
                                  bgColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow,
                                  value: car.hood == DoorStatusEnum.close,
                                ),
                              ),
                              // Bouton gauche
                              Positioned(
                                left: 60,
                                child: CircularElevatedButton(
                                  icon: const FaIcon(FontAwesomeIcons.unlock),
                                  iconClicked:
                                      const FaIcon(FontAwesomeIcons.lock),
                                  onPressed: () {
                                    setState(() {
                                      car.leftDoor =
                                          toggleDoorStatus(car.leftDoor);
                                      context.read<CarBloc>().add(
                                          const UpdateDoorState(
                                              door: DoorEnum.left));
                                    });
                                  },
                                  iconSize: 28,
                                  padding: const EdgeInsets.all(16),
                                  elevation: 6,
                                  bgColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow,
                                  value: car.leftDoor == DoorStatusEnum.close,
                                ),
                              ),
                              // Bouton droit
                              Positioned(
                                right: 60,
                                child: CircularElevatedButton(
                                  icon: const FaIcon(FontAwesomeIcons.unlock),
                                  iconClicked:
                                      const FaIcon(FontAwesomeIcons.lock),
                                  onPressed: () {
                                    setState(() {
                                      car.rightDoor =
                                          toggleDoorStatus(car.rightDoor);
                                      context.read<CarBloc>().add(
                                          const UpdateDoorState(
                                              door: DoorEnum.right));
                                    });
                                  },
                                  iconSize: 28,
                                  padding: const EdgeInsets.all(16),
                                  elevation: 6,
                                  bgColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow,
                                  value: car.rightDoor == DoorStatusEnum.close,
                                ),
                              ),
                              // Bouton global
                              Positioned(
                                right: -14,
                                bottom: -14,
                                child: CircularElevatedButton(
                                  icon: const FaIcon(FontAwesomeIcons.unlock),
                                  onPressed: () {
                                    setState(() {
                                      car = toggleAllDoors(car);
                                      context.read<CarBloc>().add(
                                          const UpdateDoorState(
                                              door: DoorEnum.all));
                                    });
                                  },
                                  iconSize: 33,
                                  padding: const EdgeInsets.all(24),
                                  elevation: 6,
                                  bgColor: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerLow,
                                  value: car.hood == DoorStatusEnum.close &&
                                      car.leftDoor == DoorStatusEnum.close &&
                                      car.rightDoor == DoorStatusEnum.close,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

DoorStatusEnum toggleDoorStatus(DoorStatusEnum current) {
  return current == DoorStatusEnum.close
      ? DoorStatusEnum.open
      : DoorStatusEnum.close;
}

Car toggleAllDoors(Car car) {
  final allClosed = car.hood == DoorStatusEnum.close &&
      car.leftDoor == DoorStatusEnum.close &&
      car.rightDoor == DoorStatusEnum.close;

  final newStatus = allClosed ? DoorStatusEnum.open : DoorStatusEnum.close;

  car.hood = newStatus;
  car.leftDoor = newStatus;
  car.rightDoor = newStatus;

  return car;
}
