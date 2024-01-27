import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/phone_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TopupOvoScreen extends StatefulWidget {
  const TopupOvoScreen({ super.key, required this.amount });

  final int amount;

  @override
  State<TopupOvoScreen> createState() => _TopupOvoScreenState();
}

class _TopupOvoScreenState extends State<TopupOvoScreen> {
  
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

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
                  const CustomContainerAppBar(title: "Ovo Payment", height: 80,),
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
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(18),
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xffDA22FF),
                                            Color(0xff9733EE),
                                            Color(0xffDA22FF),
                                          ],
                                          stops: [0, 0.2, 0.8],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius: BorderRadius.circular(18)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Nominal Transfer", style: GoogleFonts.openSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white
                                          ),),
                                          const SizedBox(height: 12,),
                                          Text(FormatCurrency.convertToIdr(widget.amount, 0), style: GoogleFonts.openSans(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18,),
                                    PhoneTextFieldComponent(
                                      label: "Masukkan Nomor Handphone", 
                                      hint: "Contoh : 082xxx", 
                                      controller: phoneController, 
                                      validationMessage: "*Nomor HP Harus diisi.", 
                                      isObsecure: false
                                    ),
                                    const SizedBox(height: 18,),
                                    Text("Note : ", style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                    ),),
                                    const SizedBox(height: 8,),
                                    Text("Saldo akan masuk otomatis setelah kamu melakukan pembayaran.", style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                    ),),
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
                                        Text(FormatCurrency.convertToIdr(widget.amount, 0), style: GoogleFonts.openSans(
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
                                        Text(FormatCurrency.convertToIdr(widget.amount - 5000, 0), style: GoogleFonts.openSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                      ],
                                    ),
                                    const SizedBox(height: 18,),
                                    DynamicSizeButtonComponent(
                                      label: "Proses Topup OVO", 
                                      buttonColor: Colors.purple, 
                                      onPressed: () {
                                
                                      }, 
                                      width: 100.w, 
                                      height: 50
                                    )
                                  ],
                                ),
                              ),
                            ),
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