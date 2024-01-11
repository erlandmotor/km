import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_nav.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/readonly_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/auth_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class MarkupScreen extends StatefulWidget {

  const MarkupScreen({ super.key, required this.idReseller, required this.namaReseller,
  required this.markup });

  final String idReseller;
  final String namaReseller;
  final String markup;

  @override
  State<MarkupScreen> createState() => _MarkupScreenState();
}

class _MarkupScreenState extends State<MarkupScreen> {
  final identityController = TextEditingController();
  final nameController = TextEditingController();
  final markupController = TextEditingController();

  @override
  void initState() {
    identityController.text = widget.idReseller;
    nameController.text = widget.namaReseller;
    markupController.text = widget.markup;
    super.initState();
  }

  @override
  void dispose() {
    identityController.dispose();
    nameController.dispose();
    markupController.dispose();
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
                  CustomContainerAppBarWithNav(
                    title: "Ubah Markup", 
                    height: 80, 
                    onTapNav: () {
                      context.goNamed("daftar-agen");
                    }
                  ),
                  Card(
                    surfaceTintColor: Colors.blue,
                    child: Container(
                      width: 96.w,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          ReadonlyTextFieldComponent(
                            label: "ID Agen", 
                            hint: "", 
                            controller: identityController, 
                            prefixIcon: Iconsax.personalcard, 
                            onTapTextField: () {}
                          ),
                          const SizedBox(height: 8,),
                          ReadonlyTextFieldComponent(
                            label: "Nama Reseller", 
                            hint: "", 
                            controller: nameController, 
                            prefixIcon: Iconsax.user_octagon, 
                            onTapTextField: () {

                            }
                          ),
                          const SizedBox(height: 8,),
                          TopupTextFieldComponent(
                            label: "Harga Markup", 
                            hint: "Contoh: Rp. 100", 
                            controller: markupController,
                            prefixIcon: Iconsax.money_tick,
                          ),
                          const SizedBox(height: 18,),
                          DynamicSizeButtonComponent(
                            label: "Ubah Markup", 
                            buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                            onPressed: () {
                              final amount = markupController.text.replaceAll(RegExp(r"\D"), "");
                              if(markupController.text.isEmpty) {
                                showDynamicSnackBar(
                                  context, 
                                  Iconsax.warning_2, 
                                  "ERROR", 
                                  "Harga Markup Harus diisi.", 
                                  Colors.red
                                );
                              } else {
                                showLoadingSubmit(context, "Proses Merubah Harga Markup Downline...");

                                locator.get<AuthService>().markupDownline(
                                  locator.get<UserAppidCubit>().state.userAppId.appId, 
                                  int.parse(amount), 
                                  identityController.text,
                                ).then((value) {
                                  if(value.success! == false) {
                                    context.pop();
                                    showDynamicSnackBar(
                                      context, 
                                      Iconsax.warning_2, 
                                      "ERROR", 
                                      value.msg!, 
                                      Colors.red
                                    );
                                  } else {
                                    context.pop();

                                    locator.get<LocalNotificationService>().showLocalNotification(
                                      title: "Markup Harga", 
                                      body: "Markup Harga ke Downline ${widget.namaReseller} dengan ID Reseller ${identityController.text} berhasil dilakukan."
                                    );
                                  }
                                }).catchError((e) {
                                  context.pop();
                                  showDynamicSnackBar(
                                    context, 
                                    Iconsax.warning_2, 
                                    "ERROR", 
                                    e.toString(), 
                                    Colors.red
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