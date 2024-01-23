import "package:adamulti_mobile_clone_new/components/check_text_field_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/scan_barcode_component.dart";
import "package:adamulti_mobile_clone_new/components/select_contact_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class CheckIdentityContainer extends StatelessWidget {
  const CheckIdentityContainer({super.key, required this.identityController,
  required this.onCheck });

  final TextEditingController identityController;
  final Function onCheck;

  @override
  Widget build(BuildContext context) {

    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CheckTextFieldComponent(
                    label: "Masukkan ID Pelanggan", 
                    hint: "Conth: 123456",
                    controller: identityController,
                  ),
                ),
                const SizedBox(width: 6,),
                ScanBarcodeComponent(
                  onScanResult: (String scanResult) {
                    final parsedPhoneNumber = scanResult.replaceAll("tel:", "").replaceAll("+62", "0");
                    identityController.text = parsedPhoneNumber;
                  },
                ),
                const SizedBox(width: 6,),
                SelectContactComponent(
                  onTapAction: (String contact) {
                    final parsedPhoneNumber = contact.replaceAll("+62", "0");
                    identityController.text = parsedPhoneNumber;
                  }
                ),
              ],
            ),
            const SizedBox(height: 8,),
            BlocBuilder<CheckIdentityCubit, CheckIdentityState>(
              builder: (context, state) {
                return Column(
                  children: [
                    LoadingButtonComponent(
                      label: "Check ID Pelanggan", 
                      buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                      onPressed: () {
                        if(identityController.text.isEmpty) {
                          showDynamicSnackBar(
                            context, 
                            Iconsax.warning_2, 
                            "ERROR", 
                            "ID Pelanggan harus diisi telebih dahulu.", 
                            Colors.red
                          );
                        } else {
                          onCheck();
                        }
                      }, 
                      width: 100.w, 
                      height: 50, 
                      isLoading: state.isLoading
                    ),
                    const SizedBox(height: 8,),
                    state.result.msg != null ? Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: state.result.success! == true ? kKeteranganContainerColor : Colors.red,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        state.result.msg!, style: GoogleFonts.robotoMono(
                          fontSize: state.result.success! == true ? 12 : 14,
                          fontWeight: FontWeight.w600,
                          color: state.result.success! ? Colors.black : Colors.white
                        ),
                      ),
                    ) : const SizedBox()
                  ],
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
