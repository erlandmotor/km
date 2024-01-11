import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";

class AccountMenuSectionComponent extends StatelessWidget {

  const AccountMenuSectionComponent({ super.key, required this.icon,
  required this.label, required this.iconColor });

  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28,),
          const SizedBox(width: 18,),
          Expanded(
            child: Text(label, style: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),)
          ),
          const SizedBox(width: 6,),
          const Icon(Iconsax.arrow_right3, color: Colors.black, size: 18,)
        ],
      ),
    );
  }
}