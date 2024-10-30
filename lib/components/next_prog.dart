import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../pages/Clim.dart';

class NextProgList extends StatelessWidget {
  const NextProgList({super.key});

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
                  "PROCHAINES PROGRAMMATIONS".toUpperCase(),
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
              NextProg(next: '',startTime:DateTime.now().add(const Duration(days: 1)),temperature: 23,),
              NextProg(next: '',startTime:DateTime.now().add(const Duration(days: 3)),temperature: 23.5105141458,           ),
              NextProg(next: '',startTime:DateTime.now().add(const Duration(days: 9)),temperature: 24,),
              NextProg(next: '',startTime:DateTime.now().add(const Duration(days: 1)),temperature: 23,),
              NextProg(next: '',startTime:DateTime.now().add(const Duration(days: 3)),temperature: 23.5105141458,           ),
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
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 48,
                      ),
                    ],
                  ),
                  const SizedBox(width: 4,),
                  Column(
                    children: [
                      Text(
                        DateFormat("HH:mm").format(startTime),
                        style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormat("HH:mm").format(startTime.add(const Duration(hours: 1))),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("prog 1"),
                  Text(
                    getFormattedDate(startTime),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
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
                        "${temperature.toStringAsFixed(1)}°C",
                        style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}

class NextProgOriginal extends StatelessWidget {
  const NextProgOriginal({
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 112,
                    child: Text(
                      getFormattedDate(startTime),
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    DateFormat("HH:mm").format(startTime),
                    style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.temperatureLow,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "${temperature.toStringAsFixed(1)}°C",
                    style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
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