import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class MetodePembayaranItemComponent extends StatelessWidget {

  const MetodePembayaranItemComponent({ super.key, required this.title, required this.description, 
  required this.icon, required this.iconColor, required this.containerIconColor, required this.surfaceColor, required this.onTapAction,
  required this.isImage, required this.imageUrl });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color containerIconColor;
  final Color surfaceColor;
  final Function onTapAction;
  final bool isImage;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: surfaceColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          padding: const EdgeInsets.all(8),
          width: 100.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: containerIconColor
                ),
                child: isImage ? CachedNetworkImage(
                  imageUrl: imageUrl
                ) : Icon(
                  icon,
                  color: iconColor,
                  size: 32,
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
                          Text(title, style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                          ),),
                          const SizedBox(height: 2,),
                          Text(description, 
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8,),
                    const Icon(Iconsax.arrow_right_3, color: Colors.black,)
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