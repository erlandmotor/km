import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/no_notification_component.dart";
import "package:adamulti_mobile_clone_new/components/notification_item_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/notifications_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/notification_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

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
    return ContainerGradientBackground(
      child: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
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
              const SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Inbox", style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),)
                ],
              ),
              const SizedBox(height: 24,),
              Expanded(
                child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (_, state) {
                    if(state.isLoading) {
                      return const ShimmerListComponent(isScrollable: true);
                    } else {
                      if(state.notificationList.isEmpty) {
                        return const NoNotificationComponent(label: "Tidak Ada Inbox");
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.all(8),
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            if(index < state.notificationList.length) {
                              return NotificationItemComponent(
                                title: state.notificationList[index].title!, 
                                containerColor: index % 2 == 0 ? Colors.white : Colors.blue, 
                                onTapAction: () {
                                  context.pushNamed("inbox-detail", extra: {
                                    "notificationId": state.notificationList[index].id!
                                  });
                                },
                                notificationDate: dateFormat.format(DateTime.parse(state.notificationList[index].createdAt!)),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          }, 
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 6,);
                          }, 
                          itemCount: state.notificationList.length
                        );
                      }
                    }
                  },
                )
              )
            ],
          ),
        ],
      )
    );
  }
}