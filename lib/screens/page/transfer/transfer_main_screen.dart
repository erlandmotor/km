import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/components/topup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:flutter/material.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransferMainScreen extends StatefulWidget {

  const TransferMainScreen({ super.key });

  @override
  State<TransferMainScreen> createState() => _TransferMainScreenState();
}

class _TransferMainScreenState extends State<TransferMainScreen> {
  
  final identityController = TextEditingController();
  final topupController = TextEditingController();

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
              Column(
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Expanded(
                    child: Container(
                      decoration: kContainerLightDecoration,
                    )
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
                                    prefixIcon: LineIcons.identificationCardAlt, 
                                    isObsecure: false
                                  ),
                                  const SizedBox(height: 8,),
                                  TopupTextFieldComponent(
                                    label: "Nominal Topup", 
                                    hint: "Minimal Rp. 50.000", 
                                    controller: topupController, 
                                    validationMessage: "Nominal harus diisi.", 
                                    prefixIcon: LineIcons.wavyMoneyBill, 
                                    isObsecure: false
                                  ),
                                  const SizedBox(height: 18,),
                                  LoadingButtonComponent(
                                    label: "Transfer Saldo", 
                                    buttonColor: kMainLightThemeColor, 
                                    onPressed: () {}, 
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