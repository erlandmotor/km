import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HistoryTransferItemComponent extends StatelessWidget {

  const HistoryTransferItemComponent({ super.key,
  required this.idreseller, required this.namaReseller, required this.jumlah,
  required this.waktu });

  final String idreseller;
  final String namaReseller;
  final int jumlah;
  final String waktu;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.blue,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18)
        ),
        width: 100.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                    ),
                    child: Image.asset(
                      "assets/icon-transfer.png",
                      width: 42,
                      height: 42,
                      fit: BoxFit.contain,
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
                              Text(idreseller, style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                              ),),
                              const SizedBox(height: 2,),
                              Text(namaReseller, style: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),),
                              const SizedBox(height: 2,),
                              Text(waktu, style: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(FormatCurrency.convertToIdr(jumlah, 0), 
                              maxFontSize: 16,
                              maxLines: 1,
                              style: GoogleFonts.openSans(
                                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}