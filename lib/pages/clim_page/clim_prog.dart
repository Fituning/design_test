import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../bloc/car_bloc/car_bloc.dart';
import '../../components/BottomNavBar.dart';
import '../../components/ElevatedButton.dart';
import '../../components/notification_overlay_bar.dart';

class ClimProg extends StatelessWidget {
  const ClimProg({super.key});

  @override
  Widget build(BuildContext context) {
    const pageIndex = 1;
    return Scaffold(
      floatingActionButton: CircularElevatedButton(
        icon: SvgPicture.asset(
          "assets/images/clock_add.svg",
          height: 42,
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
        ),
        padding: const EdgeInsets.all(16),
        bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
        onPressed: () {
          //todo
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            // fit: StackFit.expand,
            children: [
              Container(
                color: Theme.of(context).colorScheme.surface,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularElevatedButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.chevronLeft,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        pageIndex: pageIndex,
        onPageChanged: (value) {
          if (value != 4) {
            context.read<CarBloc>().add(GetCar());
            if (pageIndex != value) {
              // setState(() {
              //   pageIndex = value;
              // });
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final overlay = Overlay.of(context);
              final overlayEntry = OverlayEntry(
                  builder: (context) => NotificationOverlayBar(
                        message: "Pas de composant REX associée ",
                        color: Theme.of(context).colorScheme.primaryContainer,
                        icon: FaIcon(
                          FontAwesomeIcons.fire,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          size: 34,
                        ),
                      ));

              // Insérer l'overlay
              overlay.insert(overlayEntry);

              // Retirer l'overlay après 3 secondes
              Future.delayed(const Duration(seconds: 3), () {
                overlayEntry.remove();
              });
            });
          }
        },
      ),
    );

    /* todo to keep for prog creation
    CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      initialTimerDuration: Duration(),
      onTimerDurationChanged: (Duration newDuration) {
        newDuration;
      },
    ),

    TimePickerDialog(initialTime: TimeOfDay.now())
    */
  }
}
