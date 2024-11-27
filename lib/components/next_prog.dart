import 'package:api_car_repository/api_car_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NextProgList extends StatelessWidget {

  final List<ACProg?> acProgList;
  const NextProgList({super.key, required this.acProgList, });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 12
              )
            ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                width: 100,
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  acProgList.isNotEmpty ? "PROCHAINES PROGRAMMATIONS".toUpperCase() : "Aucune PROGRAMMATION prévue".toUpperCase(),
                  style: GoogleFonts.teko(
                      color:
                      Theme.of(context).colorScheme.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              ListView.builder(
                itemCount: acProgList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final acProg = acProgList[index]; // Récupérez chaque voiture
                  return acProg != null ? NextProg(acProg: acProg,): null;
                },
              ),
              const SizedBox(
                height: 128,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NextProg extends StatefulWidget {
  const NextProg({
    super.key,
    required this.acProg
  });

  final ACProg acProg;

  @override
  State<NextProg> createState() => _NextProgState();
}

class _NextProgState extends State<NextProg> {
  //todo check if prog is active or not
  @override
  Widget build(BuildContext context) {
    final prog = widget.acProg;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
            color:  Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
          border: Border(left: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 4)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 2,
                offset: const Offset(0,1)
            ),
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1)
            ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/images/time_arrow.svg",
                        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                        height: 53,
                      ),
                    ],
                  ),
                  const SizedBox(width: 4,),
                  Column(
                    children: [
                      Text(
                        DateFormat("HH:mm").format(prog.dateInitial),
                        style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat("HH:mm").format(prog.dateFinal),
                        style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 24,),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.temperatureHalf,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${prog.temperature.toStringAsFixed(1)}°C",
                              style: GoogleFonts.roboto(
                                  color: Theme.of(context).colorScheme.onSurface,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),

                          ],
                        ),
                        // Switch(
                        //   // This bool value toggles the switch.
                        //   activeTrackColor: Theme.of(context).colorScheme.primaryContainer,
                        //   inactiveThumbColor: Theme.of(context).colorScheme.primaryContainer,
                        //   inactiveTrackColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                        //   trackOutlineColor: WidgetStateProperty. resolveWith<Color?>((Set<WidgetState> states) {
                        //     if (!states.contains(WidgetState.selected)) {
                        //       return Theme.of(context).colorScheme.primaryContainer;
                        //     }
                        //     return null; // Use the default color.
                        //   }),
                        //   thumbIcon: WidgetStateProperty.resolveWith<Icon?>((Set<WidgetState> states) {
                        //     if (!states.contains(WidgetState.selected)) {
                        //       return const Icon(FontAwesomeIcons.xmark);
                        //     }else{
                        //       return Icon(
                        //           FontAwesomeIcons.check,
                        //         color: Theme.of(context).colorScheme.primaryContainer,
                        //       );
                        //     }
                        //     return null; // Use the default color.
                        //   }),
                        //
                        //   value: activeProg,
                        //   onChanged: (bool value){
                        //     setState(() {
                        //       activeProg = value;
                        //     });
                        //   },
                        // )

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                           prog.repetition.isEmpty
                               ? getFormattedDate(prog.dateInitial)
                               : prog.repetition.map((day) => day.toShortString()).join(", "), // Combine les noms des jours en une chaîne
                           overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(prog.name),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
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
    return DateFormat('EEEE')
        .format(startTime); // Jour de la semaine (Lundi, Mardi, ...)
  }

  // Si c'est plus d'une semaine à partir de maintenant
  return DateFormat('dd/MM').format(startTime); // Format DD/MM/YYYY
}