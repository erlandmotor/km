import "package:adamulti_mobile_clone_new/components/check_text_field_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_contacts/flutter_contacts.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
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
        padding: const EdgeInsets.all(8),
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
                    validationMessage: "ID Pelanggan harus diisi.", 
                  ),
                ),
                const SizedBox(width: 6,),
                IconButton.filled(
                  iconSize: 24,
                  padding: const EdgeInsets.all(8),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green
                  ),
                  onPressed: () {
                    FlutterContacts.requestPermission().then((value) async {
                      if(value) {
                        final contacts = await FlutterContacts.openExternalPick();
                        if(contacts != null) {
                          identityController.text = contacts.phones[0].normalizedNumber;
                        }
                      } else {
                        showDynamicSnackBar(
                          context, 
                          LineIcons.exclamationTriangle, 
                          "ERROR", 
                          "Anda harus mengizinkan applikasi untuk mengakses kontak anda.", 
                          Colors.red
                        );
                      }
                    });
                  }, 
                  icon: const Icon(Icons.contact_phone_outlined)
                )
              ],
            ),
            const SizedBox(height: 8,),
            BlocBuilder<CheckIdentityCubit, CheckIdentityState>(
              builder: (context, state) {
                return Column(
                  children: [
                    LoadingButtonComponent(
                      label: "Check ID Pelanggan", 
                      buttonColor: kMainLightThemeColor, 
                      onPressed: () {
                        if(identityController.text.isEmpty) {
                          showDynamicSnackBar(
                            context, 
                            LineIcons.exclamationTriangle, 
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
                        color: state.result.success! == true ? Colors.green : Colors.red,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(state.result.success! ? LineIcons.checkCircle : LineIcons.exclamationTriangle, color: Colors.white,
                          size: 32,),
                          const SizedBox(width: 8,),
                          Flexible(
                            child: Text(
                              state.result.msg!, style: GoogleFonts.inter(
                                fontSize: state.result.success! == true ? 12 : 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ],
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
