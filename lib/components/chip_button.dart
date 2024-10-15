import 'package:flutter/material.dart';

import 'NotifPastille.dart';

class ChipButton extends StatelessWidget {
  const ChipButton({super.key, required this.icon});

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: NotificationBadge(
                activeColor: Theme.of(context).colorScheme.secondary,
                inactiveColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
            Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: icon),
          ],
        ));
  }
}