import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";

class OtpFieldComponent extends StatelessWidget {

  const OtpFieldComponent({ super.key, required this.width, required this.height,
  required this.onChanged, required this.controller, required this.onDeleteAction, required this.focusNode });

  final double width;
  final double height;
  final Function onChanged;
  final TextEditingController controller;
  final Function onDeleteAction;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (RawKeyEvent key) {
          onDeleteAction(key);
        },
        child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            onChanged(value);
          },
          keyboardType: TextInputType.number,
          maxLength: 2,
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
            counterText: ""
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}