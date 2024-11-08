import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationOverlayBar extends StatelessWidget {
  final String message;
  final Widget icon;
  final Color? color;
  const NotificationOverlayBar({
    super.key,
    required this.message,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 78,
      left: 24,
      right: 24,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                    spreadRadius: 3,
                    color: Theme.of(context).colorScheme.shadow.withOpacity(0.15)
                ),
                BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    spreadRadius: 0,
                    color: Theme.of(context).colorScheme.shadow.withOpacity(0.15),
                ),
              ]
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: color ?? Theme.of(context).colorScheme.error,
                child: icon,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    message,
                    style: GoogleFonts.roboto(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
