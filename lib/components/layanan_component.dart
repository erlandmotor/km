import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class LayananComponent extends StatelessWidget {

  const LayananComponent({ super.key, required this.imageUrl, required this.label, 
  required this.onTapAction, required this.menuColor });

  final String imageUrl;
  final String label;
  final Function onTapAction;
  final Color menuColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.2,
      padding: const EdgeInsets.all(6),
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
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: menuColor,
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8,),
            AutoSizeText(label,
              maxFontSize: 10,
              minFontSize: 8,
              maxLines: 2,
              textAlign: TextAlign.center, 
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600
              ),
            )
          ],
        ),
      ),
    );
  }
}
