import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransactionCheckFormComponent extends StatefulWidget {

  const TransactionCheckFormComponent({ super.key,
  required this.response, required this.productPrice,
  required this.onSubmit });

  final String response;
  final int productPrice;
  final Function onSubmit;

  @override
  State<TransactionCheckFormComponent> createState() => _TransactionCheckFormComponentState();
}

class _TransactionCheckFormComponentState extends State<TransactionCheckFormComponent> {

  final pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18)
            )
          ),
          padding: const EdgeInsets.all(18),
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Konfirmasi Transaksi", style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(Icons.close, color: Colors.black,)
                    )
                  ],
                ),
                // const SizedBox(height: 8,),
                // const DashedSeparator(),
                const SizedBox(height: 8,),
                const DashedSeparator(),
                const SizedBox(height: 8,),
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kKeteranganContainerColor,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.info_circle,
                      size: 32,),
                      const SizedBox(width: 8,),
                      Flexible(
                        child: Text(
                          "  ${convertTotalResponseWithNumberFormatted(widget.response, widget.productPrice.toString())}", style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                const DashedSeparator(),
                const SizedBox(height: 18,),
                RegularTextFieldComponent(
                  hint: "Masukkan PIN Anda.",
                  label: "PIN", 
                  controller: pinController, 
                  validationMessage: "PIN Harus Diisi.",
                  prefixIcon: Iconsax.key,
                  isObsecure: true,
                ),
                const SizedBox(height: 18,),
                DynamicSizeButtonComponent(
                  label: "Bayar Sekarang", 
                  buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if(pinController.text.isEmpty) {
                      showDynamicSnackBar(
                        context, 
                        Iconsax.warning_2, 
                        "ERROR", 
                        "ID Pelanggan atau PIN harus diisi terlebih dahulu sebelum melakukan pembayaran.", 
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                      );
                    } else {
                      widget.onSubmit(pinController.text);
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
    );
  }
}