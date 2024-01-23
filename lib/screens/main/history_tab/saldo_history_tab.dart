import "package:adamulti_mobile_clone_new/components/history_saldo_item_component.dart";
import "package:adamulti_mobile_clone_new/components/no_data_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/history_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";

class SaldoHistoryTab extends StatefulWidget {

  const SaldoHistoryTab({ super.key });

  @override
  State<SaldoHistoryTab> createState() => _SaldoHistoryTabState();
}

class _SaldoHistoryTabState extends State<SaldoHistoryTab> {

  final scrollController = ScrollController();

  @override
  void initState() {
    final historySaldoCubit = context.read<HistorySaldoCubit>();

    // locator.get<HistoryService>().getHistorySaldo(
    //   locator.get<UserAppidCubit>().state.userAppId.appId, 
    //   "10", 
    //   historySaldoCubit.term, 
    //   historySaldoCubit.currentPage.toString(), 
    //   DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[0]!), 
    //   DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[1]!)
    // ).then((value) {
    //   print(value.toJson());
    //   historySaldoCubit.updateState(
    //     value.data!, 
    //     false
    //   );
    // });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        historySaldoCubit.currentPage += 1;
        locator.get<HistoryService>().getHistorySaldo(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          "10", 
          historySaldoCubit.term, 
          historySaldoCubit.currentPage.toString(), 
          DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[0]!), 
          DateFormat("y-MM-dd").format(historySaldoCubit.listOfCurrentDateTime[1]!)
        ).then((value) {
          historySaldoCubit.updateState(
            [...historySaldoCubit.state.dataList, ...value.data!], 
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
    return BlocBuilder<HistorySaldoCubit, HistorySaldoState>(
      builder: (_, state) {
        if(state.isLoading) {
          return const ShimmerListComponent(isScrollable: false);
        } else {
          if(state.dataList.isEmpty) {
            return const NoDataComponent(label: "Tidak Ada Data Penggunaan Saldo.");
          } else {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if(index < state.dataList.length) {
                  return HistorySaldoItemComponent(
                    keterangan: state.dataList[index].keterangan!, 
                    sisaSaldo: state.dataList[index].sisasaldo!, 
                    jumlah: state.dataList[index].jumlah!, 
                    waktu: state.dataList[index].tanggal!
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