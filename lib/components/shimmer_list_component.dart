import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListComponent extends StatelessWidget {

  const ShimmerListComponent({ Key? key, required this.isScrollable }) : super(key: key);

  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: isScrollable ? const ScrollPhysics() : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors( 
          baseColor: Colors.grey[500]!, 
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white
              ),
            ),
            title: Container(
              width: 50,
              height: 20,
              color: Colors.white,
            ),
            subtitle: Container(
              width: 100,
              height: 15,
              color: Colors.white,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15,),
    );
  }
}