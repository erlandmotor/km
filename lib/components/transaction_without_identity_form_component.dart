import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/transaction_pin_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class TransactionWithoutIdentityFormComponent extends StatefulWidget {

  const TransactionWithoutIdentityFormComponent({ super.key, required this.identityNumber,
  required this.operatorName, required this.productName, required this.productPrice,
  required this.onSubmit });

  final String identityNumber;
  final String operatorName;
  final String productName;
  final int productPrice;
  final Function onSubmit;

  @override
  State<TransactionWithoutIdentityFormComponent> createState() => _TransactionPlnTokenFormComponentState();
}

class _TransactionPlnTokenFormComponentState extends State<TransactionWithoutIdentityFormComponent> {

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
                const SizedBox(height: 18,),
                TransactionPinTextFieldComponent(
                  label: "PIN", 
                  hint: "Masukkan PIN Anda", 
                  controller: pinController, 
                  validationMessage: "PIN Anda harus diisi sebelum melakukan transaksi."
                ),
                const SizedBox(height: 18,),
                const DashedSeparator(),
                const SizedBox(height: 18,),
                Text("Detail Transaksi", style: GoogleFonts.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
                ),),
                const SizedBox(height: 8,),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FixedColumnWidth(80),
                    1: FixedColumnWidth(15),
                    2: FlexColumnWidth()
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: AutoSizeText(
                            "Operator", 
                            maxFontSize: 14,
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff7f8fa6)
                          ),),
                        ),
                        TableCell(
                          child: Text(":", style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),)
                        ),
                        TableCell(
                          child: AutoSizeText(
                            widget.operatorName,
                            maxLines: 1,
                            maxFontSize: 14,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        )
                      ]
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: AutoSizeText(
                            "Produk", 
                            maxFontSize: 14,
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff7f8fa6)
                          ),),
                        ),
                        TableCell(
                          child: Text(":", style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),)
                        ),
                        TableCell(
                          child: AutoSizeText(
                            widget.productName,
                            maxLines: 1,
                            maxFontSize: 14,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ),
                      ]
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: AutoSizeText(
                            "No. Tujuan", 
                            maxFontSize: 14,
                            maxLines: 1,
                            style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff7f8fa6)
                          ),),
                        ),
                        TableCell(
                          child: Text(":", style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),)
                        ),
                        TableCell(
                          child: AutoSizeText(
                            widget.identityNumber,
                            maxLines: 1,
                            maxFontSize: 14,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ),
                      ]
                    ),
                    const TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                        TableCell(
                          child: SizedBox(height: 8,)
                        ),
                      ]
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: AutoSizeText("Harga", 
                          maxFontSize: 14,
                          maxLines: 1,
                          style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff7f8fa6)
                          ),),
                        ),
                        TableCell(
                          child: Text(":", style: GoogleFonts.openSans(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                          ),)
                        ),
                        TableCell(
                          child: AutoSizeText(
                            FormatCurrency.convertToIdr(widget.productPrice, 0),
                            maxLines: 1,
                            maxFontSize: 14,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          )
                        ),
                      ]
                    ),
                  ],
                ),
                const SizedBox(height: 18,),
                const DashedSeparator(),
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
                        "PIN harus diisi terlebih dahulu sebelum melakukan pembayaran.", 
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