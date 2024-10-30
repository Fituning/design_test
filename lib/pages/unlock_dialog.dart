// CarLockDialog.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/ElevatedButton.dart';

class CarLockDialog extends StatelessWidget {
  const CarLockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.xmark,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    iconSize: 20,
                    color: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.zero, // Enlève le padding si nécessaire
                    constraints: const BoxConstraints(), // Supprime les contraintes pour une taille personnalisée
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Expanded(child: Image.asset(
                        "assets/images/softcar_top.png",
                        fit: BoxFit.fitWidth,
                        width: MediaQuery.of(context).size.width-150,
                        alignment: Alignment.topCenter,
                      )),
                      Positioned(
                        right: -14,
                          bottom: -14,
                          child: CircularElevatedButton(
                            icon: const FaIcon(FontAwesomeIcons.unlock,),
                            onPressed: () {  },
                            iconSize: 33,
                            padding: const EdgeInsets.all(24),
                            elevation: 6,
                            bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
                          )
                      ),
                  
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
