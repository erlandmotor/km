import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicSizeButtonComponent extends StatelessWidget {

  const DynamicSizeButtonComponent({ Key? key, required this.label,
  required this.buttonColor, required this.onPressed, required this.width,
  required this.height }) : super(key: key);

  final String label;
  final double width;
  final double height;
  final Color buttonColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18)
          ),
          backgroundColor: buttonColor,
        ),
        child: Text(label, style: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),),
      ),
    );
  }
}