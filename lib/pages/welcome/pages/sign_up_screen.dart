// TODO Implement this library.import 'package:flutter/cupertino.dart';
import 'package:design_test/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/sign_up/sign_up_bloc.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordCheckController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IconData iconPassword = FontAwesomeIcons.eyeSlash;
  bool obscurePassword = true;
  bool signUpRequired = false;
  String? _errorMsg;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if(state is SignUpLoading) {
          setState(() {
            signUpRequired = true;
          });
        } else if(state is SignUpFailure) {
          setState(() {
            signUpRequired = false;
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
                  controller: firstNameController,
                  labelText: "First Name",
                  hintText: '',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }

                    if (RegExp(r'[0-9]').hasMatch(val)) {
                      return 'Numbers are not allowed';
                    }

                    if (!RegExp(r'^[A-Z]').hasMatch(val)) {
                      return 'The first letter must be uppercase';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24,),

                MyTextField(
                  controller: lastNameController,
                  labelText: "Last Name",
                  hintText: '',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  validator: (val){
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    }

                    if (RegExp(r'[0-9]').hasMatch(val)) {
                      return 'Numbers are not allowed';
                    }

                    if (!RegExp(r'^[A-Z]').hasMatch(val)) {
                      return 'The first letter must be uppercase';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24,),

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
                  onChanged: (val) {
                    if (val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() {
                        containsUpperCase = true;
                      });
                    } else {
                      setState(() {
                        containsUpperCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() {
                        containsLowerCase = true;
                      });
                    } else {
                      setState(() {
                        containsLowerCase = false;
                      });
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() {
                        containsNumber = true;
                      });
                    } else {
                      setState(() {
                        containsNumber = false;
                      });
                    }
                    if (val.contains(RegExp(
                        r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                      setState(() {
                        containsSpecialChar = true;
                      });
                    } else {
                      setState(() {
                        containsSpecialChar = false;
                      });
                    }
                    if (val.length >= 8) {
                      setState(() {
                        contains8Length = true;
                      });
                    } else {
                      setState(() {
                        contains8Length = false;
                      });
                    }
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
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

                const SizedBox(height: 24,),

                MyTextField(
                  controller: passwordCheckController,
                  labelText: "Confirm Password",
                  hintText: '',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (val != passwordController.text) {
                      return 'Passwords are not the same';
                    }
                    return null;
                  },
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

                const SizedBox(height: 24,),

                if (_errorMsg != null)
                  Text(
                    _errorMsg!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),

                !signUpRequired ? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignUpBloc>().add(SignUpRequired(
                            emailController.text,
                            passwordController.text,
                            firstNameController.text,
                            lastNameController.text,
                        )
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
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                ): const CircularProgressIndicator(),
              ],
            ),
          )),
    );
  }
}