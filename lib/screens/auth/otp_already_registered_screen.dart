import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpAlreadyRegisteredScreen extends StatefulWidget {

  const OtpAlreadyRegisteredScreen({ super.key, required this.idReseller, required this.phoneNumber });

  final String idReseller;
  final String phoneNumber;

  @override
  State<OtpAlreadyRegisteredScreen> createState() => _OtpAlreadyRegisteredScreenState();
}

class _OtpAlreadyRegisteredScreenState extends State<OtpAlreadyRegisteredScreen> {

  @override
  void initState() {
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
            Iconsax.arrow_circle_left,
            color: Colors.white,
            size: 36,
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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: 100.w,
                height: 200,
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
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.white.withOpacity(0.4),
                    child: CircleAvatar(
                      radius: 58,
                      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!).withOpacity(0.6),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),                                
                        child: const Icon(Iconsax.message_notif5, color: Colors.white, size: 64,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Verifikasi Kode OTP Whatsapp untuk \n Nomor : ${widget.phoneNumber}****", 
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
                        color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!),
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode){
                        final now = DateTime.now();
                        locator.get<AuthService>().findLastOtp(widget.idReseller, verificationCode).then((value) {
                          final expiredDate = DateTime.parse(value.expiredDate!);
                          final difference = expiredDate.difference(now).inMinutes;
              
                          if(difference <= 0) {
                            showDynamicSnackBar(
                              context, 
                              Iconsax.warning_2, 
                              "ERROR", 
                              "Kode OTP Sudah Expired", 
                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            );
                          } else {
                            context.pushNamed("input-pin-already-registered", extra: {
                              "idreseller": widget.idReseller
                            });
                          }
                        }).catchError((e) {
                          showDynamicSnackBar(
                            context, 
                            Iconsax.warning_2, 
                            "ERROR", 
                            "Kode OTP Salah", 
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                          );
                        });
                      }, // end onSubmit
                    ),
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