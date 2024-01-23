import "package:adamulti_mobile_clone_new/components/history_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:intl/intl.dart";

class TransaksiHistoryTab extends StatefulWidget {

  const TransaksiHistoryTab({ super.key });

  @override
  State<TransaksiHistoryTab> createState() => _TransaksiHistoryTabState();
}

class _TransaksiHistoryTabState extends State<TransaksiHistoryTab> {

  final scrollController = ScrollController();

  @override
  void initState() {
    final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();
    // historyTransaksiCubit.refresh();
    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        historyTransaksiCubit.currentPage += 1;
        locator.get<HistoryService>().getHistoryTransaksi(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          "10", 
          historyTransaksiCubit.term, 
          historyTransaksiCubit.currentPage.toString(), 
          DateFormat("y-MM-dd").format(historyTransaksiCubit.listOfCurrentDateTime[0]!), 
          DateFormat("y-MM-dd").format(historyTransaksiCubit.listOfCurrentDateTime[1]!)
        ).then((value) {
          historyTransaksiCubit.updateState(
            [...historyTransaksiCubit.state.dataList, ...value.data!], 
            false
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
    return BlocBuilder<HistoryTransaksiCubit, HistoryTransaksiState>(
      builder: (_, state) {
        if(state.isLoading) {
          return const ShimmerListComponent(isScrollable: false);
        } else {
          if(state.dataList.isEmpty) {
            return const NoDataComponent(
              label: "Tidak Ada Data Transaksi."
            );
          } else {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if(index < state.dataList.length) {
                  return HistoryTransaksiItemComponent(
                    kodeTujuan: state.dataList[index].kodetujuan!, 
                    amount: state.dataList[index].harga!, 
                    sn: state.dataList[index].sn!, 
                    waktu: state.dataList[index].waktu!, 
                    statusText: state.dataList[index].statustext!, 
                    statusTransaksi: state.dataList[index].statustransaksi!.toString(),
                    onTapAction: () {
                      if(state.dataList[index].statustransaksi! != 2) {
                        context.pushNamed("transaction-detail", extra: {
                          'idtrx': state.dataList[index].idtransaksi!.toString(),
                          'type': 'HISTORY',
                          'total': state.dataList[index].harga!
                        });
                      }
                    },
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
    );
  }
}