import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/custom_container_appbar_with_search.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_size_button_component.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/komisi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/components/show_loading_submit.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/komisi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/komisi_service.dart";
import "package:adamulti_mobile_clone_new/services/local_notification_service.dart";
import "package:calendar_date_picker2/calendar_date_picker2.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class KomisiMainScreen extends StatefulWidget {

  const KomisiMainScreen({ super.key });

  @override
  State<KomisiMainScreen> createState() => _KomisiMainScreenState();
}

class _KomisiMainScreenState extends State<KomisiMainScreen> {
  final scrollController = ScrollController();
  final popupMenuController = CustomPopupMenuController();

  var listOfCurrentDateTime = <DateTime?>[DateTime.now()];

  @override
  void initState() {
    final komisiCubit = context.read<KomisiCubit>();

    locator.get<KomisiService>().getHistoryKomisi(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      "", 
      komisiCubit.currentPage.toString(), 
      DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[0]!), 
      DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[1]!)
    ).then((value) {
      komisiCubit.updateState(false, value.data!, value.komisi!);
    });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        komisiCubit.currentPage += 1;
        locator.get<KomisiService>().getHistoryKomisi(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          "10", 
          "", 
          komisiCubit.currentPage.toString(), 
          DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[0]!), 
          DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[1]!)
        ).then((value) {
          komisiCubit.updateState(
            false,
            [...komisiCubit.state.dataList, ...value.data!], 
            value.komisi!
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    popupMenuController.dispose();
    scrollController.dispose();
    super.dispose();
  }

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
                    height: 110,
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
                  CustomContainerAppBarWithSearch(
                    title: "Komisi", 
                    height: 90,
                    searchWidget: CustomPopupMenu(
                      controller: popupMenuController,
                      position: PreferredPosition.bottom, 
                      menuBuilder: () {
                        return Container(
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text("Pilih Tanggal", style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500
                                ),),
                              ),
                              CalendarDatePicker2(
                                config: CalendarDatePicker2Config(
                                  calendarType: CalendarDatePicker2Type.range
                                ), 
                                value: listOfCurrentDateTime,
                                onValueChanged: (value) {
                                  listOfCurrentDateTime = value;

                                  final komisiCubit = context.read<KomisiCubit>();

                                  komisiCubit.listOfCurrentDateTime = value;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: BlocBuilder<KomisiCubit, KomisiState>(
                                  bloc: context.read<KomisiCubit>(),
                                  builder: (_, state) {                              
                                    return LoadingButtonComponent(
                                      label: "Cari", 
                                      buttonColor: kSecondaryColor, 
                                      onPressed: () {
                                        if(listOfCurrentDateTime.length < 2) {
                                          popupMenuController.hideMenu();
                                          showDynamicSnackBar(
                                            context,
                                            LineIcons.exclamationTriangle,
                                            "ERROR",
                                            "Tanggal Harus Dipilih Terlebih Dahulu.",
                                            Colors.red
                                          );
                                        } else {
                                          final komisiCubit = context.read<KomisiCubit>();

                                          komisiCubit.updateState(
                                            true, 
                                            komisiCubit.state.dataList, 
                                            komisiCubit.state.totalKomisi
                                          );

                                          locator.get<KomisiService>().getHistoryKomisi(
                                            locator.get<UserAppidCubit>().state.userAppId.appId, 
                                            "10", 
                                            "", 
                                            komisiCubit.currentPage.toString(), 
                                            DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[0]!), 
                                            DateFormat("y-MM-dd").format(komisiCubit.listOfCurrentDateTime[1]!)
                                          ).then((value) {
                                            listOfCurrentDateTime = <DateTime?>[DateTime.now()];       
                                            popupMenuController.hideMenu();
                                            komisiCubit.updateState(false, value.data!, value.komisi!);
                                          }).catchError((e) {
                                            listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                            popupMenuController.hideMenu();
                                            komisiCubit.updateState(false, komisiCubit.state.dataList, komisiCubit.state.totalKomisi);
                                            showDynamicSnackBar(
                                              context,
                                              LineIcons.exclamationTriangle,
                                              "ERROR",
                                              e.toString(),
                                              Colors.red
                                            );  
                                          });
                                        }
                                      }, 
                                      width: 100.w, 
                                      height: 50, 
                                      isLoading: state.isLoading
                                    );
                                  }
                                ),
                              )
                            ],
                          ),
                        );
                      }, 
                      pressType: PressType.singleClick,
                      verticalMargin: 10,
                      horizontalMargin: 10,
                      arrowColor: Colors.white,
                      barrierColor: Colors.black54,
                      showArrow: true,
                      child: const Icon(Icons.search_outlined, size: 32, color: Colors.white,)
                    ),
                  ),
                  Card(
                    surfaceTintColor: const Color(0xffc8d6e5),
                    child: Container(
                      width: 92.w,
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Komisi Saat Ini : ", style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),),
                              BlocBuilder<KomisiCubit, KomisiState>(
                                builder: (_, state) {
                                  if(state.isLoading) {
                                    return const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                      color: kSecondaryColor,
                                      strokeWidth: 4.0,
                                      )
                                    );
                                  } else {
                                    return Text(FormatCurrency.convertToIdr(state.totalKomisi, 0), style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),);
                                  }
                                }
                              )
                            ],
                          ),
                          const SizedBox(height: 18,),
                          DynamicSizeButtonComponent(
                            label: "Tukar Komisi", 
                            buttonColor: kMainLightThemeColor, 
                            onPressed: () {
                              showDialog(
                                context: context, 
                                builder: (dialogContext) {
                                  return CupertinoAlertDialog(
                                    title: Text("Konfirmasi Penukaran Komisi", style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),),
                                    content: Padding(
                                      padding: const EdgeInsets.only(top: 18, bottom: 8, left: 8, right: 8),
                                      child: Column(
                                        children: [
                                          const CircleAvatar(
                                            radius: 36,
                                            backgroundColor: Colors.blue,
                                            child: Icon(LineIcons.exclamationTriangle, size: 38, color: Colors.white,),
                                          ),
                                          const SizedBox(height: 18,),
                                          Text("Apakah anda yakin ingin menukar komisi anda menjadi saldo???", style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500
                                          ),)
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          dialogContext.pop();
                                        },
                                        child: Text("Batal", style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                        ),)
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () {
                                          dialogContext.pop();
                                          showLoadingSubmit(context, "Proses Menukar Komisi...");

                                          locator.get<KomisiService>().redeemKomisi(
                                            locator.get<UserAppidCubit>().state.userAppId.appId
                                          ).then((value) {
                                            Navigator.of(context).pop();
                                            locator.get<LocalNotificationService>().showLocalNotification(
                                              title: "Penukaran Komisi", 
                                              body: "Komisi anda berhasil ditukar untuk menjadi saldo applikasi."
                                            );
                                          }).catchError((e) {
                                            context.pop();
          
                                            showDynamicSnackBar(
                                              context, 
                                              LineIcons.exclamationTriangle, 
                                              "ERROR", 
                                              e.toString(), 
                                              Colors.red
                                            );
                                          });
                                        },
                                        child: Text("Tukar", style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                        ),)
                                      ),
                                    ],
                                  );
                                }
                              );
                            }, 
                            width: 100.w, 
                            height: 50
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18,),
                  Expanded(
                    child: BlocBuilder<KomisiCubit, KomisiState>(
                      builder: (_, state) {
                        if(state.isLoading) {
                          return const ShimmerListComponent(isScrollable: false);
                        } else {
                          if(state.dataList.isEmpty) {
                            return const NoDataComponent(label: "Tidak Ada Data Komisi.");
                          } else {
                            return ListView.separated(
                              padding: const EdgeInsets.all(8),
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if(index < state.dataList.length) {
                                  return KomisiItemComponent(
                                    amount: state.dataList[index].jumlah!,
                                    keterangan: state.dataList[index].keterangan!,
                                    waktu: state.dataList[index].waktu!,
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
                              itemCount: state.dataList.length
                            );
                          }
                        }
                      }
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}