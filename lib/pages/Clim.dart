import 'package:design_test/components/ElevatedButton.dart';
import 'package:design_test/components/next_prog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../components/TopNavBar.dart';
import '../components/clim_controler_panel.dart';

class Clim extends StatelessWidget {
  const Clim({super.key});

  @override
  Widget build(BuildContext context) {
    return
      CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: ClimControl(),
        ),
        NextProgList()
      ],
    );
  }
}

class Clim2 extends StatelessWidget {
  const Clim2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircularElevatedButton(
        icon: const FaIcon(
          FontAwesomeIcons.clock,
          size: 38,
        ),
        elevation: 8,
        padding: EdgeInsets.all(16),
        bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: ClimControl(),
                  ),
                  NextProgList()
                ],
              ),
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: const NavBar(),
    );
  }
}

class ClimControl extends SliverPersistentHeaderDelegate {
  double expandedHeight = 570;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // print(context.size!.height);
    return ClimControllerPanel(expandedHeight: expandedHeight);
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


