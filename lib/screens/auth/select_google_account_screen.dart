import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class SelectGoogleAccountScreen extends StatelessWidget {

  const SelectGoogleAccountScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: kContainerMainDecoration,
            ),
            SizedBox(
              width: 100.w,
              height: 50.h,
              child: Center(
                child: Image.asset("assets/ada-logo-blue.png", width: 128, height: 128,),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                height: 50.h,
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                  color: Color(0xffEBEBEB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Selamat Datang di Applikasi ", 
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: kSecondaryColor
                          ),),
                          TextSpan(
                            text: "ADAMULTI", 
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.red
                          ),),
                        ]
                      ),
                    ),
                    const SizedBox(height: 18,),
                    Text("Silahkan register untuk menggunakan applikasi ini.", style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    ),),
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            locator.get<AuthService>().signInWithGoogle().then((value) {
                              print(value);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18)
                            ),
                            width: 100.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  child: Image.asset(
                                    "assets/logo-google.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Text("Sign In with Google", style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        )
      )
    );
  }
}