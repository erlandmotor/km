
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class CustomContainerAppBarWithSearch extends StatelessWidget {
  const CustomContainerAppBarWithSearch({ super.key, required this.title, required this.height,
  required this.searchWidget });

  final String title;
  final double height;
  final Widget searchWidget;

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Icon(Iconsax.arrow_circle_left, size: 28, color: Colors.white,)
              ),
              Expanded(
                child: AutoSizeText(title, 
                maxFontSize: 18,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
              ),
              searchWidget
            ],
          ),
        ],
      ),
    );
  }
}