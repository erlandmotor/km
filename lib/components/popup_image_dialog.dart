import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:line_icons/line_icons.dart";

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
          borderRadius: BorderRadius.circular(8),
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
            offset: const Offset(20, -25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xff353b48).withOpacity(0.8),
                  child: const Icon(LineIcons.times, color: Colors.white, size: 18,),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}