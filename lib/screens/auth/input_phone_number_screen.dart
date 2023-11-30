import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_validators_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:line_icons/line_icons.dart";
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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: const BoxDecoration(
                color: kLightBackgroundColor,
                image: DecorationImage(
                  image: AssetImage("assets/pattern-samping.png"),
                  fit: BoxFit.fill
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: const Color(0xff74b9ff).withOpacity(0.1),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: const Color(0xff74b9ff).withOpacity(0.2),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xff0D64EF),
                        radius: 44,
                        child: Icon(LineIcons.mobilePhone, size: 64, color: Colors.white,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  RegularTextFieldWithoutValidatorsComponent(
                    label: "Masukkan Nomor HP Anda untuk melakukan verifikasi.", 
                    hint: "Tanpa Prefix +62", 
                    controller: phoneController, 
                    prefixIcon: LineIcons.mobilePhone
                  ),
                  const SizedBox(height: 18,),
                  DynamicSizeButtonComponent(
                    label: "Selanjutnya", 
                    buttonColor: kSecondaryColor, 
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
                            LineIcons.exclamationTriangle, 
                            "ERROR", 
                            e.toString(), 
                            Colors.red
                          );
                        });
                      } else {
                        showDynamicSnackBar(
                          context, 
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          "Nomor HP harus diisi terlebih dahulu.", 
                          Colors.red
                        );
                      }
                    }, 
                    width: 100.w, 
                    height: 50, 
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}