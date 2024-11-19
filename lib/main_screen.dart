import 'package:design_test/bloc/car_bloc/car_bloc.dart';
import 'package:design_test/pages/Charge.dart';
import 'package:design_test/pages/Clim.dart';
import 'package:design_test/pages/home.dart';
import 'package:design_test/pages/maintenance.dart';
import 'package:design_test/pages/unlock_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'components/BottomNavBar.dart';
import 'components/ElevatedButton.dart';
import 'components/TopNavBar.dart';
import 'components/notification_overlay_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Widget page = _getPage();
    final Widget? floatingActionButton = _getFloatingActionButton();
    final FloatingActionButtonLocation floatingActionLocation = _getFabLocation();

    return Scaffold(
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionLocation,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              BlocBuilder<CarBloc, CarState>(
                builder: (context, state) {
                  print("main bloc builder");
                  if (state is GetCarSuccess || state is GetCarReLoadFailure) {
                    return page;
                  } else if (state is GetCarLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: Text("An error has occurred in main page"));
                  }
                },
              ),
              const Positioned(top: 0, left: 0, child: TopNavBar()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        pageIndex: pageIndex,
        onPageChanged: (value) {
          if (value != 4) {
            setState(() {
              context.read<CarBloc>().add(GetCar());
              pageIndex = value;
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final overlay = Overlay.of(context);
              final overlayEntry = OverlayEntry(
                  builder: (context) => NotificationOverlayBar(
                    message: "Pas de composant REX associée ",
                    color: Theme.of(context).colorScheme.primaryContainer,
                    icon: FaIcon(
                      FontAwesomeIcons.fire,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
        },
      ),
    );
  }

  /// Méthode pour obtenir la page
  Widget _getPage() {
    switch (pageIndex) {
      case 0:
        return const Maintenance();
      case 1:
        return const Clim();
      case 2:
        return const Home();
      case 3:
        return const Charge();
      default:
        return const Home();
    }
  }

  /// Méthode pour obtenir le FloatingActionButton
  Widget? _getFloatingActionButton() {
    switch (pageIndex) {
      case 1:
      case 3:
        return _buildCircularElevatedButton(
          icon: FontAwesomeIcons.clock,
          size: 42,
          padding: 16,
        );
      case 2:
        return _buildCircularElevatedButton(
          icon: FontAwesomeIcons.unlock,
          size: 42,
          padding: 24,
          onPressed: () => _showUnlockDialog(),
        );
      default:
        return null;
    }
  }

  /// Méthode pour construire le CircularElevatedButton
  Widget _buildCircularElevatedButton({
    required IconData icon,
    required double size,
    required double padding,
    VoidCallback? onPressed,
  }) {
    return CircularElevatedButton(
      icon: FaIcon(icon, size: size),
      padding: EdgeInsets.all(padding),
      bgColor: Theme.of(context).colorScheme.surfaceContainerLow,
      onPressed: onPressed ?? () {},
    );
  }

  /// Méthode pour afficher la boîte de dialogue de déverrouillage
  void _showUnlockDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CarLockDialog();
      },
    );
  }

  /// Méthode pour obtenir la position du FloatingActionButton
  FloatingActionButtonLocation _getFabLocation() {
    return pageIndex == 2 ? CustomFabLocation() : FloatingActionButtonLocation.centerFloat;
  }
}

class CustomFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double bottomBarHeight = scaffoldGeometry.scaffoldSize.height;

    return Offset(
      scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width -
          16,
      scaffoldGeometry.scaffoldSize.height * 13 / 24,
    );
  }
}
