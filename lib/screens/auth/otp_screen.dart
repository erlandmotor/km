import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
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
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: kMainThemeColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: kMainThemeColor,
            systemNavigationBarColor: Colors.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "Register",
            style: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
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
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: const Color(0xff2bb741).withOpacity(0.1),
                    child: CircleAvatar(
                      radius: 56,
                      backgroundColor: const Color(0xff2bb741).withOpacity(0.2),
                      child: const CircleAvatar(
                        backgroundColor: Color(0xff2bb741),
                        radius: 44,
                        child: Icon(LineIcons.whatSApp, size: 64, color: Colors.white,)
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h,),
                  Text("Verifikasi Kode OTP", style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),),
                  SizedBox(height: 4.h,),
                  Text("Masukkan kode OTP yang didapatkan dari Applikasi Whatsapp dengan nomor : ${widget.phoneNumber}", 
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 4.h,),
                  OtpTextField(
                    enabledBorderColor: Colors.black.withOpacity(0.6),
                    fieldWidth: 12.w,
                    numberOfFields: 6,
                    showFieldAsBox: true, 
                    onCodeChanged: (String code) {           
                    },
                    textStyle: GoogleFonts.inter(
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
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Ups, akun anda belum terdaftar. Silahkan membuat akun dengan mengklik tombol register dibawah.",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500
                                        ),),
                                        const SizedBox(height: 18,),
                                        ElevatedButton(
                                          onPressed: () {
                                            context.pushNamed("register", extra: {
                                              "phoneNumber": widget.phoneNumber
                                            });
                                          }, 
                                          child: Text("Register", style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500
                                          ),)
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
                            LineIcons.exclamationTriangle, 
                            "ERROR", 
                            "Kode OTP Salah.", 
                            Colors.red
                          );
                        });

                      } else {
                        showDynamicSnackBar(
                          context, 
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          "Kode OTP Salah.", 
                          Colors.red
                        );
                      }
                    }, // end onSubmit
                  ),
                  SizedBox(height: 6.h,),
                  DynamicSizeButtonComponent(
                    label: "Kirim Ulang Otp", 
                    buttonColor: kMainLightThemeColor, 
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
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          e.toString(), 
                          Colors.red
                        );
                      });
                    }, 
                    width: 100.w, 
                    height: 50
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