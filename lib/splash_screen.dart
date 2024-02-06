import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

class SplashScreen extends StatelessWidget {

  const SplashScreen({ super.key, required this.token });

  final String? token;

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      useImmersiveMode: false,
      backgroundColor: Colors.white,
      childWidget: SizedBox(
        width: 200,
        height: 200,
        child: Image.asset("assets/ada-logo.png"),
      ),
      asyncNavigationCallback: () async {
        await Future.delayed(const Duration(seconds: 2));

        if(context.mounted) {
          if(token != null) {
            context.goNamed("main");
          } else {
            context.goNamed("select-google-account");
          }
        }
      },
    );
  }
}