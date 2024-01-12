import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class HistoryTransaksiItemComponent extends StatelessWidget {

  const HistoryTransaksiItemComponent({ super.key,
  required this.kodeTujuan, required this.amount, required this.sn,
  required this.waktu, required this.statusText, required this.statusTransaksi,
  required this.onTapAction });

  final String kodeTujuan;
  final int amount;
  final String sn;
  final String waktu;
  final String statusTransaksi;
  final String statusText;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: statusTransaksi == "2" ? 
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) :
        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!),
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: statusTransaksi == "2" ? 
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!).withOpacity(0.2) : 
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!).withOpacity(0.2)
                      ),
                      child: Icon(
                        statusTransaksi == "2" ? Icons.close : Icons.check,
                        color: statusTransaksi == "2" ? 
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!) :
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!),
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
                                Text(kodeTujuan, style: GoogleFonts.openSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),),
                                const SizedBox(height: 2,),
                                Text("SN : $sn", 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  ),
                                ),
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
                              AutoSizeText(FormatCurrency.convertToIdr(amount, 0), 
                                maxFontSize: 16,
                                maxLines: 1,
                                style: GoogleFonts.openSans(
                                  color: statusTransaksi == "2" ? Colors.red : Colors.green,
                                  fontWeight: FontWeight.w700
                                ),
                              ), const SizedBox(height: 2,),
                              Text(statusText, style: GoogleFonts.openSans(
                                fontSize: 12,
                                color: statusTransaksi == "2" ? Colors.red : Colors.green,
                                fontWeight: FontWeight.w500
                              ),)
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
      ),
    );
  }
}