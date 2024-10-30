import 'package:flutter/material.dart';


class CircularElevatedButton extends StatelessWidget {
  const CircularElevatedButton(
      {super.key,
        required this.icon,
        this.iconClicked,
        required this.onPressed,
        this.bgColor,
        this.padding,
        this.clickable = true,
        this.iconSize = 28,
        this.iconColor,
        this.elevation = 4,
        this.enable = true,
        this.value = false,
      });

  final Widget icon;
  final Widget? iconClicked;
  final double iconSize;
  final Color? iconColor;
  final Color? bgColor;
  final double elevation;

  final EdgeInsets? padding;

  final bool clickable;
  final VoidCallback? onPressed ;
  final bool enable;
  final bool value;

  bool _isPaddingEqual(EdgeInsets padding) {
    // Vérifie si tous les côtés du padding sont égaux
    return padding.left == padding.top &&
        padding.top == padding.right &&
        padding.right == padding.bottom;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: value ? iconClicked ?? icon : icon,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>( !value ? bgColor ?? Theme.of(context).colorScheme.surfaceContainerLow : iconColor ?? Theme.of(context).colorScheme.primary),
        iconColor: WidgetStatePropertyAll<Color>( !value ? (enable ? iconColor ?? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.primaryContainer):
        (enable ? bgColor ?? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1))

        ),
        elevation: WidgetStatePropertyAll<double>(elevation),
        shadowColor: WidgetStatePropertyAll<Color>(Theme.of(context).colorScheme.shadow),
        shape: _isPaddingEqual(padding ?? const EdgeInsets.all(16)) ? WidgetStateProperty.all(const CircleBorder()) : null,
      ),
      alignment: Alignment.center,
      iconSize: iconSize,
      padding: padding ?? const EdgeInsets.all(16),
      onPressed: onPressed,
    );
  }
}
