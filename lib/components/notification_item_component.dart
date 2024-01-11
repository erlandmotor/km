import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class NotificationItemComponent extends StatelessWidget {

  const NotificationItemComponent({ super.key,
  required this.title, required this.surfaceColor,
  required this.onTapAction, required this.notificationDate, required this.iconColor });

  final String title;
  final Color surfaceColor;
  final Function onTapAction;
  final String notificationDate;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapAction();
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: surfaceColor,
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
                    Icon(Iconsax.sms_notification5, color: iconColor, size: 48,),
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