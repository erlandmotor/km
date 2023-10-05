import "package:adamulti_mobile_clone_new/components/dashed_separator.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class TransactionFormComponent extends StatefulWidget {

  const TransactionFormComponent({ super.key,
  required this.operatorName, required this.productName, required this.productPrice,
  required this.onSubmit });

  final String operatorName;
  final String productName;
  final int productPrice;
  final Function onSubmit;

  @override
  State<TransactionFormComponent> createState() => _TransactionFormComponentState();
}

class _TransactionFormComponentState extends State<TransactionFormComponent> {

  final identityController = TextEditingController();
  final pinController = TextEditingController();

  var identityNumber = "";

  @override
  void initState() {
    super.initState();

    identityController.addListener(() {
      setState(() {
        identityNumber = identityController.text;
      });
    });
  }

  @override
  void dispose() {
    identityController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18)
        )
      ),
      padding: const EdgeInsets.all(18),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Konfirmasi Transaksi", style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600
              ),),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: const Icon(LineIcons.times, color: Colors.black,)
              )
            ],
          ),
          // const SizedBox(height: 8,),
          // const DashedSeparator(),
          const SizedBox(height: 18,),
          RegularTextFieldComponent(
            label: "No. Tujuan / ID Pelanggan", 
            controller: identityController, 
            validationMessage: "ID Pelanggan Harus Diisi.",
            prefixIcon: LineIcons.identificationCard,
            isObsecure: false,
          ),
          const SizedBox(height: 8,),
          RegularTextFieldComponent(
            label: "PIN", 
            controller: pinController, 
            validationMessage: "PIN Harus Diisi.",
            prefixIcon: LineIcons.key,
            isObsecure: true,
          ),
          const SizedBox(height: 18,),
          const DashedSeparator(),
          const SizedBox(height: 18,),
          Text("Detail Transaksi", style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7f8fa6)
                    ),),
                  ),
                  TableCell(
                    child: Text(":", style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7f8fa6)
                    ),),
                  ),
                  TableCell(
                    child: Text(":", style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7f8fa6)
                    ),),
                  ),
                  TableCell(
                    child: Text(":", style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),)
                  ),
                  TableCell(
                    child: AutoSizeText(
                      identityNumber,
                      maxLines: 1,
                      maxFontSize: 14,
                      style: GoogleFonts.inter(
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
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff7f8fa6)
                    ),),
                  ),
                  TableCell(
                    child: Text(":", style: GoogleFonts.inter(
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
                      style: GoogleFonts.inter(
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
            buttonColor: kMainThemeColor, 
            onPressed: () {
              if(identityController.text.isEmpty || pinController.text.isEmpty) {
                showDynamicSnackBar(
                  context, 
                  LineIcons.exclamationTriangle, 
                  "ERROR", 
                  "ID Pelanggan atau PIN harus diisi terlebih dahulu sebelum melakukan pembayaran.", 
                  Colors.red
                );
              } else {
                widget.onSubmit(identityController.text, pinController.text);
              }
            }, 
            width: size.width, 
            height: 50
          )
        ],
      ),
    );
  }
}