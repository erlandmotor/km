import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/otp_field_component.dart";
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

class OtpAlreadyRegisteredScreen extends StatefulWidget {

  const OtpAlreadyRegisteredScreen({ super.key, required this.idReseller, required this.phoneNumber });

  final String idReseller;
  final String phoneNumber;

  @override
  State<OtpAlreadyRegisteredScreen> createState() => _OtpAlreadyRegisteredScreenState();
}

class _OtpAlreadyRegisteredScreenState extends State<OtpAlreadyRegisteredScreen> {

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
                    const SizedBox(height: 36,),
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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
                              }
                            } else if(value.length == 1) {
                              if(otpFieldController1.text.isNotEmpty && otpFieldController2.text.isNotEmpty &&
                              otpFieldController3.text.isNotEmpty && otpFieldController4.text.isNotEmpty &&
                              otpFieldController5.text.isNotEmpty && otpFieldController6.text.isNotEmpty) {
                                final kodeOtp = "${otpFieldController1.text}${otpFieldController2.text}${otpFieldController3.text}${otpFieldController4.text}${otpFieldController5.text}${otpFieldController6.text}";
                                final now = DateTime.now();
                                locator.get<AuthService>().findLastOtp(widget.idReseller, kodeOtp).then((value) {
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