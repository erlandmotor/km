import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class DetailTransaksiItemComponent extends StatelessWidget {

  const DetailTransaksiItemComponent({ super.key, required this.title, required this.value });

  final String title;
  final String value;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 40.w,
              child: Text(title, style: GoogleFonts.inter(
                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!),
                fontSize: 12,
                fontWeight: FontWeight.w500
              ),),
            ),
            Flexible(
              child: Text(value, 
              textAlign: TextAlign.end,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 12
              ),),
            )
          ],
        ),
        const SizedBox(height: 12,)
      ],
    );
  }
}