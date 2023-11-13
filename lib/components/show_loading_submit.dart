import 'package:adamulti_mobile_clone_new/constant/constant.dart';
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
              const CircleAvatar(
                radius: 48,
                backgroundColor: kMainThemeColor,
                child: SpinKitRing(
                  lineWidth: 4,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 18,),
              Material(
                child: Text(label,
                style: GoogleFonts.inter(
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