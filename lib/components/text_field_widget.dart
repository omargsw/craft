import 'package:craft/components/font.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? inputType;
  final bool ob;
  final Icon? prefixIcon;
  final IconButton? suffixIconButton;
  final String? type;
  const TextFieldWidget({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.ob,
    required this.prefixIcon,
    required this.suffixIconButton,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Form(
        key: formKey,
        child: TextFormField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          keyboardType: inputType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIconButton,
            labelText: labelText,
            labelStyle: AppFonts.tajawal16WhiteW600,
            fillColor: Colors.white,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
          ),
          obscureText: ob,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "required";
            } else if (type == "name") {
              if (value.length < 5) {
                return "The name must be greater or equal to 5";
              }
            } else if (type == "email") {
              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return "enter the currected email";
              }
            } else if (type == "phone") {
              if (value.length != 10) {
                return "Phone number must be 10 numbers";
              }
            } else if (type == "pass") {
              if (value.length <= 6) {
                return "Password must be greater than 6 characters";
              }
            }
            return null;
          },
        ),
      ),
    );
  }
}
