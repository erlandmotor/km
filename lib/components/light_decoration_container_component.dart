import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class LightDecorationContainerComponent extends StatelessWidget {

  const LightDecorationContainerComponent({ super.key });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
      bloc: locator.get<SettingApplikasiCubit>(),
      builder: (_, stateSetting) {
        return Container(
          decoration: BoxDecoration(
            color: HexColor.fromHex(stateSetting.settingData.lightColor!),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18)
            )
          ),
        );
      }
    );
  }
}