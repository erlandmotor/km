import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/topup_reply_response.dart";
import "package:clipboard/clipboard.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TopupBankScreen extends StatelessWidget {

  const TopupBankScreen({ super.key, required this.data });

  final TopupReplyResponse data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Tiket Deposit Bank", height: 80,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              color: Colors.white,
                              surfaceTintColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.surfaceColor!),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      width: 100.w,
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
                                        borderRadius: BorderRadius.circular(18)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Jumlah Transfer", style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white
                                              ),),
                                              const SizedBox(height: 12,),
                                              Text(FormatCurrency.convertToIdr(data.jumlah!, 0), style: GoogleFonts.openSans(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                              ),)
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              FlutterClipboard.copy(data.jumlah!.toString()).then((_) {
                                                showDynamicSnackBar(
                                                  context, 
                                                  Icons.check, 
                                                  "Transfer Bank", 
                                                  "Jumlah Transfer Bank Berhasil Disalin", 
                                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.successColor!)
                                                );
                                              });
                                            }, 
                                            icon: const Icon(Iconsax.copy5, color: Colors.white, size: 32,)
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18,),
                                    Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                      ),
                                      padding: const EdgeInsets.all(18),
                                      child: Text(data.msg!,
                                        style: GoogleFonts.robotoMono(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                      ),),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}