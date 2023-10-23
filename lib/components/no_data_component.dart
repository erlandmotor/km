import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class NoDataComponent extends StatelessWidget {

  const NoDataComponent({ super.key, required this.label });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/no_data.png"),
          const SizedBox(height: 10,),
          Text(label, style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,)
        ],
      )
    );
  }
}