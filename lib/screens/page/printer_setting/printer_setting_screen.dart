import "dart:convert";

import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/markup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textarea_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/struk_model.dart";
import "package:adamulti_mobile_clone_new/services/secure_storage.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PrinterSettingScreen extends StatefulWidget {

  const PrinterSettingScreen({ super.key });

  static final strukFormKey = GlobalKey<FormState>();

  @override
  State<PrinterSettingScreen> createState() => _PrinterSettingScreenState();
}

class _PrinterSettingScreenState extends State<PrinterSettingScreen> {
  final namaTokoController = TextEditingController();
  final alamatTokoController = TextEditingController();
  final footerStrukController = TextEditingController();
  final markupController = TextEditingController(text: "Rp. 1.000");

  @override
  void initState() {
    locator.get<SecureStorageService>().readSecureData("struk").then((value) {
      if(value != null) {
        final struk = StrukModel.fromJson(jsonDecode(value));
        
        namaTokoController.text = struk.nama!;
        alamatTokoController.text = struk.alamat!;
        footerStrukController.text = struk.footer!;
        markupController.text = struk.markup!;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    namaTokoController.dispose();
    alamatTokoController.dispose();
    footerStrukController.dispose();
    markupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomContainerAppBar(title: "Struk & Printer", height: 80),
                    Card(
                      surfaceTintColor: Colors.blue,
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        child: Form(
                          key: PrinterSettingScreen.strukFormKey,
                          child: Column(
                            children: [
                              RegularTextFieldWithoutIconComponent(
                                label: "Nama Toko", 
                                hint: "Contoh : Gurita Cell", 
                                controller: namaTokoController, 
                                validationMessage: "*Nama toko harus diisi.", 
                                isObsecure: false
                              ),
                              const SizedBox(height: 18,),
                              RegularTextareaComponent(
                                label: "Alamat Toko & Telp", 
                                hint: "Contoh : Jln. Industri, GG. Gurita no. 5 / 082236343053", 
                                controller: alamatTokoController, 
                                validationMessage: "*Alamat toko harus diisi."
                              ),
                              const SizedBox(height: 18,),
                              RegularTextareaComponent(
                                label: "Footer Struk", 
                                hint: "Contoh : Terima Kasih Telah Berbalanja di Toko Gurita Mas Cell.", 
                                controller: footerStrukController, 
                                validationMessage: "*Footer struk harus diisi."
                              ),
                              const SizedBox(height: 18,),
                              MarkupTextFieldComponent(
                                label: "Default Markup", 
                                hint: "Contoh : Rp. 2.000", 
                                controller: markupController,
                                prefixIcon: Iconsax.money_tick,
                                onChangedAction: (String value) {
                                }
                              ),
                              const SizedBox(height: 18,),
                              DynamicSizeButtonComponent(
                                label: "Simpan", 
                                buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                onPressed: () {
                                  if(PrinterSettingScreen.strukFormKey.currentState!.validate()) {
                                    locator.get<SecureStorageService>().writeSecureData("struk", 
                                      jsonEncode(StrukModel(
                                        nama: namaTokoController.text, 
                                        alamat: alamatTokoController.text, 
                                        footer: footerStrukController.text,
                                        markup: markupController.text
                                      ).toJson())
                                    );

                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.info_circle, 
                                      "STRUK", 
                                      "Data Struk Berhasil Diperbaharui.", 
                                      Colors.blue
                                    );
                                  } else {
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "Formulir harus dilengkapi terlebih dahulu.", 
                                      Colors.red
                                    );
                                  }
                                }, 
                                width: 100.w, 
                                height: 50
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        )
      ),
    );
  }
}