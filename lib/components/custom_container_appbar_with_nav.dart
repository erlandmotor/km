import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class CustomContainerAppBarWithNav extends StatelessWidget {
  const CustomContainerAppBarWithNav({ super.key, required this.title, required this.height,
  required this.onTapNav });

  final String title;
  final double height;
  final Function onTapNav;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 100.w,
      height: height,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onTapNav();
                },
                child: const Icon(Iconsax.arrow_circle_left, size: 36, color: Colors.white,)
              ),
              Expanded(
                child: Center(
                  child: AutoSizeText(
                    title,
                    maxFontSize: 18,
                    maxLines: 2, 
                    style: GoogleFonts.openSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                  ),),
                ),
              ),
              const SizedBox(width: 20,)
            ],
          ),
        ],
      ),
    );
  }
}