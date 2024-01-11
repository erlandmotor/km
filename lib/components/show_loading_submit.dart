import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void showLoadingSubmit(BuildContext context, String label) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (context) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white
          ),
          width: 80.w,
          height: 200,
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                child: const SpinKitRing(
                  lineWidth: 4,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18,),
              Material(
                child: Text(label,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),),
              )
            ],
          ),
        ),
      );
    }
  );
}