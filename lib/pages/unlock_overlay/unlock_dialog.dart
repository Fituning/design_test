import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/car_bloc/car_bloc.dart';
import '../../components/ElevatedButton.dart';

class CarLockDialog extends StatefulWidget {
  const CarLockDialog( {
    super.key,
    required this.car,
    required this.carBloc,
  });

  final Car car;
  final CarBloc carBloc;

  @override
  State<CarLockDialog> createState() => _CarLockDialogState();
}

class _CarLockDialogState extends State<CarLockDialog> {
  @override
  Widget build(BuildContext context) {
    Car car = widget.car;
    CarBloc carBloc = widget.carBloc;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.xmark),
                      onPressed: () => Navigator.of(context).pop(),
                      iconSize: 20,
                      color: Theme.of(context).colorScheme.onPrimary,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/images/softcar_top.png",
                            fit: BoxFit.fitWidth,
                            width: constraints.maxWidth - 40,
                            height: constraints.maxHeight - 40,
                          ),
                        ),

                        Positioned(
                          top: 10,
                          child: Align(
                            alignment : Alignment.topCenter,
                            child: CircularElevatedButton(
                              icon: const FaIcon(FontAwesomeIcons.unlock),
                              iconClicked : const FaIcon(FontAwesomeIcons.lock),
                              onPressed: () {
                                carBloc.add(const UpdateDoorState(door: DoorEnum.hood));
                              },
                              iconSize: 28,
                              padding: const EdgeInsets.all(16),
                              elevation: 6,
                              bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                              value: car.hood == DoorStatusEnum.close ,
                            ),
                          ),
                        ),

                        Positioned(
                          left: 60,
                          child: Align(
                            alignment : Alignment.center,
                            child: Builder(
                              builder: (context) => CircularElevatedButton(
                                icon: const FaIcon(FontAwesomeIcons.unlock),
                                iconClicked: const FaIcon(FontAwesomeIcons.lock),
                                onPressed: () {
                                  carBloc.add(const UpdateDoorState(door: DoorEnum.left));
                                },
                                iconSize: 28,
                                padding: const EdgeInsets.all(16),
                                elevation: 6,
                                bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                                value: car.leftDoor == DoorStatusEnum.close,
                              ),
                            )
                          ),
                        ),

                        Positioned(
                          right: 60,
                          child: Align(
                            alignment : Alignment.center,
                            child: CircularElevatedButton(
                              icon: const FaIcon(FontAwesomeIcons.unlock),
                              iconClicked : const FaIcon(FontAwesomeIcons.lock),
                              onPressed: () {
                                carBloc.add(const UpdateDoorState(door: DoorEnum.right));
                              },
                              iconSize: 28,
                              padding: const EdgeInsets.all(16),
                              elevation: 6,
                              bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                              value: car.rightDoor == DoorStatusEnum.close ,
                            ),
                          ),
                        ),

                        Positioned(
                          right: -14,
                          bottom: -14,
                          child: CircularElevatedButton(
                            icon: const FaIcon(FontAwesomeIcons.unlock),
                            onPressed: () {
                              carBloc.add(const UpdateDoorState(door: DoorEnum.all));
                            },
                            iconSize: 33,
                            padding: const EdgeInsets.all(24),
                            elevation: 6,
                            bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                            value: ( car.rightDoor == DoorStatusEnum.close &&  car.leftDoor == DoorStatusEnum.close && car.hood == DoorStatusEnum.close),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}