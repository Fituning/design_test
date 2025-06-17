// TODO Implement this library.import 'package:flutter/cupertino.dart';
import 'package:design_test/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/sign_in/sign_in_bloc.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = FontAwesomeIcons.eyeSlash;
  bool obscurePassword = true;
  String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    emailController.text = "user1@softcar.ch";
    passwordController.text = "User1234%";

    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if(state is SignInSuccess) {
          setState(() {
            signInRequired = false;
          });
        } else if(state is SignInLoading) {
          setState(() {
            signInRequired = true;
          });
        } else if(state is SignInFailure) {
          setState(() {
            signInRequired = false;
            _errorMsg = state.error;
          });
        }
      },
  child: Form(
      key: _formKey,
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MyTextField(
              controller: emailController,
              labelText: "Email",
              hintText: '',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              // prefixIcon: FaIcon(FontAwesomeIcons.at),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Please fill in this field';
                } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                  return 'Please enter a valid email';
                }
                return null;
              }
          ),
          
          const SizedBox(height: 24,),
          
          MyTextField(
            controller: passwordController,
            labelText: "Password",
            hintText: '',
            obscureText: obscurePassword,
            keyboardType: TextInputType.visiblePassword,
            // validator: (val) {
            //   if (val!.isEmpty) {
            //     return 'Please fill in this field';
            //   } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
            //     return 'Please enter a valid password';
            //   }
            //   return null;
            // },
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                  if(obscurePassword) {
                    iconPassword = FontAwesomeIcons.eye;
                  } else {
                    iconPassword = FontAwesomeIcons.eyeSlash;
                  }
                });
              },
              icon: Icon(iconPassword),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {          },
                child: Text(
                  "Mot de passe oublié",
                  style: GoogleFonts.roboto(
                    color: Theme.of(context).colorScheme.primary,
                    // decoration: TextDecoration.underline,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24,),

          if (_errorMsg != null)
            Text(
              _errorMsg!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),

          !signInRequired ? ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignInBloc>().add(SignInRequired(
                      emailController.text,
                      passwordController.text)
                  );
                }
              },
              style: TextButton.styleFrom(
                  elevation: 3.0,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60)
                  )
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                  ),
                ),
              )
          ): const CircularProgressIndicator()
        ],
      ),
    )),
);
  }
}