import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    this.pageIndex =2,
    required this.onPageChanged ,
  });

  final int pageIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 12
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Container(
            child: BottomNavigationBar(
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
                selectedItemColor: Theme.of(context).colorScheme.secondary,
                currentIndex: pageIndex,
                onTap: (value){
                  onPageChanged(value);
                },
                unselectedItemColor:
                Theme.of(context).colorScheme.onSurface,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    label: "entretien",
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const FaIcon(FontAwesomeIcons.wrench,size: 24,),
                        ),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "entretien",
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const FaIcon(FontAwesomeIcons.temperatureLow,size: 24,),
                        ),
                      ],
                    ),
                  ),
                  const BottomNavigationBarItem(
                      label: "home", icon: FaIcon(FontAwesomeIcons.house,size: 32)),
                  BottomNavigationBarItem(
                    label: "entretien",
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: const BoxDecoration(
                                color: Color(0x00FFFFFF),
                                borderRadius: BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: FaIcon(FontAwesomeIcons.fire,size: 24,color: Theme.of(context).colorScheme.primaryContainer),
                        ),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "entretien",
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            height: 6,
                            width: 6,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const FaIcon(FontAwesomeIcons.plug,size: 24,),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}