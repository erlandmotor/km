import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckTextFieldComponent extends StatelessWidget {

  const CheckTextFieldComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.validationMessage }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String validationMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
        const SizedBox(height: 6,),
        TextFormField(
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          validator: (value) {
            if(value!.isEmpty) {
              return validationMessage;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}