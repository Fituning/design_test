import 'package:flutter/material.dart';

import 'NotifPastille.dart';

class ChipButton extends StatelessWidget {
  const ChipButton({
    super.key,
    required this.icon,
    this.value = false,
    this.onPressed,
    this.activeColor,
    this.inactiveColor
  });

  final Widget icon;
  final VoidCallback? onPressed ;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: NotificationBadge(
                activeColor: activeColor ?? Theme.of(context).colorScheme.secondary,
                inactiveColor: inactiveColor ?? Theme.of(context).colorScheme.primaryContainer,
                active: value,
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