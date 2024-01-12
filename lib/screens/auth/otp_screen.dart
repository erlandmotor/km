import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {

  const OtpScreen({ super.key, required this.phoneNumber, required this.otpCode });

  final String phoneNumber;
  final String otpCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpCode = "";

  @override
  void initState() {
    otpCode = widget.otpCode;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "OTP Whatsapp",
            style: GoogleFonts.openSans(
            fontSize: 16, 
            fontWeight: FontWeight.w600, 
            color: Colors.white
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              width: 100.w,
              height: 40.h,
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
                )
              ),
              child: Center(
                child: SizedBox(
                  width: 256,
                  height: 256,
                  child: CachedNetworkImage(
                    imageUrl: "$baseUrlFile/setting-applikasi/image/${locator.get<SettingApplikasiCubit>().state.settingData.otpImage!}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Verifikasi Kode OTP Whatsapp untuk \n Nomor : ${widget.phoneNumber}", 
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 2.h,),
                  OtpTextField(
                    enabledBorderColor: Colors.black.withOpacity(0.6),
                    fieldWidth: 12.w,
                    numberOfFields: 6,
                    showFieldAsBox: true, 
                    onCodeChanged: (String code) {           
                    },
                    textStyle: GoogleFonts.openSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      if(verificationCode == otpCode) {
                        locator.get<AuthService>().cekExisting(
                          FirebaseAuth.instance.currentUser!.uid, 
                          widget.phoneNumber
                        ).then((value) {
                          if(value.success == false) {
                            showModalBottomSheet(
                              backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18)
                                )
                              ),  
                              builder: (context) {
                                return SizedBox(
                                  width: 100.w,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 48,
                                          backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!).withOpacity(0.2),
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!).withOpacity(0.6),
                                            child: CircleAvatar(
                                              radius: 36,
                                              backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),                                
                                              child: const Icon(Iconsax.info_circle, color: Colors.white, size: 40,),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8,),
                                        Text("Ups, Anda Belum Terdaftar",
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                        const SizedBox(height: 8,),
                                        Text("Silahkan Klik Tombol Register Dibawah untuk Membuat Akun Baru",
                                        style: GoogleFonts.openSans(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                                        ),),
                                        const SizedBox(height: 18,),
                                        DynamicSizeButtonComponent(
                                          label: "Register", 
                                          buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                          onPressed: () {
                                            context.pushNamed("register", extra: {
                                              "phoneNumber": widget.phoneNumber
                                            });
                                          }, 
                                          width: 100.w, 
                                          height: 50
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                          } else {
                            context.pushNamed("input-pin", extra: {
                              "phoneNumber": widget.phoneNumber
                            });
                          }
                        }).catchError((e) {
                          showDynamicSnackBar(
                            context, 
                            Iconsax.warning_2, 
                            "ERROR", 
                            "Kode OTP Salah.", 
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                          );
                        });
            
                      } else {
                        showDynamicSnackBar(
                          context, 
                          Iconsax.warning_2, 
                          "ERROR", 
                          "Kode OTP Salah.", 
                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                        );
                      }
                    }, // end onSubmit
                  ),
                  SizedBox(height: 6.h,),
                  DynamicSizeButtonComponent(
                    label: "Kirim Ulang Otp", 
                    buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                    onPressed: () {
                      final randomOtpCode = generateRandomString(6);
                      locator.get<AuthService>().sendOtp(
                        FirebaseAuth.instance.currentUser!.uid, 
                        widget.phoneNumber, 
                        "SERVER [ ADAMULTI ] Kode OTP : $randomOtpCode kode ini bersifat RAHASIA, jangan berikan kepada siapapun"
                      ).then((value) {
                        otpCode = randomOtpCode;
                      }).catchError((e) {
                        showDynamicSnackBar(
                          context, 
                          Iconsax.warning_2, 
                          "ERROR", 
                          e.toString(), 
                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                        );
                      });
                    }, 
                    width: 100.w, 
                    height: 50
                  )
                ],
              ),
            ),
          )
          ],
        )
      ),
    );
  }
}