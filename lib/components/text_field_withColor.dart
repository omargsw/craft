import 'package:craft/components/color.dart';
import 'package:craft/components/font.dart';
import 'package:flutter/material.dart';

class TextFieldWithColorWidget extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? inputType;
  final bool ob;
  final Icon? prefixIcon;
  final IconButton? suffixIconButton;
  final String? type;
  const TextFieldWithColorWidget({
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
          style: TextStyle(color: AppColors.primaryColor),
          cursorColor: Colors.white,
          keyboardType: inputType,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIconButton,
            labelText: labelText,
            labelStyle: AppFonts.tajawal16PrimapryW600,
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
              borderSide: BorderSide(
                color: AppColors.primaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.0,
              ),
            ),
          ),
          obscureText: ob,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "required";
            }
            return null;
          },
        ),
      ),
    );
  }
}
