import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransferMainScreen extends StatefulWidget {

  const TransferMainScreen({ super.key });

  @override
  State<TransferMainScreen> createState() => _TransferMainScreenState();
}

class _TransferMainScreenState extends State<TransferMainScreen> {
  
  final identityController = TextEditingController();
  final topupController = TextEditingController(text: "Rp. 50.000");

  @override
  void dispose() {
    identityController.dispose();
    topupController.dispose();
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
                    height: 120,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Transfer Saldo", height: 80,),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  RegularTextFieldComponent(
                                    label: "Nomor HP / ID Agen", 
                                    hint: "Contoh : ID00001", 
                                    controller: identityController, 
                                    validationMessage: "Nomor HP / ID Agen Harus Diisi.", 
                                    prefixIcon: Iconsax.personalcard, 
                                    isObsecure: false
                                  ),
                                  const SizedBox(height: 8,),
                                  TopupTextFieldComponent(
                                    label: "Nominal Transfer", 
                                    hint: "Minimal Rp. 50.000", 
                                    controller: topupController,
                                    prefixIcon: Iconsax.empty_wallet_change,
                                  ),
                                  const SizedBox(height: 18,),
                                  LoadingButtonComponent(
                                    label: "Transfer Saldo", 
                                    buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                    onPressed: () {
                                      
                                    }, 
                                    width: 100.w, 
                                    height: 50, 
                                    isLoading: false
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}