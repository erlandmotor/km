import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/markup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/transaction_detail_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PrintMarkupContainerComponent extends StatefulWidget {

  const PrintMarkupContainerComponent({ super.key,
  required this.onSubmitAction, required this.total, required this.buttonLabel });

  final Function onSubmitAction;
  final int total;
  final String buttonLabel;

  @override
  State<PrintMarkupContainerComponent> createState() => _PrintMarkupContainerComponentState();
}

class _PrintMarkupContainerComponentState extends State<PrintMarkupContainerComponent> {

  final sellingPriceController = TextEditingController(text: "Rp. 0");
  
  @override
  void initState() {
    final transactionDetailCubit = context.read<TransactionDetailCubit>();
    final sellingPrice = int.parse(sellingPriceController.text.replaceAll(RegExp(r"\D"), ""));              

    transactionDetailCubit.updateState(transactionDetailCubit.state.isPrinting, FormatCurrency.convertToIdr(sellingPrice, 0));
    super.initState();
  }

  @override
  void dispose() {
    sellingPriceController.dispose();
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
                MarkupTextFieldComponent(
                  label: "Atur Harga Jual", 
                  hint: "Harga jual harus lebih besar dari harga beli.", 
                  controller: sellingPriceController,
                  prefixIcon: Iconsax.money_tick,
                  onChangedAction: (String value) {
                    final transactionDetailCubit = context.read<TransactionDetailCubit>();
                    final sellingPrice = int.parse(value.replaceAll(RegExp(r"\D"), ""));              
    
                    transactionDetailCubit.updateState(transactionDetailCubit.state.isPrinting, FormatCurrency.convertToIdr(sellingPrice, 0));
                  },
                ),
                const SizedBox(height: 18,),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Harga Beli : ", style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),),
                      const SizedBox(height: 4,),
                      Text(FormatCurrency.convertToIdr(widget.total, 0), style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 18,),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Harga Jual : ", style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),),
                      const SizedBox(height: 4,),
                      BlocBuilder<TransactionDetailCubit, TransactionDetailState>(
                        bloc: context.read<TransactionDetailCubit>(),
                        builder: (_, state) {
                          return Text(state.totalReceipt, style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white
                          ),);
                        }
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18,),
                DynamicSizeButtonComponent(
                  label: widget.buttonLabel, 
                  buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                  onPressed: () {
                    final sellingPrice = int.parse(sellingPriceController.text.replaceAll(RegExp(r"\D"), ""));

                    if(widget.total > sellingPrice) {
                      showDynamicSnackBar(
                        context, 
                        Iconsax.warning_2, 
                        "ERROR", 
                        "Harga Jual harus lebih besar dari Harga Beli.", 
                        HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                      );
                    } else {
                      final transactionDetailCubit = context.read<TransactionDetailCubit>();
    
                      widget.onSubmitAction(transactionDetailCubit.state.totalReceipt, sellingPriceController.text);
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