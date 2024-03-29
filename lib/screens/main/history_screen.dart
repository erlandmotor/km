import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/light_decoration_container_component.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_validators_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/history_calendar_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transfer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/rekap_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/search_history_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/setting_applikasi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/rekap_transaksi_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/saldo_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/topup_saldo_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/transaksi_history_tab.dart";
import "package:adamulti_mobile_clone_new/screens/main/history_tab/transfer_saldo_history_tab.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:buttons_tabbar/buttons_tabbar.dart";
import "package:custom_pop_up_menu/custom_pop_up_menu.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:iconsax/iconsax.dart";
import "package:intl/intl.dart";
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import "package:responsive_sizer/responsive_sizer.dart";

class HistoryScreen extends StatefulWidget {

  const HistoryScreen({ super.key });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {

  final popupMenuController = CustomPopupMenuController();

  final searchController = TextEditingController();
  final searchDateRangeController = TextEditingController();

  late final TabController tabController;

  var listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];

  var currentTabIndex = 0;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);

    final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
    historyTransaksiCubit.refresh(listOfCurrentDateTime);
    
    final historySaldoCubit = context.read<HistorySaldoCubit>();
    final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();
    final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
    final historyTransferCubit = context.read<HistoryTransferCubit>();
    
    final searchHistoryCubit = context.read<SearchHistoryCubit>();

    tabController.addListener(() { 
      if(!tabController.indexIsChanging) {
        currentTabIndex = tabController.index;

        searchHistoryCubit.updateState(false, currentTabIndex);
        if(currentTabIndex == 0) {
          historyTransaksiCubit.refresh(listOfCurrentDateTime);

          historySaldoCubit.updateState([], true);
          rekapTransaksiCubit.updateState([], true);
          historyTopupSaldoCubit.updateState([], true);
          historyTransferCubit.updateState([], true);
        }
        if(currentTabIndex == 1) {
          historySaldoCubit.refresh(listOfCurrentDateTime);

          historyTransaksiCubit.updateState([], true);
          rekapTransaksiCubit.updateState([], true);
          historyTopupSaldoCubit.updateState([], true);
          historyTransferCubit.updateState([], true);
        }

        if(currentTabIndex == 2) {
          rekapTransaksiCubit.refresh(listOfCurrentDateTime);

          historySaldoCubit.updateState([], true);
          historyTransaksiCubit.updateState([], true);
          historyTopupSaldoCubit.updateState([], true);
          historyTransferCubit.updateState([], true);
        }

        if(currentTabIndex == 3) {
          historyTopupSaldoCubit.refresh(listOfCurrentDateTime);

          historySaldoCubit.updateState([], true);
          rekapTransaksiCubit.updateState([], true);
          historyTransaksiCubit.updateState([], true);
          historyTransferCubit.updateState([], true);
        }

        if(currentTabIndex == 4) {
          historyTransferCubit.refresh(listOfCurrentDateTime);

          historySaldoCubit.updateState([], true);
          rekapTransaksiCubit.updateState([], true);
          historyTopupSaldoCubit.updateState([], true);
          historyTransaksiCubit.updateState([], true);
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    popupMenuController.dispose();
    searchController.dispose();
    searchDateRangeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final historyCalendarCubit = context.read<HistoryCalendarCubit>();

    return ContainerGradientBackground(
      child: Stack(
        children: [
          const Column(
            children: [
              SizedBox(
                height: 130,
              ),
              Expanded(
                child: LightDecorationContainerComponent()
              )
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 18,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Riwayat", style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                    CustomPopupMenu(
                      position: PreferredPosition.bottom,
                      controller: popupMenuController,
                      menuBuilder: () {
                        return GestureDetector(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Container(
                            width: 90.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
                                  bloc: context.read<SearchHistoryCubit>(),
                                  builder: (_, state) {
                                    if(state.currentIndex != 2) {
                                      return Padding(
                                        padding: const EdgeInsets.all(18),
                                        child: RegularTextFieldWithoutValidatorsComponent(
                                          label: state.currentIndex == 0 ? "ID Pelanggan / No. Tujuan" : "Keterangan",
                                          hint: "Contoh : 082xxx",
                                          controller: searchController,
                                          prefixIcon: Iconsax.search_normal,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<HistoryCalendarCubit, HistoryCalendarState>(
                                        bloc: historyCalendarCubit,
                                        builder: (_, state) {
                                          return Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Tanggal Awal", style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                                  ),),
                                                  const SizedBox(height: 2,),
                                                  Text(DateFormat("dd MMM yyyy").format(state.selectedDateTimes[0]!), style: GoogleFonts.openSans(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                                  ),),
                                                ],
                                              ),
                                              const SizedBox(width: 8,),
                                              Column(
                                                children: [
                                                  const SizedBox(height: 18,),
                                                  Text("-", style: GoogleFonts.openSans(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                                  ),),
                                                ],
                                              ),
                                              const SizedBox(width: 8,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Tanggal Akhir", style: GoogleFonts.openSans(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.lightTextColor!)
                                                  ),),
                                                  const SizedBox(height: 2,),
                                                  if(state.selectedDateTimes.length > 1) Text(DateFormat("dd MMM yyyy").format(state.selectedDateTimes[1]!), style: GoogleFonts.openSans(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.infoColor!)
                                                  ),),
                                                ],
                                              ),
                                            ],
                                          );
                                        } 
                                      )
                                    ],
                                  ),
                                ),
                                CalendarDatePicker2(
                                  config: CalendarDatePicker2Config(
                                    calendarType: CalendarDatePicker2Type.range,
                                  ), 
                                  value: listOfCurrentDateTime,
                                  onValueChanged: (value) {
                                    historyCalendarCubit.updateState(value);
                                    listOfCurrentDateTime = value;
                                    if(currentTabIndex == 0) {
                                      final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
                                      historyTransaksiCubit.listOfCurrentDateTime = value;
                                    }

                                    if(currentTabIndex == 1) {
                                      final historySaldoCubit = context.read<HistorySaldoCubit>();
                                      historySaldoCubit.listOfCurrentDateTime = value;
                                    }

                                    if(currentTabIndex == 2) {
                                      final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();
                                      rekapTransaksiCubit.listOfCurrentDateTime = value;
                                    }

                                    if(currentTabIndex == 3) {
                                      final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
                                      historyTopupSaldoCubit.listOfCurrentDateTime = value;
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: BlocBuilder<SearchHistoryCubit, SearchHistoryState>(
                                    bloc: context.read<SearchHistoryCubit>(),
                                    builder: (_, state) {
                                      final searchHistoryCubit = context.read<SearchHistoryCubit>();
                                
                                      return LoadingButtonComponent(
                                        label: "Cari", 
                                        buttonColor: HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.secondaryColor!), 
                                        onPressed: () {                 
                                          if(listOfCurrentDateTime.length < 2) {
                                            showDynamicSnackBar(
                                              context,
                                              Iconsax.warning_2,
                                              "ERROR",
                                              "Tanggal Awal dan Tanggal Tujuan Harus Dipilih.",
                                              HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                            );
                                          } else {
                                            searchHistoryCubit.updateState(true, searchHistoryCubit.state.currentIndex);
                                                  
                                            // Search Logic
                                            if(currentTabIndex == 0) {
                                              final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
                                              historyTransaksiCubit.resetState();
                                              historyTransaksiCubit.listOfCurrentDateTime = listOfCurrentDateTime;
                                              historyTransaksiCubit.term = searchController.text;
                                
                                              locator.get<HistoryService>().getHistoryTransaksi(
                                                locator.get<UserAppidCubit>().state.userAppId.appId,
                                                "10",
                                                historyTransaksiCubit.term,
                                                historyTransaksiCubit.currentPage.toString(), 
                                                DateFormat("y-MM-dd").format(historyTransaksiCubit.listOfCurrentDateTime[0]!), 
                                                DateFormat("y-MM-dd").format(historyTransaksiCubit.listOfCurrentDateTime[1]!)
                                              ).then((value) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];       
                                                popupMenuController.hideMenu();
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                historyTransaksiCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);
                                              }).catchError((e) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                popupMenuController.hideMenu();
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                showDynamicSnackBar(
                                                  context,
                                                  Iconsax.warning_2,
                                                  "ERROR",
                                                  e.toString(),
                                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                );  
                                                // historyCalendarCubit.updateState([DateTime.now()]);
                                              });
                                            }
                                
                                            if(currentTabIndex == 1) {
                                              final historySaldoCubit = context.read<HistorySaldoCubit>();
                                              historySaldoCubit.resetState();
                                              historySaldoCubit.listOfCurrentDateTime = listOfCurrentDateTime;
                                              historySaldoCubit.term = searchController.text;
                                
                                              locator.get<HistoryService>().getHistorySaldo(
                                                locator.get<UserAppidCubit>().state.userAppId.appId,
                                                "10",
                                                historySaldoCubit.term,
                                                historySaldoCubit.currentPage.toString(), 
                                                DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[0]!), 
                                                DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[1]!)
                                              ).then((value) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                historySaldoCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);
                                              }).catchError((e) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  Iconsax.warning_2,
                                                  "ERROR",
                                                  e.toString(),
                                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);  
                                              });
                                            }
                                
                                            if(currentTabIndex == 2) {
                                              final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();
                                              rekapTransaksiCubit.resetState();
                                              rekapTransaksiCubit.listOfCurrentDateTime = listOfCurrentDateTime;
                                
                                              locator.get<HistoryService>().getRekapTransaksi(
                                                locator.get<UserAppidCubit>().state.userAppId.appId, 
                                                DateFormat("y-MM-dd").format(rekapTransaksiCubit.listOfCurrentDateTime[0]!), 
                                                DateFormat("y-MM-dd").format(rekapTransaksiCubit.listOfCurrentDateTime[1]!)
                                              ).then((value) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                rekapTransaksiCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);
                                              }).catchError((e) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  Iconsax.warning_2,
                                                  "ERROR",
                                                  e.toString(),
                                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);  
                                              });
                                            }
                                
                                            if(currentTabIndex == 3) {
                                              final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
                                              historyTopupSaldoCubit.resetState();
                                              historyTopupSaldoCubit.listOfCurrentDateTime = listOfCurrentDateTime;
                                              historyTopupSaldoCubit.term = searchController.text;
                                
                                              locator.get<HistoryService>().getHistoryTopup(
                                                locator.get<UserAppidCubit>().state.userAppId.appId,
                                                "10",
                                                historyTopupSaldoCubit.term,
                                                historyTopupSaldoCubit.currentPage.toString(), 
                                                DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[0]!), 
                                                DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[1]!)
                                              ).then((value) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                historyTopupSaldoCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);
                                              }).catchError((e) {
                                                // listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  Iconsax.warning_2,
                                                  "ERROR",
                                                  e.toString(),
                                                  HexColor.fromHex(locator.get<SettingApplikasiCubit>().state.settingData.errorColor!)
                                                );
                                                // historyCalendarCubit.updateState([DateTime.now()]);  
                                              });
                                            }
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
                          ),
                        );
                      }, 
                      pressType: PressType.singleClick,
                      verticalMargin: 10,
                      horizontalMargin: 10,
                      arrowColor: Colors.white,
                      barrierColor: Colors.black54,
                      showArrow: true,
                      
                      child: const Icon(Iconsax.search_normal_1, color: Colors.white,)
                    )
                  ],
                ),
              ),
              const SizedBox(height: 22,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(
                    children: [
                      BlocBuilder<SettingApplikasiCubit, SettingApplikasiState>(
                        bloc: locator.get<SettingApplikasiCubit>(),
                        builder: (_, state) {
                          return ButtonsTabBar(
                            controller: tabController,
                            onTap: (index) {
                              // currentTabIndex = index;
                              // final searchHistoryCubit = context.read<SearchHistoryCubit>();
                              // searchHistoryCubit.updateState(false, index);
                              
                              // if(index == 0) {
                              //   final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
                              //   historyTransaksiCubit.resetState();
                              // }
                              // if(index == 1) {
                              //   final historySaldoCubit = context.read<HistorySaldoCubit>();
                              //   historySaldoCubit.resetState();
                              // }

                              // if(index == 2) {
                              //   final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();
                              //   rekapTransaksiCubit.resetState();
                              // }

                              // if(index == 3) {
                              //   final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
                              //   historyTopupSaldoCubit.resetState();
                              // }
                            },
                            radius: 18,
                            contentPadding: const EdgeInsets.all(8),
                            height: 46,
                            labelSpacing: 4,
                            buttonMargin: const EdgeInsets.symmetric(horizontal: 8),
                            backgroundColor: HexColor.fromHex(state.settingData.secondaryColor!),
                            unselectedBackgroundColor: HexColor.fromHex(state.settingData.lightColor!),
                            borderColor: HexColor.fromHex(state.settingData.secondaryColor!),
                            borderWidth: 0,
                            unselectedBorderColor: HexColor.fromHex(state.settingData.secondaryColor!),
                            labelStyle: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                            unselectedLabelStyle: GoogleFonts.openSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: HexColor.fromHex(state.settingData.textColor!)
                            ),
                            tabs: const [
                              Tab(
                                icon: Icon(Iconsax.money_tick),
                                text: 'Transaksi',
                              ),
                              Tab(
                                icon: Icon(Iconsax.wallet_money),
                                text: 'Saldo',
                              ),
                              Tab(
                                icon: Icon(Iconsax.receipt_edit),
                                text: 'Rekap Transaksi',
                              ),
                              Tab(
                                icon: Icon(Iconsax.empty_wallet_add),
                                text: 'Topup Saldo',
                              ),
                              Tab(
                                icon: Icon(Iconsax.card_send),
                                text: 'Transfer Saldo',
                              ),
                            ],
                          );
                        }
                      ),
                      const SizedBox(height: 30,),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: const [                              
                            TransaksiHistoryTab(),
                            SaldoHistoryTab(),
                            RekapTransaksiTab(),
                            TopupSaldoHistoryTab(),
                            TransferSaldoHistoryTab(),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          )
        ],
      )
    );
  }
}