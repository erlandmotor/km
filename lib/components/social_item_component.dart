import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class SocialItemComponent extends StatelessWidget {

  const SocialItemComponent({ super.key, required this.imageUrl, required this.label, 
  required this.onTapAction, required this.menuColor, required this.mainContainerWidth, required this.containerWidth, required this.containerHeight,
  required this.imageHeight, required this.imageWidth, required this.containerBorderRadius });

  final String imageUrl;
  final String label;
  final Function onTapAction;
  final Color menuColor;
  final double mainContainerWidth;
  final double containerWidth;
  final double containerHeight;
  final double imageWidth;
  final double imageHeight;
  final double containerBorderRadius;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: mainContainerWidth,
      child: GestureDetector(
        onTap: () {
          onTapAction();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: containerWidth,
              height: containerHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(containerBorderRadius),
                color: menuColor,
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8,),
            AutoSizeText(label,
              maxFontSize: 10,
              minFontSize: 8,
              maxLines: 2,
              textAlign: TextAlign.center, 
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}
