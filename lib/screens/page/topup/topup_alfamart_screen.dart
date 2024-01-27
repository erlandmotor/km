import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/alfamart_payment_response.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TopupAlfamartScreen extends StatelessWidget {

  const TopupAlfamartScreen({ super.key, required this.response });

  final AlfamartPaymentResponse response;

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
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xffD31027),
                                            Color(0xffEA384D),
                                            Color(0xffD31027),
                                          ],
                                          stops: [0, 0.4, 0.8],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
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
                                              Text("Kode Pembayaran", style: GoogleFonts.openSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white
                                              ),),
                                              const SizedBox(height: 4,),
                                              Text(response.data!.paymentCode!, style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                              ),),
                                              Text("Atas Nama", style: GoogleFonts.openSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white
                                              ),),
                                              const SizedBox(height: 4,),
                                              Text(response.data!.name!, style: GoogleFonts.openSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                              ),),
                                              Text("Total Pembayaran", style: GoogleFonts.openSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white
                                              ),),
                                              const SizedBox(height: 4,),
                                              Text(FormatCurrency.convertToIdr(response.data!.transferAmount!, 0), style: GoogleFonts.openSans(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white
                                              ),)
                                            ],
                                          ),
                                          const SizedBox(width: 12,),
                                          CachedNetworkImage(
                                            imageUrl: "https://res.cloudinary.com/ada-multi/image/upload/v1706236597/alfamart-min_fmspkk.png",
                                            width: 84,
                                            height: 84,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18,),
                                    Text("Detail", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                    ),),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Nominal Transfer", style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                        ),),
                                        Text(FormatCurrency.convertToIdr(response.data!.transferAmount!, 0), style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Biaya Admin", style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                        ),),
                                        Text(FormatCurrency.convertToIdr(5000, 0), style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Saldo Diterima", style: GoogleFonts.openSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                        ),),
                                        Text(FormatCurrency.convertToIdr(response.data!.transferAmount! - 5000, 0), style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 18,),
                                    Container(
                                  padding: const EdgeInsets.all(18),
                                  width: 96.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: kKeteranganContainerColor
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Iconsax.info_circle, color: Colors.black,),
                                          const SizedBox(width: 8,),
                                          Text("Informasi", style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                          ),),
                                        ],
                                      ),
                                      const SizedBox(height: 8,),
                                      Text("1. Datang ke Alfamart / Alfamidi terdekat.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                      Text("2. Informasikan kepada kasir bahwa anda ingin membayar merchant IRMA.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                      Text("3. Informasikan kepada kasir kode pembayaran anda.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                      Text("4. Kasir akan menginformasikan nama anda.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                      Text("5. Lakukan pembayaran dan selesai. Saldo anda akan masuk secara otomatis.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                      Text("6. Bila ada kendala, hubungi customer service.", style: GoogleFonts.openSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),),
                                      const SizedBox(height: 4,),
                                    ],
                                  ),
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