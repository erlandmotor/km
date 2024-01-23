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
      spacing: 1.w,
      runSpacing: 12,
      children: [
        for(var i = 0; i < dataLength; i++) Shimmer.fromColors(
          baseColor: Colors.grey[400]!, 
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 16.w,
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.grey
                  ),
                ),
                const SizedBox(height: 8,),
              ],
            ),
          )
        )
      ]
    );
  }
}