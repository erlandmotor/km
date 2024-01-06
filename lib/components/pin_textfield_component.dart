import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PinTextFieldComponent extends StatefulWidget {

  const PinTextFieldComponent({ Key? key, required this.label, required this.hint, required this.controller}) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  State<PinTextFieldComponent> createState() => _PinTextFieldComponentState();
}

class _PinTextFieldComponentState extends State<PinTextFieldComponent> {
  var isShowing = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
        const SizedBox(height: 6,),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          obscureText: isShowing,
          style: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            focusColor: Colors.red,
            contentPadding: const EdgeInsets.all(8),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!))
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                width: 0.5
              )
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isShowing = !isShowing;
                });
              }, 
              icon: Icon(
                isShowing ? LineIcons.eyeSlash : LineIcons.eye,
              ),
            ),
            hintText: widget.hint,
            hintStyle: GoogleFonts.openSans(
              fontSize: 12,
              fontWeight: FontWeight.w400
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }
}