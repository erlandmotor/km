import "package:adamulti_mobile_clone_new/components/dynamic_checkbox_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/region_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_and_validators_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_component.dart";
import 'package:adamulti_mobile_clone_new/components/pin_textfield_component.dart';
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ super.key });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final namaUsahaController = TextEditingController();
  final alamatController = TextEditingController();
  final provinsiController = TextEditingController();
  final kabupatenController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kodeReferralController = TextEditingController();
  final pinController = TextEditingController();

  var isCheckedTerm = false;

  @override
  void dispose() {
    namaUsahaController.dispose();
    alamatController.dispose();
    provinsiController.dispose();
    kabupatenController.dispose();
    kecamatanController.dispose();
    kodeReferralController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            context.replaceNamed("input-phone-number");
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
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
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
              child: SingleChildScrollView(
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
                      hint: "Tekan field ini untuk memilih provinsi.", 
                      controller: provinsiController, 
                      onTapAction: () {}
                    ),
                    const SizedBox(height: 18,),
                    RegionTextFieldComponent(
                      label: "Pilih Kabupaten / Kota", 
                      hint: "Tekan field ini untuk memilih kabupaten / kota.", 
                      controller: provinsiController, 
                      onTapAction: () {}
                    ),
                    const SizedBox(height: 18,),
                    RegionTextFieldComponent(
                      label: "Pilih Kecamatan", 
                      hint: "Tekan field ini untuk memilih kecamatan.", 
                      controller: provinsiController, 
                      onTapAction: () {}
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
                      hint: "Minimal 6 Digit", 
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
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Text("Privacy and Policy", style: GoogleFonts.inter(
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
                      buttonColor: kMainLightThemeColor, 
                      onPressed: () {
                        namaUsahaController.text = "HELLO WORLD";
                      }, 
                      width: 100.w, 
                      height: 50
                    ),
                    const SizedBox(height: 28,)
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