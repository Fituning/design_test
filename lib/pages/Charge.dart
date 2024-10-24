import 'package:design_test/components/ElevatedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/BottomNavBar.dart';
import '../components/TopNavBar.dart';
import '../components/circular_charge_gauge.dart';
import '../components/circular_info_tile.dart';

class Charge extends StatelessWidget {
  const Charge({super.key});

  @override
  Widget build(BuildContext context) {
    double spacing = 24;
    return Padding(
        padding: const EdgeInsets.only(top: 76, left: 16, right: 16,),
        child: ClipRRect(
          child: OverflowBox(
            fit: OverflowBoxFit.deferToChild,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: spacing/2,),
                CircularChargeGauge(),
                SizedBox(height: spacing,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: CircularInfoTile(
                            icon: FaIcon(FontAwesomeIcons.chargingStation),
                            label: "Temps de charge",
                            value: "53",
                            unit: "min",
                          )
                      ),
                      Expanded(
                          child: CircularInfoTile(
                            icon: FaIcon(FontAwesomeIcons.route),
                            label: "Autonomie",
                            value: "116",
                            unit: "km",
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing/2,),
                Expanded(child: Image.asset(
                  "assets/images/softcar_top.png",
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                ))
                // OverflowBox(fit: OverflowBoxFit.deferToChild, alignment: Alignment.topCenter, maxHeight: 600 ,child: Container(color: Colors.cyan,width: 350,height: 600,)),
              ],
            ),
          ),
        )
    );
  }
}






