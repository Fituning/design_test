import 'package:flutter/material.dart';


class CircularElevatedButton extends StatelessWidget {
  const CircularElevatedButton(
      {super.key,
        required this.icon,
        required this.onPressed,
        this.bgColor,
        this.padding = 16,
        this.clickable = true,
        this.iconSize = 28,
        this.iconColor,
        this.elevation = 4,
        this.enable = true
      });

  final Widget icon;
  final double iconSize;
  final Color? iconColor;
  final Color? bgColor;
  final double elevation;

  final double padding;

  final bool clickable;
  final VoidCallback? onPressed ;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon:icon,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>( bgColor ?? Theme.of(context).colorScheme.surfaceContainerLow),
        iconColor: WidgetStatePropertyAll<Color>( enable ? iconColor ?? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.primaryContainer),
        elevation: WidgetStatePropertyAll<double>(elevation),
        shadowColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.shadow),
        shape: WidgetStateProperty.all(const CircleBorder()),
      ),
      alignment: Alignment.center,
      iconSize: iconSize,
      padding: EdgeInsets.all(padding),
      onPressed: onPressed,
    );
  }
}
