import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class NotificationItemComponent extends StatelessWidget {

  const NotificationItemComponent({ super.key,
  required this.title, required this.containerColor,
  required this.onTapAction, required this.notificationDate });

  final String title;
  final Color containerColor;
  final Function onTapAction;
  final String notificationDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: containerColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(LineIcons.envelopeOpenText, color: kMainLightThemeColor, size: 48,),
                    const SizedBox(width: 18,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, 
                            style: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),),
                          const SizedBox(height: 4,),
                          Text(notificationDate, style: GoogleFonts.openSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                          ),)
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}