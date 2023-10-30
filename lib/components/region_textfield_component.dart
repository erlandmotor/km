import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class RegionTextFieldComponent extends StatelessWidget {

  const RegionTextFieldComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.onTapAction }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final Function onTapAction;

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
          onTap: () {
            onTapAction();
          },
          readOnly: true,
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
            suffixIcon: const Icon(LineIcons.angleDown, size: 18,),
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}