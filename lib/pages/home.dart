import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/components/notification_overlay_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import '../bloc/car_bloc/car_bloc.dart';
import '../components/circular_info_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late final AnimatedMapController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimatedMapController(vsync: this);
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final MapController mapController =  _animCtrl.mapController;

    return BlocListener<CarBloc, CarState>(
      listenWhen: (prev, curr) => curr is CarLoadedState,
      listener: (context, state) {
        if (state is CarLoadedState) {
          final LatLng newCenter = LatLng(
            state.car.gpsLocation.coordinates[0],
            state.car.gpsLocation.coordinates[1],
          );
          _animCtrl.animateTo(
            dest: newCenter,
            rotation: 0,
            zoom: _animCtrl.mapController.camera.zoom,
            customId: null, // ou un
          );
          // mapController.move(
          //   newCenter,
          //   mapController.camera.zoom,
          //   // mapController.camera.rotation,
          //   // duration: const Duration(milliseconds: 500),
          // );
        }
      },
  child: Container(
      color: Theme.of(context).colorScheme.surface,
      child: BlocBuilder<CarBloc, CarState>(
  builder: (context, state) {
    if(state is CarLoadedState){
      final car = state.car;
      final msg = state is GetCarReLoadFailure ? state.msg : null;
      final LatLng centerPoint = LatLng(car.gpsLocation.coordinates[0],car.gpsLocation.coordinates[1]);


      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 13 / 24,
            width: MediaQuery.of(context).size.width,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: centerPoint,
                initialZoom: 16.0,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom,
                ),
                onPositionChanged: (MapPosition pos, bool hasGesture) {
                  if (hasGesture && pos.center != centerPoint) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      mapController.move(centerPoint, pos.zoom ?? 13.0);
                    });
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  // subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                        point: centerPoint,
                        width: 60,
                        height: 60,
                        child:  Image.asset(
                          "assets/images/softcar_top.png",
                          width: 24,
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "My Softcar".toUpperCase(),
                      style: GoogleFonts.teko(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child:  _Display(car: car,errorMessage: msg ,)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }else {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 13 / 24,
            width: MediaQuery.of(context).size.width,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: LatLng(0, 0), // 🌍 Centre du monde
                zoom: 2.0,            // 🔍 Zoom global
                interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom,
                onPositionChanged: (MapPosition pos, bool hasGesture) {
                  if (hasGesture && pos.center != LatLng(0, 0)) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      mapController.move(LatLng(0, 0), pos.zoom ?? 2.0);
                    });
                  }
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: Center(
                  child: Text("An error has occurred while loading home page"),
                ),
              ),
            ),
          ),
        ],
      );
    }

  },
),
    ),
);
  }
}

class _Display extends StatelessWidget {
  final Car car;
  final String? errorMessage;

  const _Display({
    required this.car,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    // Afficher le SnackBar si showConnectionError est true
    if (errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final overlay = Overlay.of(context);
        final overlayEntry = OverlayEntry(
          builder: (context) => NotificationOverlayBar(
            message: errorMessage??"",
            icon: FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Theme.of(context).colorScheme.onError,
              size: 34,
            ),
          )
        );

        // Insérer l'overlay
        overlay.insert(overlayEntry);

        // Retirer l'overlay après 3 secondes
        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CircularInfoTile(
            icon: const FaIcon(FontAwesomeIcons.batteryHalf),
            label: "Battery",
            value: car.battery.chargeLevel.toString(), // Utilisez la valeur de la batterie
            unit: "%",
            iconColor: car.battery.chargeLevel < 10
                ? Theme.of(context).colorScheme.onError
                : (car.battery.chargeLevel > 85 ? Theme.of(context).colorScheme.onTertiary: null ),
            bgColor: car.battery.chargeLevel < 10
                ? Theme.of(context).colorScheme.error
                : (car.battery.chargeLevel > 85 ? Theme.of(context).colorScheme.tertiary: null ),
          ),
        ),
        Expanded(
          child: CircularInfoTile(
            icon: const FaIcon(FontAwesomeIcons.route),
            label: "Range",
            value: car.remainingRange.toString(), // Remplacez par car.range si vous avez cette propriété
            unit: "km",
            iconColor: car.remainingRange < 40
                ? Theme.of(context).colorScheme.onError
                : null,
            bgColor: car.remainingRange < 40
                ? Theme.of(context).colorScheme.error
                : null,
          ),
        ),
        Expanded(
          child: CircularInfoTile(
            icon: _getChargeIcon(
              car.chargingSocketIsConnected,
              car.chargeIsActivated,
            ),
            label: "Status",
            value: car.chargingSocketIsConnected
                ? (car.chargeIsActivated ? "Charging" : "Plugged")
                : "Unplugged", // Exemple de statut
            iconColor: !car.chargingSocketIsConnected
                ? Theme.of(context).colorScheme.onError
                : null,
            bgColor: !car.chargingSocketIsConnected
                ? Theme.of(context).colorScheme.error
                : null,
          ),
        ),
      ],
    );
  }

  Widget _getChargeIcon(bool chargingSocketIsConnected, bool chargeIsActivated) {
    if (chargingSocketIsConnected) {
      if (chargeIsActivated) {
        return const FaIcon(FontAwesomeIcons.bolt);
      } else {
        return const FaIcon(FontAwesomeIcons.plugCircleCheck);
      }
    } else {
      return const FaIcon(FontAwesomeIcons.plugCircleXmark);
    }
  }
}





