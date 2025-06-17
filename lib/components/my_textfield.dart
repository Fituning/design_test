import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final TextCapitalization textCapitalization ;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.prefixIcon,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        // suffixIcon: FaIcon(FontAwesomeIcons.lock),
        labelText: labelText, // Ajout du label
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary), // Style du label
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary), // Ligne grise claire
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary, width: 3.0), // Ligne bleue
        ),
        fillColor: Theme.of(context).colorScheme.surfaceContainer, // Fond blanc
        filled: true, // Active le fond
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Espacement interne

        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500]),
        errorText: errorMsg,
      ),
    );
  }
}