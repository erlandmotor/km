import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ProductItemComponent extends StatelessWidget {

  const ProductItemComponent({ super.key, required this.operatorName,
  required this.imageUrl, required this.title, required this.productName,
  required this.productCode, required this.description, required this.price, required this.onTap, required this.surfaceColor });

  final String operatorName;
  final String imageUrl;
  final String title;
  final String productName;
  final String productCode;
  final String description;
  final String price;
  final Function onTap;
  final Color surfaceColor;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18)
        ),
        child: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                width: 50.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor2!),
                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor3!),
                    ],
                    stops: const [0, 0.4, 0.8],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), bottomRight: Radius.circular(18))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: AutoSizeText(
                    operatorName,
                    maxFontSize: 10,
                    minFontSize: 2,
                    maxLines: 1,
                    style: GoogleFonts.openSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),
                  ),
                ),
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
                        color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 42,
                          height: 42,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(productName, 
                                maxLines: 2,
                                maxFontSize: 16,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                                ),),
                                const SizedBox(height: 8,),
                                AutoSizeText("$productCode - $description",
                                maxLines: 3,
                                maxFontSize: 12, 
                                style: GoogleFonts.openSans(
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
                          maxLines: 1,
                          style: GoogleFonts.openSans(
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                            fontWeight: FontWeight.w700
                          ),)
                        ],
                      ),
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