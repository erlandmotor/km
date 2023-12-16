import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class PopupImageDialog extends StatelessWidget {

  const PopupImageDialog({ super.key, required this.imageUrl });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 256,
        height: 256,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: CachedNetworkImageProvider(
              imageUrl,
            )
          )
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Transform.translate(
            offset: const Offset(10, -10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(LineIcons.timesCircle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}