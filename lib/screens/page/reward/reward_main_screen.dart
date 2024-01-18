import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/getme_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/page/reward/reward_exchange_list_tab.dart";
import "package:adamulti_mobile_clone_new/screens/page/reward/reward_list_tab.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:responsive_sizer/responsive_sizer.dart";

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomContainerAppBar(title: "Poin", height: 80,),
                  Expanded(
                    child: DefaultTabController(
                      length: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          children: [
                            ButtonsTabBar(
                              onTap: (index) {},
                              radius: 18,
                              contentPadding: const EdgeInsets.all(12),
                              buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 46,
                              labelSpacing: 4,
                              backgroundColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                              unselectedBackgroundColor: const Color(0xffdfe4ea),
                              borderColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                              borderWidth: 0,
                              unselectedBorderColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!),
                              labelStyle: GoogleFonts.openSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                              unselectedLabelStyle: GoogleFonts.openSans(
                                fontSize: 12,
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
                                  RewardExchangeListTab()
                                ]
                              )
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  width: 100.w,
                  height: 50,
                  color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Poin", style: GoogleFonts.openSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),),
                      Text(locator.get<GetmeCubit>().state.data.data!.poin.toString(), style: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),)
                    ],
                  ),
                )
              )
            ],
          )
        )
      ),
    );
  }
}