// TODO Implement this library.import 'package:flutter/cupertino.dart';
import 'package:design_test/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../welcome/blocs/sign_in/sign_in_bloc.dart';
import '../bloc/select_car_bloc.dart';



class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final vinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool selectCarRequired = false;
  String? _errorMsg;

  void _addCar([String? value]) {
    if (_formKey.currentState!.validate()) {
      // Déclencher l'action de connexion
      context.read<SelectCarBloc>().add(
        AddCar(vinController.text)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Vérifier si l'espace est suffisant pour afficher l'image
        final isEnoughSpace = constraints.maxHeight > 400; // Ajustez la valeur selon la taille de votre image.

        return BlocListener<SelectCarBloc, SelectCarState>(
          listener: (context, state) {
            if(state is SelectCarSuccess){
              setState(() {
                selectCarRequired = false;
              });
            }else if( state is SelectCarLoading){
              setState(() {
                selectCarRequired = true;
              });
            }else if(state is SelectCarFailure){
              setState(() {
                selectCarRequired = false;
                _errorMsg = state.error;
              });
            }
          },
          child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pas encore de voiture ajoutée",
                          style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (isEnoughSpace) // Afficher l'image uniquement si l'espace est suffisant
                          Image.asset(
                            "assets/images/Mango-cherry.png",
                            width: MediaQuery.of(context).size.width - 48,
                          ),
                        const SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              children: [
                                MyTextField(
                                  controller: vinController,
                                  labelText: "Numéro VIN",
                                  hintText: '',
                                  obscureText: false,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted : _addCar,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return 'Please fill in this field';
                                    }
                                    return null;
                                  },
                                ),


                                const SizedBox(height: 24),
                                if (_errorMsg != null)
                                  Text(
                                    _errorMsg!,
                                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                                  ),


                                !selectCarRequired ? ElevatedButton(
                                  onPressed: _addCar,
                                  style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                                    child: Text(
                                      'add car',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ): const CircularProgressIndicator(),
                                const SizedBox(height: 76),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

}