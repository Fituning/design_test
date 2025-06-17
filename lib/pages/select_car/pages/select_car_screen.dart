import 'package:api_car_repository/api_car_repository.dart';
import 'package:design_test/pages/select_car/blocs/get_car/get_car_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/select_car/select_car_bloc.dart';

class SelectCarScreen extends StatefulWidget {
  const SelectCarScreen({super.key});

  @override
  State<SelectCarScreen> createState() => _SelectCarScreenState();
}

class _SelectCarScreenState extends State<SelectCarScreen> {
  final vinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool getCarRequired = false;

  String? _errorMsg; //todo place

  void _addCar([String? value]) {
    if (_formKey.currentState!.validate()) {
      // Déclencher l'action de connexion
      context.read<SelectCarBloc>().add(AddCar(vinController.text));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<GetCarBloc>().add(GetCars());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Vérifier si l'espace est suffisant pour afficher l'image
        final isEnoughSpace = constraints.maxHeight >
            400; // Ajustez la valeur selon la taille de votre image.

        return BlocListener<SelectCarBloc, SelectCarState>(
          listener: (context, state) {
            if (state is SelectCarSuccess) {
              setState(() {
                getCarRequired = false;
              });
            } else if (state is SelectCarLoading) {
              setState(() {
                getCarRequired = true;
              });
            } else if (state is SelectCarFailure) {
              setState(() {
                getCarRequired = false;
                _errorMsg = state.error;
              });
            }
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: BlocBuilder<GetCarBloc, GetCarState>(
                builder: (context, state) {
                  if (state is GetCarLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetCarSuccess) {
                    // Récupérez la liste des voitures depuis l'état
                    final cars = state
                        .cars; // Assurez-vous que GetCarSuccess a une propriété "cars"

                    if (cars.isEmpty) {
                      return const Center(
                        child: Text("No cars available"),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ListView.builder(
                            itemCount: cars.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final car =
                                  cars[index]; // Récupérez chaque voiture
                              return carSelectButton(car);
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetCarFailure) {
                    return Center(
                      child: Text(
                        state.error, // Utilisez l'erreur depuis l'état
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Afficher un widget par défaut si l'état est autre
                  return const Center(
                    child: Text("Please fetch cars"),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget carSelectButton(Car car) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          context.read<SelectCarBloc>().add(SelectCar(car.vin));
        }, // todo Action au clic
        borderRadius: BorderRadius.circular(16.0), // Coins arrondis
        splashColor: Colors.blue.withOpacity(0.3), // Effet ripple
        child: Card(
          elevation: 5, // Ombre pour l'effet 3D
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    "assets/images/softcar_${car.color}.png",
                    height: 60, // Hauteur de l'image
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Car VIN : ${car.vin}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Registration : 12/11/2024",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
