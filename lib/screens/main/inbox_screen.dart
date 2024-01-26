import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/notifications_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/inbox_tab/inbox_activity_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/inbox_tab/inbox_notifikasi_tab.dart";
import "package:adamulti_mobile_clone_new/services/notification_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class InboxScreen extends StatefulWidget {

  const InboxScreen({ super.key });

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final scrollController = ScrollController();
  var currentPage = 1;

  final dateFormat = DateFormat("yyyy-MM-dd hh:mm");

  @override
  void initState() {
    final notificationsCubit = context.read<NotificationsCubit>();

    locator.get<NotificationService>().paginate(currentPage).then((value) {
      notificationsCubit.updateState(false, value.data!);
    });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        currentPage += 1;
        locator.get<NotificationService>().paginate(currentPage
        ).then((value) {
          notificationsCubit.updateState(
            false,
            [...notificationsCubit.state.notificationList, ...value.data!], 
          );
        });
      }  
    });
    
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LightDecorationContainerComponent(),
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.mainColor1!),
                width: 100.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 18,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Inbox", style: GoogleFonts.openSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                        ),)
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TabBar(
                      labelStyle: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 14
                      ),
                      unselectedLabelStyle: GoogleFonts.openSans(
                        fontWeight: FontWeight.w400,
                        color: Colors.white60,
                        fontSize: 14
                      ),
                      tabs: const [
                        Tab(
                          text: "Inbox Aktifitas",
                        ),
                        Tab(
                          text: "Notifikasi",
                        )
                      ]
                    )
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    InboxActivityTab(),
                    InboxNotifikasiTab()
                  ],
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}