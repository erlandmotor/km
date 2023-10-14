import "package:adamulti_mobile_clone_new/components/ribbon_clipper.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ProductItemComponent extends StatelessWidget {

  const ProductItemComponent({ super.key, required this.operatorName, required this.operatorColor,
  required this.imageUrl, required this.title, required this.productName,
  required this.productCode, required this.description, required this.price, required this.onTap });

  final String operatorName;
  final Color operatorColor;
  final String imageUrl;
  final String title;
  final String productName;
  final String productCode;
  final String description;
  final String price;
  final Function onTap;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: ArcClipper(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: operatorColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 10),
                        child: AutoSizeText(
                          operatorName,
                          maxFontSize: 14,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        color: operatorColor.withAlpha(700),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: kLightBackgroundColor
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 18,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 44.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productName, style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                              ),),
                              const SizedBox(height: 8,),
                              Text("$productCode - $description", style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        if(int.parse(price) > 0) AutoSizeText(FormatCurrency.convertToIdr(int.parse(price), 0), 
                        maxFontSize: 16,
                        maxLines: 2,
                        style: GoogleFonts.inter(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w700
                        ),)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}