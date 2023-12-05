import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
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
          "OTP Whatsapp",
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
                  Text("Masukkan kode OTP yang didapatkan dari Applikasi Whatsapp dengan nomor : ${widget.phoneNumber}****", 
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
                      final now = DateTime.now();
                      locator.get<AuthService>().findLastOtp(widget.idReseller, verificationCode).then((value) {
                        final expiredDate = DateTime.parse(value.expiredDate!);
                        final difference = expiredDate.difference(now).inMinutes;

                        if(difference <= 0) {
                          showDynamicSnackBar(
                            context, 
                            LineIcons.exclamationTriangle, 
                            "ERROR", 
                            "Kode OTP Sudah Expired", 
                            Colors.red
                          );
                        } else {
                          context.pushNamed("input-pin-already-registered", extra: {
                            "idreseller": widget.idReseller
                          });
                        }
                      }).catchError((e) {
                        showDynamicSnackBar(
                          context, 
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          "Kode OTP Salah", 
                          Colors.red
                        );
                      });
                    }, // end onSubmit
                  ),
                  // SizedBox(height: 6.h,),
                  // DynamicSizeButtonComponent(
                  //   label: "Kirim Ulang Otp", 
                  //   buttonColor: kMainLightThemeColor, 
                  //   onPressed: () {                      
                  //     locator.get<AuthService>().sendOtpBackoffice(widget.idReseller).then((value) {
                  //       showDynamicSnackBar(
                  //         context, 
                  //         suffixIcon, 
                  //         title, 
                  //         "Kode OTP Berhasil Dikirim", 
                  //         Colors.green
                  //       );
                  //     }).catchError((e) {
                  //       showDynamicSnackBar(
                  //         context, 
                  //         LineIcons.exclamationTriangle, 
                  //         "ERROR", 
                  //         e.toString(), 
                  //         Colors.red
                  //       );
                  //     });
                  //   }, 
                  //   width: 100.w, 
                  //   height: 50
                  // )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}