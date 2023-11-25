import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/markup_textfield_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PrintMarkupContainerComponent extends StatefulWidget {

  const PrintMarkupContainerComponent({ super.key,
  required this.onSubmitAction, required this.total });

  final Function onSubmitAction;
  final int total;

  @override
  State<PrintMarkupContainerComponent> createState() => _PrintMarkupContainerComponentState();
}

class _PrintMarkupContainerComponentState extends State<PrintMarkupContainerComponent> {

  var totalBayar = "";
  final markupController = TextEditingController(text: "Rp. 1.000");
  
  @override
  void initState() {
    final markup = int.parse(markupController.text.replaceAll(RegExp(r"\D"), ""));
    
    setState(() {
      totalBayar = FormatCurrency.convertToIdr(widget.total + markup, 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    markupController.dispose();
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
                  label: "Jasa Loket / Markup", 
                  hint: "Contoh : Rp. 2.000", 
                  controller: markupController,
                  prefixIcon: LineIcons.receipt,
                  onChangedAction: (String value) {
                    final markup = int.parse(value.replaceAll(RegExp(r"\D"), ""));

                    setState(() {
                      totalBayar = FormatCurrency.convertToIdr(widget.total + markup, 0);
                    });
                  },
                ),
                const SizedBox(height: 18,),
                                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: kMainThemeColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Bayar : ", style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),),
                      const SizedBox(height: 4,),
                      Text(totalBayar, style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),)
                    ],
                  ),
                ),
                const SizedBox(height: 18,),
                DynamicSizeButtonComponent(
                  label: "Print", 
                  buttonColor: kMainLightThemeColor, 
                  onPressed: () {
                    widget.onSubmitAction(totalBayar, markupController.text);
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