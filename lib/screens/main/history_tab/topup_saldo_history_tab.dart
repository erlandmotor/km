import "package:adamulti_mobile_clone_new/components/history_topup_item_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/history_topup_saldo_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

class TopupSaldoHistoryTab extends StatefulWidget {

  const TopupSaldoHistoryTab({ super.key });

  @override
  State<TopupSaldoHistoryTab> createState() => _TopupSaldoHistoryTabState();
}

class _TopupSaldoHistoryTabState extends State<TopupSaldoHistoryTab> {

  final scrollController = ScrollController();

  @override
  void initState() {
    final historyTopupSaldoCubit = context.read<HistoryTopupSaldoCubit>();
    
    locator.get<HistoryService>().getHistoryTopup(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      historyTopupSaldoCubit.term, 
      historyTopupSaldoCubit.currentPage.toString(), 
      DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[0]!), 
      DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[1]!)
    ).then((value) {
      historyTopupSaldoCubit.updateState(
        value.data!, 
        false
      );
    });

    scrollController.addListener(() {
      if(scrollController.position.maxScrollExtent == scrollController.offset) {
        historyTopupSaldoCubit.currentPage += 1;
        locator.get<HistoryService>().getHistoryTopup(
          locator.get<UserAppidCubit>().state.userAppId.appId, 
          "10", 
          historyTopupSaldoCubit.term, 
          historyTopupSaldoCubit.currentPage.toString(), 
          DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[0]!), 
          DateFormat("y-MM-dd").format(historyTopupSaldoCubit.listOfCurrentDateTime[1]!)
        ).then((value) {
          historyTopupSaldoCubit.updateState(
            [...historyTopupSaldoCubit.state.dataList, ...value.data!], 
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
    return BlocBuilder<HistoryTopupSaldoCubit, HistoryTopupSaldoState>(
      builder: (_, state) {
        if(state.isLoading) {
          return const ShimmerListComponent(isScrollable: false);
        } else {
          if(state.dataList.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no-data.jpg"),
                  const SizedBox(height: 10,),
                  Text("Tidak Ada Data Topup", style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,)
                ],
              )
            );
          } else {
            return ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                if(index < state.dataList.length) {
                  return HistoryTopupItemComponent(
                    keterangan: state.dataList[index].keterangan!, 
                    jumlah: state.dataList[index].jumlah!, 
                    waktu: state.dataList[index].waktu!,
                    tanggal: state.dataList[index].tanggal!,
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