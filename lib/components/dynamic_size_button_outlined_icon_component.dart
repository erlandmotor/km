import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DynamicSizeButtonOutlinedIconComponent extends StatelessWidget {

  const DynamicSizeButtonOutlinedIconComponent({ Key? key, required this.label,
  required this.buttonColor, required this.onPressed, required this.width,
  required this.height, required this.icon }) : super(key: key);

  final String label;
  final double width;
  final double height;
  final Color buttonColor;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: buttonColor,
        ),
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          backgroundColor: Colors.white,
          side: BorderSide(
            width: 1.0,
            color: buttonColor
          )
        ),
        label: Text(label, style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: buttonColor
        ),),
      ),
    );
  }
}