import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/metode_pembayaran_item_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/topup_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TopupMetodePembayaranScreen extends StatelessWidget {

  const TopupMetodePembayaranScreen({ super.key, required this.amount });

  final int amount;

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
                  const CustomContainerAppBar(title: "Metode Pembayaran", height: 80,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(18)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Jumlah Topup", style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                          ),),
                                          const SizedBox(height: 12,),
                                          Text(FormatCurrency.convertToIdr(amount, 0), style: GoogleFonts.openSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 18,),
                            Text("Pilih Metode Pemabayran : ", style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                            ),),
                            const SizedBox(height: 18,),
                            MetodePembayaranItemComponent(
                              title: "Tiket Deposit Bank", 
                              description: "Tersedia 24 Jam", 
                              icon: Iconsax.card_send5, 
                              iconColor: Colors.blue, 
                              containerIconColor: Colors.blue.withOpacity(0.2), 
                              surfaceColor: Colors.white,
                              isImage: false,
                              imageUrl: "", 
                              onTapAction: () {
                                showLoadingSubmit(context, "Proses Mengajukan Deposit, Silahkan Tunggu...");
                                locator.get<TopupService>().proceedDepositTiket(
                                  locator.get<UserAppidCubit>().state.userAppId.appId, 
                                  amount.toString()
                                ).then((value) {
                                  context.pop();
                                  context.pushNamed("topup-bank", extra: {
                                    "data": value
                                  });
                                }).catchError((e) {
                                  context.pop();
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    e.toString(), 
                                    HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                  );
                                });
                              }
                            ),
                            // const SizedBox(height: 8,),
                            // MetodePembayaranItemComponent(
                            //   title: "OVO", 
                            //   description: "Biaya Admin Rp. 5000", 
                            //   icon: Iconsax.card_send5, 
                            //   iconColor: Colors.purple, 
                            //   containerIconColor: Colors.purple.withOpacity(0.2), 
                            //   surfaceColor: Colors.white,
                            //   isImage: true,
                            //   imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1611653453/OVO_LOGO-min_zygtwe.png", 
                            //   onTapAction: () {
                            //     context.pushNamed("topup-ovo", extra: {
                            //       "amount": amount
                            //     });
                            //   }
                            // ),
                            // const SizedBox(height: 8,),
                            // MetodePembayaranItemComponent(
                            //   title: "Alfamart", 
                            //   description: "Biaya Admin Rp. 5000", 
                            //   icon: Iconsax.card_send5, 
                            //   iconColor: Colors.red, 
                            //   containerIconColor: Colors.red.withOpacity(0.2), 
                            //   surfaceColor: Colors.white,
                            //   isImage: true,
                            //   imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706236597/alfamart-min_fmspkk.png", 
                            //   onTapAction: () {
                            //     showLoadingSubmit(context, "Proses Mengajukan Deposit, Silahkan Tunggu...");
                            //     locator.get<TopupService>().proceedDepositTiketAlfamart(
                            //       locator.get<UserAppidCubit>().state.userAppId.appId, 
                            //       amount.toString()
                            //     ).then((value) {
                            //       context.pop();
                            //       context.pushNamed("topup-alfamart", extra: {
                            //         "response": value
                            //       });
                            //     }).catchError((e) {
                            //       context.pop();
                            //       showDynamicSnackBar(
                            //         context, 
                            //         Iconsax.warning_2, 
                            //         "ERROR", 
                            //         e.toString(), 
                            //         HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            //       );
                            //     });
                            //   }
                            // ),
                            // const SizedBox(height: 8,),
                            // MetodePembayaranItemComponent(
                            //   title: "Indomart", 
                            //   description: "Biaya Admin Rp. 5000", 
                            //   icon: Iconsax.card_send5, 
                            //   iconColor: Colors.red, 
                            //   containerIconColor: Colors.yellow.withOpacity(0.2), 
                            //   surfaceColor: Colors.white,
                            //   isImage: true,
                            //   imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706236597/indomart-min_xfx86q.png", 
                            //   onTapAction: () {}
                            // ),
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