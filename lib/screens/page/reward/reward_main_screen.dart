import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/screens/page/reward/reward_list_tab.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";

class RewardMainScreen extends StatelessWidget {
  const RewardMainScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ContainerGradientBackground(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Expanded(
                    child: Container(
                      decoration: kContainerLightDecoration,
                    )
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
                              backgroundColor: kMainLightThemeColor,
                              unselectedBackgroundColor: const Color(0xffdfe4ea),
                              borderColor: kMainLightThemeColor,
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
                                  icon: Icon(LineIcons.gift),
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