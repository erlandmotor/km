import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TopupHistoryItemComponent extends StatelessWidget {

  const TopupHistoryItemComponent({ super.key, required this.status, required this.nominal, required this.waktu });

  final String status;
  final int nominal;
  final String waktu;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18)
        ),
        width: 100.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: (status == "0") ? Colors.lightBlue : (status == "1") ? Colors.green : Colors.red
                  ),
                  child: Icon(
                    (status == "0") ? Iconsax.refresh : (status == "1") ? Iconsax.tick_circle : Iconsax.close_circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(FormatCurrency.convertToIdr(nominal, 0), style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 6,),
                    Text(waktu, style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                    ),)
                  ],
                )
              ],
            ),
            Text((status == "0") ? "PROSES" : (status == "1") ? "SUKSES" : "GAGAL", style: GoogleFonts.openSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: (status == "0") ? Colors.lightBlue : (status == "1") ? Colors.green : Colors.red
            ),)
          ],
        ),
      ),
    );
  }
}