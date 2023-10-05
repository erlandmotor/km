import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:flutter/material.dart";

class ContainerGradientBackground extends StatelessWidget {

  const ContainerGradientBackground({ super.key, required this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kMainThemeColor, kSecondaryColor],
          stops: [0, 0.2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: child,
    );
  }
}