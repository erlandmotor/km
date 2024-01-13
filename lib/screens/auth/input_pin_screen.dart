import "package:adamulti_mobile_clone_new/components/curve_clipper.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/pin_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InputPinScreen extends StatefulWidget {

  const InputPinScreen({ super.key, required this.phoneNumber });

  final String phoneNumber;

  @override
  State<InputPinScreen> createState() => _InputPinScreenState();
}

class _InputPinScreenState extends State<InputPinScreen> {
  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            systemNavigationBarDividerColor: Colors.white),
        title: Text(
          "PIN Authentikasi",
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
                        child: const Icon(Iconsax.lock5, color: Colors.white, size: 64,),
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
                    Text("Masukkan PIN Anda.", style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),),
                    const SizedBox(height: 20,),
                    PinTextFieldComponent(
                      label: "PIN", 
                      hint: "PIN Akun Anda", 
                      controller: pinController
                    ),
                    const SizedBox(height: 30,),
                    DynamicSizeButtonComponent(
                      label: "Masuk", 
                      buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                      onPressed: () {
                        showLoadingSubmit(context, "Proses Login ke Applikasi...");
              
                        final uuid = FirebaseAuth.instance.currentUser!.uid;
              
                        locator.get<AuthService>().accountKit(uuid, widget.phoneNumber, pinController.text).then((accountKitResponse) {
                          if(accountKitResponse.success! == true) {
                            locator.get<AuthService>().login(accountKitResponse.idrs!).then((loginResponse) {
                              locator.get<SecureStorageService>().writeSecureData("jwt", loginResponse.token!);
                              locator.get<AuthenticatedCubit>().updateUserState(loginResponse.user!);
                              locator.get<AuthService>().decryptToken(loginResponse.user!.idreseller!, loginResponse.token!).then((decrypt) {
                                context.pop();
                                locator.get<UserAppidCubit>().updateState(decrypt);
                                context.goNamed("main");
                              }).catchError((e) {
                                context.pop();
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  e.toString(), 
                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                );
                              });
                            }).catchError((e) {
                              context.pop();
                              showDynamicSnackBar(
                                context, 
                                Iconsax.warning_2, 
                                "ERROR", 
                                e.toString(), 
                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                              );
                            });
                          } else {
                            context.pop();
                            showDynamicSnackBar(
                              context, 
                              Iconsax.warning_2, 
                              "ERROR", 
                              accountKitResponse.msg!, 
                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            );
                          }
                        }).catchError((e) {
                            locator.get<AuthService>().accountKit(uuid, widget.phoneNumber, pinController.text).then((accountKitResponse) {
                              if(accountKitResponse.success! == true) {
                                locator.get<AuthService>().login(accountKitResponse.idrs!).then((loginResponse) {
                                  locator.get<SecureStorageService>().writeSecureData("jwt", loginResponse.token!);
                                  locator.get<AuthenticatedCubit>().updateUserState(loginResponse.user!);
                                  locator.get<AuthService>().decryptToken(loginResponse.user!.idreseller!, loginResponse.token!).then((decrypt) {
                                    context.pop();
                                    locator.get<UserAppidCubit>().updateState(decrypt);
                                    context.goNamed("main");
                                  }).catchError((e) {
                                    context.pop();
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      e.toString(), 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  });
                                }).catchError((e) {
                                  context.pop();
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    e.toString(), 
                                    HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                  );
                                });
                              } else {
                                context.pop();
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  accountKitResponse.msg!, 
                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                );
                              }
                            }).catchError((e) {
                                context.pop();
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  e.toString(), 
                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                );
                            });
                        });
                      }, 
                      width: 100.w, 
                      height: 50
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}