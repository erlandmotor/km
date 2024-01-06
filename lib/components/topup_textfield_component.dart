import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TopupTextFieldComponent extends StatelessWidget {

  const TopupTextFieldComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.prefixIcon }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
        const SizedBox(height: 6,),
        TextFormField(
          keyboardType: TextInputType.number,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9Rp.-]'))
          ],
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!))
            ),
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            prefixIcon: Icon(prefixIcon),
            hintText: hint,
            hintStyle: GoogleFonts.openSans(
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          onChanged: (value) {
            if(value.isNotEmpty) {
              if(value.length < 4) {
                controller.text = "Rp. 0";
              } else {
                controller.text = FormatCurrency.convertToIdr(int.parse(value.replaceAll(RegExp(r"\D"), "")), 0);
              }
            }
          },
        ),
      ],
    );
  }
}