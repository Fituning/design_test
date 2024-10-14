import 'package:flutter/material.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    super.key,
    this.radius = 6,
    this.activeColor,
    this.inactiveColor,
    this.active = false,
    this.visible = true,
  });

  final double radius;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool active;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
          color: visible ? active ? activeColor : inactiveColor : Theme.of(context).colorScheme.surfaceContainerLowest,
          shape: BoxShape.circle,
      ),
    );
  }
}
