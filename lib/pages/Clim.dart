import 'package:design_test/components/ElevatedButton.dart';
import 'package:design_test/components/NotifPastille.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../components/BottomNavBar.dart';
import '../components/TopNavBar.dart';
import '../components/Vent.dart';
import '../main.dart';

class Clim extends StatelessWidget {
  const Clim({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CircularElevatedButton(
        icon: const FaIcon(
          FontAwesomeIcons.clock,
          size: 38,
        ),
        elevation: 8,
        padding: 16,
        bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // to remove
              // Container(
              //   color: Colors.green,
              //   width: MediaQuery.of(context).size.width,
              //   child: Image.asset(
              //     "assets/images/Frame 185.png",
              //     fit: BoxFit.cover,
              //     alignment: Alignment.topCenter,
              //   ),
              // ),
              // to here
              Padding(
                padding: const EdgeInsets.only(top:76,left: 16,right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      VentController(),
                    const SizedBox(height: 38,),
                    const CircularProgressSlider(),
                    const SizedBox(height: 38,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 44.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ChipButton(
                              icon: Text(
                                "AC",
                                style: GoogleFonts.roboto(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(height: 28,width: 2,color: Theme.of(context).colorScheme.primary,),
                          Expanded(
                            child: ChipButton(
                                  icon: SvgPicture.asset(
                                    "assets/images/deg_avant.svg",
                                    height: 28,
                                  ),
                                ),
                          ),
                          Container(height: 28,width: 2,color: Theme.of(context).colorScheme.primary,),
                          Expanded(
                            child: ChipButton(
                              icon: SvgPicture.asset(
                                "assets/images/deg_arriere.svg",
                                height: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32,),
                    Text(
                      "PROCHAINES PROGRAMMATIONS".toUpperCase(),
                      style: GoogleFonts.teko(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 24,),
                    NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 1)), temperature: 23,),
                    NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 3)), temperature: 23.5105141458,),
                    NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 9)), temperature: 24,),
                  ],
                ),
              ),
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
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
        padding: 16,
        bgColor: Theme.of(context).colorScheme.surfaceContainerLow, onPressed: () {  },
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
                  SliverToBoxAdapter(
                    child: Card(
                      elevation: 12,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      shadowColor: Theme.of(context).colorScheme.shadow,
                      child: Padding(
                        padding: const EdgeInsets.all( 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "PROCHAINES PROGRAMMATIONS".toUpperCase(),
                              style: GoogleFonts.teko(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 24,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 1)), temperature: 23,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 3)), temperature: 23.5105141458,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 9)), temperature: 24,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 1)), temperature: 23,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 3)), temperature: 23.5105141458,),
                            NextProg(next: '', startTime: DateTime.now().add(const Duration(days: 9)), temperature: 24,),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}

class ClimControl extends SliverPersistentHeaderDelegate{

  double expandedHeight =600;
  double roundedContainerHeight =60;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Padding(
        padding: const EdgeInsets.only(top:76,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VentController(),
            const SizedBox(height: 38,),
            const CircularProgressSlider(),
            const SizedBox(height: 38,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ChipButton(
                      icon: Text(
                        "AC",
                        style: GoogleFonts.roboto(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface,
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(height: 28,width: 2,color: Theme.of(context).colorScheme.primary,),
                  Expanded(
                    child: ChipButton(
                      icon: SvgPicture.asset(
                        "assets/images/deg_avant.svg",
                        height: 28,
                      ),
                    ),
                  ),
                  Container(height: 28,width: 2,color: Theme.of(context).colorScheme.primary,),
                  Expanded(
                    child: ChipButton(
                      icon: SvgPicture.asset(
                        "assets/images/deg_arriere.svg",
                        height: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: expandedHeight =600 - roundedContainerHeight - shrinkOffset,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: roundedContainerHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 60,
                  height: 5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            )
          ],
        ),
      ),]
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}

class NextProg extends StatelessWidget {
  const NextProg({
    super.key,
    required this.next,
    required this.startTime,
    required this.temperature,
  });
  
  final String next;
  final DateTime startTime;
  final double temperature;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 112 ,
                    child: Text(
                      getFormattedDate(startTime),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(width: 6,),
                  Text(
                    DateFormat("HH:mm").format(startTime),
                    style: GoogleFonts.roboto(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.temperatureLow,color: Theme.of(context).colorScheme.primary, size: 24,),
                  const SizedBox(width: 6,),
                  Text(
                    "${temperature.toStringAsFixed(1)}°C",
                    style: GoogleFonts.roboto(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
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
    return DateFormat('EEEE').format(startTime); // Jour de la semaine (Lundi, Mardi, ...)
  }

  // Si c'est plus d'une semaine à partir de maintenant
  return DateFormat('dd/MM').format(startTime); // Format DD/MM/YYYY
}

class ChipButton extends StatelessWidget {
  const ChipButton({
    super.key,
    required this.icon
  });

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){},
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: NotificationBadge(activeColor: Theme.of(context).colorScheme.primaryContainer,),
            ),
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              child: icon
            ),
          ],
        )
    );
  }
}



