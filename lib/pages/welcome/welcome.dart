import 'package:api_user_repository/api_user_repository.dart';
import 'package:design_test/pages/welcome/pages/sign_in_screen.dart';
import 'package:design_test/pages/welcome/pages/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import 'blocs/sign_in/sign_in_bloc.dart';
import 'blocs/sign_up/sign_up_bloc.dart';

enum AuthView { signIn, signUp }

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;
  AuthView currentAuthView = AuthView.signIn;


  @override
  Widget build(BuildContext context) {
    final Widget authMethod = _buildAuthView();

    return Scaffold(
      resizeToAvoidBottomInset: true, // Permet d'ajuster la vue lors de l'apparition du clavier
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 76),
                          Image.asset(
                            "assets/images/logo_softcar.png",
                            width: MediaQuery.of(context).size.width / 3 * 2,
                          ),
                          const SizedBox(height: 32),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                authMethod,
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      currentAuthView = currentAuthView == AuthView.signIn
                                          ? AuthView.signUp
                                          : AuthView.signIn;
                                    });
                                  },
                                  child: Text(
                                    currentAuthView == AuthView.signIn
                                        ? "Switch to Sign Up"
                                        : "Switch to Sign In",
                                    style: GoogleFonts.roboto(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Méthode pour obtenir la methode d'authentification
  Widget _buildAuthView() {
    switch (currentAuthView) {
      case AuthView.signIn:
        return BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
              context.read<AuthBloc>().apiUserRepo
          ),
          child: const SignInScreen(),
        );
      case AuthView.signUp:
        return BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(
              context.read<AuthBloc>().apiUserRepo
          ),
          child: const SignUpScreen(),
        );
    }
  }
}