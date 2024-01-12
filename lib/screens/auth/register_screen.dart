import "package:adamulti_mobile_clone_new/components/dynamic_checkbox_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/region_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_and_validators_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_component.dart";
import 'package:adamulti_mobile_clone_new/components/pin_textfield_component.dart';
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/authenticated_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/select_region_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ super.key, required this.phoneNumber });

  final String phoneNumber;

  static final registerFormKey = GlobalKey<FormState>();

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final namaUsahaController = TextEditingController();
  final alamatController = TextEditingController();
  final kodeReferralController = TextEditingController();
  final pinController = TextEditingController();

  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  var isCheckedTerm = false;
  
  @override
  void dispose() {
    namaUsahaController.dispose();
    alamatController.dispose();
    kodeReferralController.dispose();
    provinceController.dispose();
    cityController.dispose();
    districtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectRegionCubit = context.read<SelectRegionCubit>();

    return Scaffold(
      backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.replaceNamed("input-phone-number");
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
          "Register",
          style: GoogleFonts.openSans(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightColor!),
                image: const DecorationImage(
                  image: AssetImage("assets/pattern-samping.png"),
                  fit: BoxFit.fill
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: SingleChildScrollView(
                child: Form(
                  key: RegisterScreen.registerFormKey,
                  child: Column(
                    children: [
                      RegularTextFieldWithoutIconComponent(
                        label: "Nama Usaha", 
                        hint: "Contoh : Gurita Cell", 
                        controller: namaUsahaController, 
                        validationMessage: "*Nama usaha harus diisi.", 
                        isObsecure: false
                      ),
                      const SizedBox(height: 18,),
                      RegularTextFieldWithoutIconComponent(
                        label: "Alamat Usaha", 
                        hint: "Contoh : Jln. Industri Gg. Gurita no. 5", 
                        controller: alamatController, 
                        validationMessage: "*Alamat usaha harus diisi.", 
                        isObsecure: false
                      ),
                      const SizedBox(height: 18,),
                      RegionTextFieldComponent(
                        label: "Pilih Provinsi", 
                        hint: "Tekan ini untuk memilih provinsi.", 
                        controller: provinceController, 
                        onTapAction: () {
                          context.pushNamed("select-province", extra: {
                            "selectRegionCubit": selectRegionCubit,
                            "provinceController": provinceController,
                            "cityController": cityController,
                            "districtController": districtController
                          });
                        }
                      ),
                      const SizedBox(height: 18,),
                      RegionTextFieldComponent(
                        label: "Pilih Kabupaten / Kota", 
                        hint: "Tekan ini untuk memilih kabupaten / kota.", 
                        controller: cityController, 
                        onTapAction: () {
                          if(selectRegionCubit.provinceId == 0) {
                            showDynamicSnackBar(
                              context, 
                              Iconsax.warning_2, 
                              "ERROR", 
                              "Data Provinsi harus dipilih terlebih dahulu.", 
                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            );
                          } else {
                            context.pushNamed("select-city", extra: {
                              "selectRegionCubit": selectRegionCubit,
                              "cityController": cityController,
                              "districtController": districtController
                            });
                          }
                        }
                      ),
                      const SizedBox(height: 18,),
                      RegionTextFieldComponent(
                        label: "Pilih Kecamatan", 
                        hint: "Tekan ini untuk memilih kecamatan.", 
                        controller: districtController, 
                        onTapAction: () {
                          if(selectRegionCubit.cityId == 0) {
                            showDynamicSnackBar(
                              context, 
                              Iconsax.warning_2, 
                              "ERROR", 
                              "Data Kabupaten / Kota harus dipilih terlebih dahulu.", 
                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                            );
                          } else {
                            context.pushNamed("select-district", extra: {
                              "selectRegionCubit": selectRegionCubit,
                              "districtController": districtController
                            });
                          }
                        }
                      ),
                      const SizedBox(height: 18,),
                      RegularTextFieldWithoutIconAndValidatorsComponent(
                        label: "Kode Referral", 
                        hint: "Contoh : AD0001, Boleh tidak diisi.", 
                        controller: kodeReferralController,
                        isObsecure: false
                      ),
                      const SizedBox(height: 18,),
                      PinTextFieldComponent(
                        label: "PIN", 
                        hint: "Minimal 4 Digit", 
                        controller: pinController
                      ),
                      const SizedBox(height: 18,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DynamicCheckboxComponent(
                            onChangedAction: (value) {
                              isCheckedTerm = value;
                            }
                          ),
                          const SizedBox(width: 18,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  "Terima Syarat dan Ketentuan Layanan",
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Text("Privacy and Policy", style: GoogleFonts.openSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),)
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 18,),
                      DynamicSizeButtonComponent(
                        label: "Selanjutnya", 
                        buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                        onPressed: () {
                          if(namaUsahaController.text.isEmpty || alamatController.text.isEmpty || selectRegionCubit.provinceId == 0 ||
                          selectRegionCubit.cityId == 0 || selectRegionCubit.districtsId == 0 || pinController.text.isEmpty || isCheckedTerm == false) {
                            if(isCheckedTerm == false) {
                              showDynamicSnackBar(
                                context, 
                                Iconsax.warning_2, 
                                "ERROR", 
                                "Term Harus Disetujui Terlebih Dahulu Sebelum Melakukan Registrasi.", 
                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                              );
                            } else {
                              showDynamicSnackBar(
                                context, 
                                Iconsax.warning_2, 
                                "ERROR", 
                                "Formulir Pendaftaran Harus Dilengkapi Terlebih Dahulu.", 
                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                              );
                            }
                          } else {
                            if(pinController.text.length < 4) {
                              showDynamicSnackBar(
                                context, 
                                Iconsax.warning_2, 
                                "ERROR", 
                                "PIN Minimal Harus 4 Digit.", 
                                HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                              );
                            } else {
                              showLoadingSubmit(context, "Proses Registrasi...");
                
                              final userEmail = locator.get<AuthService>().getCurrentSigningAccount()!.email;
                              final userName = locator.get<AuthService>().getCurrentSigningAccount()!.displayName!;
                
                              locator.get<AuthService>().registerAccount(
                                FirebaseAuth.instance.currentUser!.uid, 
                                pinController.text, 
                                namaUsahaController.text,
                                userName, 
                                alamatController.text, 
                                widget.phoneNumber, 
                                userEmail, 
                                selectRegionCubit.provinceId, 
                                selectRegionCubit.cityId, 
                                selectRegionCubit.districtsId,
                                kodeReferralController.text
                              ).then((registerResponse) {
                                if(registerResponse.success! == true) {
                                  locator.get<AuthService>().login(registerResponse.datareg!.idreseller!).then((loginResponse) {
                                    locator.get<SecureStorageService>().writeSecureData("jwt", loginResponse.token!);
                                    locator.get<AuthenticatedCubit>().updateUserState(loginResponse.user!);
                                    locator.get<AuthService>().decryptToken(loginResponse.user!.idreseller!, loginResponse.token!).then((decrypt) {
                                      context.pop();
                                      locator.get<UserAppidCubit>().updateState(decrypt);
                                      context.goNamed("main");
                                    });
                                  });
                                } else {
                                  context.pop();
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    registerResponse.msg!, 
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
                            }
                          }
                        }, 
                        width: 100.w, 
                        height: 50
                      ),
                      const SizedBox(height: 28,)
                    ],
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}