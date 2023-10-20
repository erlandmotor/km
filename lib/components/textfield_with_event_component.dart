import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_debounce/easy_debounce.dart';

class TextfieldWithEventComponent extends StatelessWidget {

  const TextfieldWithEventComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.validationMessage, required this.onChanged }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String validationMessage;
  final Function onChanged;

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
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.phone,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              border: InputBorder.none,
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
            onChanged: (value) {
              EasyDebounce.debounce("search", const Duration(milliseconds: 500), () { 
                onChanged(value);
              });
            },
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