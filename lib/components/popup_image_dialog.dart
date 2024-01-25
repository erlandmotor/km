import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:iconsax/iconsax.dart";

class PopupImageDialog extends StatelessWidget {

  const PopupImageDialog({ super.key, required this.imageUrl });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          InteractiveViewer(
            maxScale: 2.0,
            minScale: 0.5,
            child: CachedNetworkImage(imageUrl: imageUrl)
          ),
          Positioned(
            right: 0,
            child: Transform.translate(
              offset: const Offset(10, -10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xff353b48).withOpacity(0.8),
                  child: const Icon(Iconsax.close_circle5, color: Colors.white, size: 18,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}