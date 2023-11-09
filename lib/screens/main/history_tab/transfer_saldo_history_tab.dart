import "package:adamulti_mobile_clone_new/components/history_transfer_item_component.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transfer_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

class TransferSaldoHistoryTab extends StatefulWidget {

  const TransferSaldoHistoryTab({ super.key });

  @override
  State<TransferSaldoHistoryTab> createState() => _TransferSaldoHistoryTabState();
}

class _TransferSaldoHistoryTabState extends State<TransferSaldoHistoryTab> {
  final scrollController = ScrollController();

  @override
  void initState() {
    final historyTransferCubit = context.read<HistoryTransferCubit>();
    locator.get<HistoryService>().getHistoryTransfer(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      historyTransferCubit.term, 
      historyTransferCubit.currentPage.toString(), 
      DateFormat("y-MM-dd").format(historyTransferCubit.listOfCurrentDateTime[0]!), 
      DateFormat("y-MM-dd").format(historyTransferCubit.listOfCurrentDateTime[1]!)
    ).then((value) {
      historyTransferCubit.updateState(
        value.data!, 
        false
      );
    });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        historyTransferCubit.currentPage += 1;
        locator.get<HistoryService>().getHistoryTransfer(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          "10", 
          historyTransferCubit.term, 
          historyTransferCubit.currentPage.toString(), 
          DateFormat("y-MM-dd").format(historyTransferCubit.listOfCurrentDateTime[0]!), 
          DateFormat("y-MM-dd").format(historyTransferCubit.listOfCurrentDateTime[1]!)
        ).then((value) {
          historyTransferCubit.updateState(
            [...historyTransferCubit.state.dataList, ...value.data!], 
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
    return BlocBuilder<HistoryTransferCubit, HistoryTransferState>(
      builder: (_, state) {
        if(state.isLoading) {
          return const ShimmerListComponent(isScrollable: false);
        } else {
          if(state.dataList.isEmpty) {
            return const NoDataComponent(
              label: "Tidak Ada Data Transfer."
            );
          } else {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if(index < state.dataList.length) {
                  return HistoryTransferItemComponent(
                    idreseller: state.dataList[index].idreseller!,
                    namaReseller: state.dataList[index].namareseller!,
                    jumlah: state.dataList[index].jumlah!,
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
    );
  }
}