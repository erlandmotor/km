import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RekapTransaksiItemComponent extends StatelessWidget {

  const RekapTransaksiItemComponent({ super.key, required this.imageUrl,
  required this.kodeProduk, required this.namaProduk,
  required this.jumlah, required this.total });

  final String imageUrl;
  final String kodeProduk;
  final String namaProduk;
  final int jumlah;
  final int total;

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
                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!).withOpacity(0.2)
              ),
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, _, __) => const CircularProgressIndicator(),
                imageUrl: imageUrl,
                fit: BoxFit.cover,
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
                        Text("$kodeProduk - $namaProduk", style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                        ),),
                        const SizedBox(height: 2,),
                        Text("Total Transaksi : $jumlah", style: GoogleFonts.openSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8,),
                  AutoSizeText(FormatCurrency.convertToIdr(total, 0), 
                    maxFontSize: 16,
                    maxLines: 1,
                    style: GoogleFonts.openSans(
                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}