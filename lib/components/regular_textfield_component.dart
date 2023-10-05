import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegularTextFieldComponent extends StatelessWidget {

  const RegularTextFieldComponent({ Key? key, required this.label, required this.controller,
  required this.validationMessage, required this.prefixIcon, required this.isObsecure }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String validationMessage;
  final IconData prefixIcon;
  final bool isObsecure;

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
        Container(
          padding: const EdgeInsets.fromLTRB(10,2,10,2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
              color: Colors.white
          ),
          child: TextFormField(
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
            obscureText: isObsecure,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon),
              border: InputBorder.none,
              hintText: label,
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
        ),
      ],
    );
  }
}