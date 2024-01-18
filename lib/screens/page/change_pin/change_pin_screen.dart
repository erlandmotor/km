import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/pin_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class ChangePinScreen extends StatefulWidget {

  const ChangePinScreen({ super.key });

  static final changePinFormKey = GlobalKey<FormState>();

  @override
  State<ChangePinScreen> createState() => _ChangePinScreenState();
}

class _ChangePinScreenState extends State<ChangePinScreen> {
  final currentPinController = TextEditingController();
  final newPinController = TextEditingController();

  @override
  void dispose() {
    currentPinController.dispose();
    newPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  const CustomContainerAppBar(title: "Ganti Pin", height: 80,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      surfaceTintColor: Colors.blue,
                      child: Container(
                        width: 96.w,
                        padding: const EdgeInsets.all(18),
                        child: Form(
                          key: ChangePinScreen.changePinFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 48,
                                backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!).withOpacity(0.2),
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!).withOpacity(0.6),
                                  child: CircleAvatar(
                                    radius: 36,
                                    backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),                                
                                    child: const Icon(Iconsax.lock5, color: Colors.white, size: 40,),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              PinTextFieldComponent(
                                label: "PIN Lama", 
                                hint: "Masukkan PIN yang sekarang", 
                                controller: currentPinController
                              ),
                              const SizedBox(height: 8,),
                              PinTextFieldComponent(
                                label: "PIN Baru", 
                                hint: "Masukkan PIN yang baru", 
                                controller: newPinController
                              ),
                              const SizedBox(height: 18,),
                              DynamicSizeButtonComponent(
                                label: "Ganti Pin", 
                                buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                onPressed: () {
                                  if(ChangePinScreen.changePinFormKey.currentState!.validate()) {
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      "PIN Lama atau PIN Baru harus diisi terlebih dahulu.", 
                                      HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                    );
                                  } else {
                                    showLoadingSubmit(context, "Proses Mengganti PIN");
                        
                                    locator.get<AuthService>().changePin(
                                      locator.get<UserAppidCubit>().state.userAppId.appId, 
                                      currentPinController.text, 
                                      newPinController.text, 
                                      newPinController.text
                                    ).then((value) {
                                      currentPinController.clear();
                                      newPinController.clear();
                                      
                                      context.pop();
                                      
                                      if(value.success! == true) {
                                        showDynamicSnackBar(
                                          context, 
                                          Iconsax.warning_2, 
                                          "SUKSES", 
                                          value.msg!, 
                                          Colors.blue
                                        );
                                      } else {
                                        showDynamicSnackBar(
                                          context, 
                                          Iconsax.warning_2, 
                                          "ERROR", 
                                          value.msg!, 
                                          HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                        );
                                      }
                                    }).catchError((e) {
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