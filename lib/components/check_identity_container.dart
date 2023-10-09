import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/check_identity_cubit.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class CheckIdentityContainer extends StatelessWidget {
  const CheckIdentityContainer({super.key, required this.identityController,
  required this.onCheck });

  final TextEditingController identityController;
  final Function onCheck;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      surfaceTintColor: Colors.white,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            RegularTextFieldComponent(
              label: "Check ID Pelanggan", 
              controller: identityController, 
              validationMessage: "ID Pelanggan harus diisi.", 
              prefixIcon: LineIcons.identificationCardAlt, 
              isObsecure: false
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
                      width: size.width, 
                      height: 50, 
                      isLoading: state.isLoading
                    ),
                    const SizedBox(height: 8,),
                    state.result.msg != null ? Container(
                      width: size.width,
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
                                fontSize: 14,
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
