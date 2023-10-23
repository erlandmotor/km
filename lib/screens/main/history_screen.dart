import "package:adamulti_mobile_clone_new/components/container_gradient_background.dart";
import "package:adamulti_mobile_clone_new/components/dynamic_snackbar.dart";
import "package:adamulti_mobile_clone_new/components/loading_button_component.dart";
import "package:adamulti_mobile_clone_new/components/regular_textfield_without_validators_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/history_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/rekap_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/search_history_cubit.dart";
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
import "package:intl/intl.dart";
import "package:line_icons/line_icons.dart";
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import "package:responsive_sizer/responsive_sizer.dart";

class HistoryScreen extends StatefulWidget {

  const HistoryScreen({ super.key });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  final popupMenuController = CustomPopupMenuController();

  final searchController = TextEditingController();
  final searchDateRangeController = TextEditingController();

  var listOfCurrentDateTime = <DateTime?>[DateTime.now()];

  var currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    popupMenuController.dispose();
    searchController.dispose();
    searchDateRangeController.dispose();
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
                height: 120,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Riwayat", style: GoogleFonts.inter(
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
                                          prefixIcon: LineIcons.search,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  }
                                ),
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
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];       
                                                popupMenuController.hideMenu();
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                historyTransaksiCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                              }).catchError((e) {
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                popupMenuController.hideMenu();
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                showDynamicSnackBar(
                                                  context,
                                                  LineIcons.exclamationTriangle,
                                                  "ERROR",
                                                  e.toString(),
                                                  Colors.red
                                                );  
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
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                historySaldoCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                              }).catchError((e) {
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  LineIcons.exclamationTriangle,
                                                  "ERROR",
                                                  e.toString(),
                                                  Colors.red
                                                );  
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
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                rekapTransaksiCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                              }).catchError((e) {
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  LineIcons.exclamationTriangle,
                                                  "ERROR",
                                                  e.toString(),
                                                  Colors.red
                                                );  
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
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                historyTopupSaldoCubit.updateState(
                                                  value.data!, 
                                                  false
                                                );
                                              }).catchError((e) {
                                                listOfCurrentDateTime = <DateTime?>[DateTime.now()];
                                                searchHistoryCubit.updateState(false, searchHistoryCubit.state.currentIndex);
                                                popupMenuController.hideMenu();
                                                showDynamicSnackBar(
                                                  context,
                                                  LineIcons.exclamationTriangle,
                                                  "ERROR",
                                                  e.toString(),
                                                  Colors.red
                                                );  
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
                      
                      child: const Icon(Icons.search_outlined, size: 32, color: Colors.white,)
                    )
                  ],
                ),
              ),
              const SizedBox(height: 22,),
              Expanded(
                child: DefaultTabController(
                  length: 5, 
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        ButtonsTabBar(
                          onTap: (index) {
                            currentTabIndex = index;
                            final searchHistoryCubit = context.read<SearchHistoryCubit>();
                            searchHistoryCubit.updateState(false, index);
                            
                            if(index == 0) {
                              final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
                              historyTransaksiCubit.resetState();
                            }
                            if(index == 1) {
                              final historySaldoCubit = context.read<HistorySaldoCubit>();
                              historySaldoCubit.resetState();
                            }

                            if(index == 2) {
                              final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();
                              rekapTransaksiCubit.resetState();
                            }

                            if(index == 3) {
                              final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
                              historyTopupSaldoCubit.resetState();
                            }
                          },
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
                              icon: Icon(LineIcons.wavyMoneyBill),
                              text: 'Transaksi',
                            ),
                            Tab(
                              icon: Icon(LineIcons.wallet),
                              text: 'Saldo',
                            ),
                            Tab(
                              icon: Icon(LineIcons.fileInvoiceWithUsDollar),
                              text: 'Rekap Transaksi',
                            ),
                            Tab(
                              icon: Icon(LineIcons.handHoldingUsDollar),
                              text: 'Topup Saldo',
                            ),
                            Tab(
                              icon: Icon(LineIcons.alternateMoneyCheck),
                              text: 'Transfer Saldo',
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        const Expanded(
                          child: TabBarView(
                            children: [
                              TransaksiHistoryTab(),
                              SaldoHistoryTab(),
                              RekapTransaksiTab(),
                              TopupSaldoHistoryTab(),
                              TransferSaldoHistoryTab()
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          )
        ],
      )
    );
  }
}