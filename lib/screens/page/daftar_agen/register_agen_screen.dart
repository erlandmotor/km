import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_nav.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/phone_textfield_without_icon_component.dart";
import "package:adamulti_mobile_clone_new/components/region_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_icon_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/select_region_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RegisterAgenScreen extends StatefulWidget {

  const RegisterAgenScreen({ super.key });

  @override
  State<RegisterAgenScreen> createState() => _RegisterAgenScreenState();
}

class _RegisterAgenScreenState extends State<RegisterAgenScreen> {

  final namaUsahaController = TextEditingController();
  final alamatController = TextEditingController();
  final handphoneController = TextEditingController();

  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();

  @override
  void dispose() {
    namaUsahaController.dispose();
    alamatController.dispose();
    handphoneController.dispose();
    provinceController.dispose();
    cityController.dispose();
    districtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectRegionCubit = context.read<SelectRegionCubit>();
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
              Column(
                children: [
                  CustomContainerAppBarWithNav(
                    title: "Register Agen", 
                    height: 80, 
                    onTapNav: () {
                      context.goNamed("daftar-agen");
                    }
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Card(
                        surfaceTintColor: Colors.blue,
                        child: Container(
                          width: 96.w,
                          padding: const EdgeInsets.all(12),
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
                              PhoneTextFieldWithoutIconComponent(
                                label: "Nomor Handphone", 
                                hint: "Contoh : 082236", 
                                controller: handphoneController, 
                                validationMessage: "*Nomor HP harus diisi.", 
                                isObsecure: false
                              ),
                              const SizedBox(height: 18,),
                              DynamicSizeButtonComponent(
                                label: "Daftarkan", 
                                buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                onPressed: () {
                                  if(namaUsahaController.text.isEmpty ||
                                  alamatController.text.isEmpty || handphoneController.text.isEmpty
                                  || provinceController.text.isEmpty
                                  || cityController.text.isEmpty || districtController.text.isEmpty) {
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "Formulir Pendaftaran Agen Harus Dilengkapi Terlebih Dahulu.", 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  } else {
                                    locator.get<AuthService>().registerDownline(
                                      locator.get<UserAppidCubit>().state.userAppId.appId, 
                                      namaUsahaController.text, 
                                      alamatController.text, 
                                      handphoneController.text, 
                                      selectRegionCubit.provinceId, 
                                      selectRegionCubit.cityId, 
                                      selectRegionCubit.districtsId,
                                    ).then((value) {
                                      if(value.success! == false) {
                                        showDynamicSnackBar(
                                          context, 
                                          Iconsax.warning_2, 
                                          "ERROR", 
                                          value.msg!, 
                                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                        );
                                      } else {
                                        locator.get<LocalNotificationService>().showLocalNotification(
                                          title: "Register Downline", 
                                          body: "Register Akun Downline ${namaUsahaController.text} berhasil dilakukan."
                                        );

                                        context.goNamed("daftar-agen");
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
                                }, 
                                width: 100.w, 
                                height: 50
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}