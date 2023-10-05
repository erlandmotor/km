import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showDynamicSnackBar(BuildContext context, IconData suffixIcon,
String title, String message, Color snackbarColor) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    flushbarPosition: FlushbarPosition.TOP,
    titleText: Text(title, style: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white
    ),),
    messageText: Text(message,
    style: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white
    ),),
    duration:  const Duration(seconds: 4),
    backgroundColor: snackbarColor,
    icon: Icon(suffixIcon, color: Colors.white,),
  ).show(context);
}