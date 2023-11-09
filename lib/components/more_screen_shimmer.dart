import "package:adamulti_mobile_clone_new/components/main_menu_shimmer.dart";
import "package:flutter/material.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:shimmer/shimmer.dart";

class MoreScreenShimmer extends StatelessWidget {

  const MoreScreenShimmer({ super.key });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey[400]!, 
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 100.w,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(18)
                ),
              ),
            ),
            const SizedBox(height: 2,),
            const Divider(),
            const SizedBox(height: 2,),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 2.w,
              runSpacing: 12,
              children: const [
                MainMenuShimmer(dataLength: 8)
              ],
            )
          ],
        ),
      ),
    );
  }
}