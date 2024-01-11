import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
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
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      body: SafeArea(
        child: Stack(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: CachedNetworkImage(
                      imageUrl: "$baseUrlFile/setting-applikasi/image/${locator.get<SettingApplikasiCubit>().state.settingData.logoLight!}",
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 256,
                    height: 256,
                    child: CachedNetworkImage(
                      imageUrl: "$baseUrlFile/setting-applikasi/image/${locator.get<SettingApplikasiCubit>().state.settingData.loginImage!}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text("Selamat Datang di Applikasi", 
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                  ),),
                  const SizedBox(height: 4,),
                  Text("Mitra Pulsa Nusantara", 
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
                  ),),
                  SizedBox(height: 5.h,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        locator.get<AuthService>().signInWithGoogle().then((value) {
                          locator.get<AuthService>().checkFirebaseEmail(value!.email).then((value2) {
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: value2.email!, password: kDummyPasswordUser).then((userCredential) {
                              locator.get<AuthService>().getMe(userCredential.user!.uid).then((me) {
                                if(me.success! == false) {
                                  context.pushNamed("input-phone-number");
                                } else {
                                  locator.get<AuthService>().sendOtpBackoffice(me.data!.idreseller!).then((otpRes) {
                                    context.pushNamed("otp-already-registered", extra: {
                                      "idreseller": me.data!.idreseller!,
                                      "phoneNumber": otpRes.hp!
                                    });
                                  }).catchError((e) {
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      e.toString(), 
                                      Colors.red
                                    );
                                  });
                                }
                              }).catchError((e) {
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  e.toString(), 
                                  Colors.red
                                );
                              }).catchError((e) {
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  e.toString(), 
                                  Colors.red
                                );
                              });
                            }).catchError((e) {
                              showDynamicSnackBar(
                                context, 
                                Iconsax.warning_2, 
                                "ERROR", 
                                e.toString(), 
                                Colors.red
                              );
                            });
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
                        surfaceTintColor: Colors.white,
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
                              Text("Sign In with Google", style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.textColor!)
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