import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SaldoActionComponent extends StatelessWidget {

  const SaldoActionComponent({ super.key, required this.icon, required this.label,
  required this.onTapAction });

  final IconData icon;
  final String label;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: kMainLightThemeColor,
          ),
          const SizedBox(height: 4,),
          Text(label, style: GoogleFonts.openSans(
            fontSize: 12,
            fontWeight: FontWeight.w600
          ),)
        ],
      ),
    );
  }
}