import "package:adamulti_mobile_clone_new/components/layanan_component.dart";
import "package:flutter/material.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:shimmer/shimmer.dart";

class MainMenuShimmer extends StatelessWidget {

  const MainMenuShimmer({ super.key, required this.dataLength });

  final int dataLength;

  @override
  Widget build(BuildContext context) {
    
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 4.w,
      runSpacing: 12,
      children: [
        for(var i = 0; i < dataLength; i++)   Shimmer.fromColors(
          baseColor: Colors.grey[500]!, 
          highlightColor: Colors.grey[100]!,
          child: LayananComponent(
            imageUrl: "https://play-lh.googleusercontent.com/bApDMIGkzahh1kQWTVGrDI_hdRjRcc4xrtBSf4SWQiaxhoj7D4U_8pD4xXfIJ8Qim-g",
            label: "Pulsa/Paket Data",
            onTapAction: () {

            },
            menuColor: const Color(0xff7fbaff).withOpacity(0.5),
          ), 
        ),
      ]
    );
  }
}