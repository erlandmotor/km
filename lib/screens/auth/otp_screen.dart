import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/otp_field_component.dart";
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

class OtpScreen extends StatefulWidget {

  const OtpScreen({ super.key, required this.phoneNumber, required this.otpCode });

  final String phoneNumber;
  final String otpCode;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpCode = "";

  final otpFieldController1 = TextEditingController();
  final otpFieldController2 = TextEditingController();
  final otpFieldController3 = TextEditingController();
  final otpFieldController4 = TextEditingController();
  final otpFieldController5 = TextEditingController();
  final otpFieldController6 = TextEditingController();

  final otpFocusNode1 = FocusNode();
  final otpFocusNode2 = FocusNode();
  final otpFocusNode3 = FocusNode();
  final otpFocusNode4 = FocusNode();
  final otpFocusNode5 = FocusNode();
  final otpFocusNode6 = FocusNode();

  @override
  void initState() {
    otpCode = widget.otpCode;
    super.initState();
  }

  @override
  void dispose() {
    otpFieldController1.dispose();
    otpFieldController2.dispose();
    otpFieldController3.dispose();
    otpFieldController4.dispose();
    otpFieldController5.dispose();
    otpFieldController6.dispose();
    
    otpFocusNode1.dispose();
    otpFocusNode2.dispose();
    otpFocusNode3.dispose();
    otpFocusNode4.dispose();
    otpFocusNode5.dispose();
    otpFocusNode6.dispose();
    super.dispose();
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
      resizeToAvoidBottomInset: false,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpFieldComponent(
                        controller: otpFieldController1,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode1, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController1.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            } else {
                              otpFocusNode2.requestFocus();
                            }
                          } else {}
                        },
                        onDeleteAction: (RawKeyEvent event) {
                  
                        },
                      ),
                      OtpFieldComponent(
                        controller: otpFieldController2,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode2, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController2.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            } else {
                              otpFocusNode3.requestFocus();
                            }
                          } else {
                            
                          }
                        },
                        onDeleteAction: (RawKeyEvent event) {
                          if(event is RawKeyDownEvent) {
                            if(event.logicalKey.keyLabel == "Backspace") {
                              otpFocusNode1.requestFocus(); 
                            }
                          }
                        },
                      ),
                      OtpFieldComponent(
                        controller: otpFieldController3,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode3, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController3.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            } else {
                              otpFocusNode4.requestFocus();
                            }
                          } else {
                            
                          }
                        },
                        onDeleteAction: (RawKeyEvent event) {
                          if(event is RawKeyDownEvent) {
                            if(event.logicalKey.keyLabel == "Backspace") {
                              otpFocusNode2.requestFocus(); 
                            }
                          }
                        },
                      ),
                      OtpFieldComponent(
                        controller: otpFieldController4,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode4, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController4.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            } else {
                              otpFocusNode5.requestFocus();
                            }
                          } else {
                            
                          }
                        },
                        onDeleteAction: (RawKeyEvent event) {
                          if(event is RawKeyDownEvent) {
                            if(event.logicalKey.keyLabel == "Backspace") {
                              otpFocusNode3.requestFocus(); 
                            }
                          }
                        },
                      ),
                      OtpFieldComponent(
                        controller: otpFieldController5,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode5, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController5.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            } else {
                              otpFocusNode6.requestFocus();
                            }
                          } else {
                            
                          }
                        },
                        onDeleteAction: (RawKeyEvent event) {
                          if(event is RawKeyDownEvent) {
                            if(event.logicalKey.keyLabel == "Backspace") {
                              otpFocusNode4.requestFocus(); 
                            }
                          }
                        },
                      ),
                      OtpFieldComponent(
                        controller: otpFieldController6,
                        width: 12.w, 
                        height: 12.w,
                        focusNode: otpFocusNode6, 
                        onChanged: (String value) {
                          if(value.length == 2) {
                            otpFieldController6.text = value[1];
                  
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else if(value.length == 1) {
                            if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                            otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                            otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                              final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                              if(kodeOtp == otpCode) {
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
                            }
                          } else {
                            
                          }
                        },
                        onDeleteAction: (RawKeyEvent event) {
                          if(event is RawKeyDownEvent) {
                            if(event.logicalKey.keyLabel == "Backspace") {
                              otpFocusNode5.requestFocus(); 
                            }
                          }
                        },
                      ),
                    ],
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