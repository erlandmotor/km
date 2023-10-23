import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/model/reward_response.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:adamulti_mobile_clone_new/services/reward_service.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RewardListTab extends StatelessWidget {

  const RewardListTab({ super.key });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RewardResponse>(
      future: locator.get<RewardService>().getHadiahList(
        locator.get<UserAppidCubit>().state.userAppId.appId
      ), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return Card(
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
                              color: const Color(0xff5f27cd)
                            ),
                            child: const Icon(LineIcons.gift, color: Colors.white, size: 32,)
                          ),
                          const SizedBox(width: 18,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.data![index].hadiah!, style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                              ),),
                              const SizedBox(height: 2,),
                              Text("${snapshot.data!.data![index].jumlahpoin!.toString()} Poin", style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context, 
                            builder: (context) => const Center(
                              child: SpinKitFadingCircle(
                                color: Colors.white,
                                size: 128,
                              ),
                            )
                          );

                          locator.get<RewardService>().redeem(
                            locator.get<UserAppidCubit>().state.userAppId.appId, 
                            snapshot.data!.data![index].idreward.toString()
                          ).then((value) {
                            if(value.success!) {
                              context.pop();
                              context.pop();

                              locator.get<LocalNotificationService>().showLocalNotification(
                                title: "Penukaran Reward", 
                                body: value.msg!
                              );
                            } else {
                              locator.get<LocalNotificationService>().showLocalNotification(
                                title: "Penukaran Reward", 
                                body: value.msg!
                              );
                              context.pop();
                              showDynamicSnackBar(
                                context, 
                                LineIcons.exclamationTriangle, 
                                "ERROR", 
                                value.msg!, 
                                Colors.red
                              );
                            }
                          }).catchError((e) {
                            showDynamicSnackBar(
                              context, 
                              LineIcons.exclamationTriangle, 
                              "ERROR", 
                              e.toString(), 
                              Colors.red
                            );
                          });
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          surfaceTintColor: Colors.white
                        ),
                        child: Text("Tukar", style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),),
                      )
                    ],
                  ),
                ),
              );
            }, 
            separatorBuilder: (context, index) => const SizedBox(height: 6,), 
            itemCount: snapshot.data!.data!.length
          );
        } else {
          return const ShimmerListComponent(isScrollable: false);
        }
      }
    );
  }
}