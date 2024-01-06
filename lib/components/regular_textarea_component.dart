import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegularTextareaComponent extends StatelessWidget {

  const RegularTextareaComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.validationMessage }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String validationMessage;

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
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.go,
          maxLines: 4,
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
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
            hintText: hint,
            hintStyle: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w400
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorStyle: const TextStyle(
              fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!))
            ),
          ),
          validator: (value) {
            if(value!.isEmpty) {
              return validationMessage;
            } else {
              return null;
            }
          },
        ),
      ],
    );
  }
}