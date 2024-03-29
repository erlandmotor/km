import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class ContainerGradientBackground extends StatelessWidget {

  const ContainerGradientBackground({ super.key, required this.child });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
      bloc: locator.get<SettingApplikasiCubit>(),
      builder: (_, stateSetting) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor.fromHex(stateSetting.settingData.mainColor1!),
                HexColor.fromHex(stateSetting.settingData.mainColor2!),
                HexColor.fromHex(stateSetting.settingData.mainColor3!),
              ],
              stops: const [0, 0.4, 0.8],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          ),
          child: child,
        );
      }
    );
  }
}