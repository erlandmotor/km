import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import 'package:adamulti_mobile_clone_new/model/reward_exchange_response.dart';
import "package:adamulti_mobile_clone_new/services/reward_service.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RewardExchangeListTab extends StatelessWidget {

  const RewardExchangeListTab({ super.key });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RewardExchangeResponse>(
      future: locator.get<RewardService>().getRewardList(
        locator.get<UserAppidCubit>().state.userAppId.appId
      ), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.data!.data!.histories!.isNotEmpty) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.blue,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18)
                        ),
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!).withOpacity(0.2),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(snapshot.data!.data!.histories![index].imgurl!)
                                    )
                                  ),
                                ),
                                const SizedBox(width: 18,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.data!.histories![index].hadiah!, style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600
                                    ),),
                                    const SizedBox(height: 2,),
                                    Text("${snapshot.data!.data!.histories![index].poin!.toString()} Poin", style: GoogleFonts.openSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(index == snapshot.data!.data!.histories!.length) const SizedBox(height: 48,)
                  ],
                );
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 6,);
              }, 
              itemCount: snapshot.data!.data!.histories!.length
            );
          } else {
            return const NoDataComponent(label: "Tidak Ada Data Penukaran");
          }
        } else {
          return const ShimmerListComponent(isScrollable: false);
        }
      }
    );
  }
}