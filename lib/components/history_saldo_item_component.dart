import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HistorySaldoItemComponent extends StatelessWidget {

  const  HistorySaldoItemComponent({ super.key,
  required this.keterangan, required this.sisaSaldo, required this.jumlah,
  required this.waktu });

  final String keterangan;
  final int sisaSaldo;
  final int jumlah;
  final String waktu;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: jumlah < 0 ? 
      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) : 
      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18)
        ),
        padding: const EdgeInsets.all(6),
        width: 100.w,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: jumlah < 0 ?
                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!).withOpacity(0.2) :
                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!).withOpacity(0.2)
              ),
              child: Icon(
                jumlah < 0 ? 
                Iconsax.empty_wallet_remove5 :
                Iconsax.empty_wallet_add5,
                color: jumlah < 0 ?
                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) :
                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
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
                        Text(keterangan, style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                        ),),
                        const SizedBox(height: 2,),
                        Text(waktu, style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AutoSizeText(FormatCurrency.convertToIdr(sisaSaldo, 0), 
                        maxFontSize: 16,
                        maxLines: 1,
                        style: GoogleFonts.openSans(
                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                          fontWeight: FontWeight.w700
                        ),
                      ), const SizedBox(height: 2,),
                      AutoSizeText(FormatCurrency.convertToIdr(jumlah, 0), 
                        maxFontSize: 12,
                        maxLines: 1,
                        style: GoogleFonts.openSans(
                          color: jumlah < 0 ? 
                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) : 
                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!),
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
      ),
    );
  }
}