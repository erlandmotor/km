import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class SelectGoogleAccountScreen extends StatefulWidget {

  const SelectGoogleAccountScreen({ super.key });

  @override
  State<SelectGoogleAccountScreen> createState() => _SelectGoogleAccountScreenState();
}

class _SelectGoogleAccountScreenState extends State<SelectGoogleAccountScreen> {

  @override
  void initState() {
    super.initState();
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
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/ada-logo-blue.png", width: 128, height: 128,),
                  SizedBox(height: 5.h,),
                  Text("Selamat Datang di Applikasi ADAMULTI.", 
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kMainThemeColor
                    
                  ),),
                  SizedBox(height: 5.h,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        locator.get<AuthService>().signInWithGoogle().then((value) {
                          locator.get<AuthService>().checkFirebaseEmail(value!.email).then((value2) {
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: value2.email!, password: kDummyPasswordUser);
                            context.pushNamed("input-phone-number");
                          }).catchError((e) {
                            FirebaseAuth.instance.createUserWithEmailAndPassword(email: value.email, password: kDummyPasswordUser).then((_) {
                              context.pushNamed("input-phone-number");
                            });
                          });
                        });
                        // FirebaseAuth.instance.currentUser!.delete();
                      },
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
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
            ),
          ],
        )
      )
    );
  }
}