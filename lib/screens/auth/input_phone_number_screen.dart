import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_validators_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InputPhoneNumberScreen extends StatefulWidget {

  const InputPhoneNumberScreen({ super.key });

  @override
  State<InputPhoneNumberScreen> createState() => _InputPhoneNumberScreenState();
}

class _InputPhoneNumberScreenState extends State<InputPhoneNumberScreen> {
  final phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            context.goNamed("select-google-account");
          },
        ),
        backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
          systemNavigationBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarDividerColor: Colors.white
        ),
        title: Text(
          "Verifikasi Nomor HP",
            style: GoogleFonts.openSans(
            fontSize: 16, 
            fontWeight: FontWeight.w600, 
            color: Colors.white
          ),
        ),
      ),
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
                        child: const Icon(Iconsax.mobile5, color: Colors.white, size: 64,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RegularTextFieldWithoutValidatorsComponent(
                      label: "Masukkan Nomor HP Anda", 
                      hint: "Tanpa Prefix +62", 
                      controller: phoneController, 
                      prefixIcon: Iconsax.mobile
                    ),
                    const SizedBox(height: 18,),
                    DynamicSizeButtonComponent(
                      label: "Selanjutnya", 
                      buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                      onPressed: () {
                        if(phoneController.text.length >= 10) {
                          final randomOtpCode = generateRandomString(6);
                          locator.get<AuthService>().sendOtp(
                            FirebaseAuth.instance.currentUser!.uid, 
                            phoneController.text, 
                            "SERVER [ ADAMULTI ] Kode OTP : $randomOtpCode kode ini bersifat RAHASIA, jangan berikan kepada siapapun"
                          ).then((value) {
                            context.pushNamed("otp", extra: {
                              "phoneNumber": phoneController.text,
                              "otpCode": randomOtpCode
                            });
                          }).catchError((e) {
                            showDynamicSnackBar(
                              context, 
                              Iconsax.warning_2, 
                              "ERROR", 
                              e.toString(), 
                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            );
                          });
                        } else {
                          showDynamicSnackBar(
                            context, 
                            Iconsax.warning_2, 
                            "ERROR", 
                            "Nomor HP harus diisi terlebih dahulu.", 
                            HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                          );
                        }
                      }, 
                      width: 100.w, 
                      height: 50, 
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