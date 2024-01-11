import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/page/reward/reward_list_tab.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";

class RewardMainScreen extends StatelessWidget {
  const RewardMainScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              const Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: LightDecorationContainerComponent()
                  )
                ],
              ),
              Column(
                children: [
                  const CustomContainerAppBar(title: "Reward", height: 80,),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            ButtonsTabBar(
                              onTap: (index) {},
                              radius: 8,
                              contentPadding: const EdgeInsets.all(12),
                              buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 46,
                              labelSpacing: 4,
                              backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                              unselectedBackgroundColor: const Color(0xffdfe4ea),
                              borderColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                              borderWidth: 0,
                              unselectedBorderColor: const Color(0xff6a89cc),
                              labelStyle: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                              unselectedLabelStyle: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                              tabs: const [
                                Tab(
                                  icon: Icon(Iconsax.gift),
                                  text: 'Reward',
                                ),
                                Tab(
                                  icon: Icon(Icons.redeem_outlined),
                                  text: 'Penukaran',
                                ),
                              ]
                            ),
                            const SizedBox(height: 30,),
                            const Expanded(
                              child: TabBarView(
                                children: [
                                  RewardListTab(),
                                  Text("Hello World")
                                ]
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  )
                ],
              )
            ],
          )
        )
      ),
    );
  }
}