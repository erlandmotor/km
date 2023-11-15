import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PhoneTextFieldWithoutIconComponent extends StatelessWidget {

  const PhoneTextFieldWithoutIconComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.validationMessage, required this.isObsecure }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String validationMessage;
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
        TextFormField(
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
          obscureText: isObsecure,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
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
              fontSize: 12,
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