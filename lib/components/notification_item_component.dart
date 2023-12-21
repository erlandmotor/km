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
                    Container(
                      alignment: Alignment.center,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xff5f27cd)
                      ),
                      child: const Icon(
                        LineIcons.bullhorn,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, 
                            style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),),
                          const SizedBox(height: 4,),
                          Text(notificationDate, style: GoogleFonts.inter(
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