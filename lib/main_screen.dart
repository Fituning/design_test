import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/bloc/car_bloc/car_bloc.dart';
import 'package:design_test/pages/Charge.dart';
import 'package:design_test/pages/clim_page/Clim.dart';
import 'package:design_test/pages/clim_page/blocs/ac_prog/ac_prog_bloc.dart';
import 'package:design_test/pages/clim_page/clim_prog.dart';
import 'package:design_test/pages/home.dart';
import 'package:design_test/pages/maintenance.dart';
import 'package:design_test/pages/unlock_overlay/unlock_dialog.dart';
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
  int pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    // final Widget page = _getPage();
    // final Widget? floatingActionButton = _getFloatingActionButton();
    final FloatingActionButtonLocation floatingActionLocation =
        _getFabLocation();

    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        if (state is CarLoadedState) {
          final Widget page = _getPage();
          final Widget? floatingActionButton =
              _getFloatingActionButton(state.car);

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
                    page,
                    const Positioned(top: 0, left: 0, child: TopNavBar()),
                  ],
                ),
              ),
            ),

            /*bottomNavigationBar: BottomNavigationBar(
          items: const [
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house),label: "1"),
        BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "2")
      ],
        type: BottomNavigationBarType.fixed,//pour la mettre en transparente
      ),*/
            bottomNavigationBar: NavBar(
              pageIndex: pageIndex,
              onPageChanged: (value) {
                if (value != 4) {
                  context.read<CarBloc>().add(GetCar());
                  if (pageIndex != value) {
                    setState(() {
                      pageIndex = value;
                    });
                  }
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    final overlay = Overlay.of(context);
                    final overlayEntry = OverlayEntry(
                        builder: (context) => NotificationOverlayBar(
                              message: "Pas de composant REX associée ",
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              icon: FaIcon(
                                FontAwesomeIcons.fire,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                size: 34,
                              ),
                            ));

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
        } else if (state is GetCarLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(
              child: Text("An error has occurred in main page"));
        }
      },
    );
  }

  /// Méthode pour obtenir la page
  Widget _getPage() {
    switch (pageIndex) {
      case 0:
        return const Maintenance();
      case 1:
        return BlocProvider(
            create: (context) => AcProgBloc(context.read<CarBloc>().apiCarRepo),
            child: const Clim());
      case 2:
        return const Home();
      case 3:
        return const Charge();
      default:
        return const Home();
    }
  }

  /// Méthode pour obtenir le FloatingActionButton
  Widget? _getFloatingActionButton(Car car) {
    switch (pageIndex) {
      case 1:
        return buildCircularElevatedButton(
            icon: FontAwesomeIcons.clock,
            size: 42,
            padding: 16,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const ClimProg()));
            });
      case 2:
        return buildCircularElevatedButton(
          icon: FontAwesomeIcons.unlock,
          size: 42,
          padding: 24,
          onPressed: () => _showUnlockDialog(),
        );
      case 3:
        return buildCircularElevatedButton(
            icon: FontAwesomeIcons.clock,
            size: 42,
            padding: 16,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Placeholder()));
            });
      default:
        return null;
    }
  }

  /// Méthode pour construire le CircularElevatedButton
  Widget buildCircularElevatedButton({
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
    final carBloc = context.read<CarBloc>();

    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: carBloc,
        child: const CarLockDialog(),
      ),
    );
  }

  /// Méthode pour obtenir la position du FloatingActionButton
  FloatingActionButtonLocation _getFabLocation() {
    return pageIndex == 2
        ? CustomFabLocation()
        : FloatingActionButtonLocation.centerFloat;
  }
}

class BuildCircularElevatedButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double padding;
  final VoidCallback? onPressed;

  const BuildCircularElevatedButton(
      {super.key,
      required this.icon,
      required this.size,
      required this.padding,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
