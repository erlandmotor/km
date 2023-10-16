import "package:adamulti_mobile_clone_new/components/history_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/cubit/history_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

class TransaksiHistoryTab extends StatefulWidget {

  const TransaksiHistoryTab({ super.key });

  @override
  State<TransaksiHistoryTab> createState() => _TransaksiHistoryTabState();
}

class _TransaksiHistoryTabState extends State<TransaksiHistoryTab> {

  final scrollController = ScrollController();

  var startOfDate = "";
  var endOfDate = "";

  @override
  void initState() {
    final now = DateTime.now();
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    startOfDate = "2023-07-01";
    endOfDate = DateFormat("y-MM-d").format(lastDayOfMonth);

    final historyTransaksiCubit = context.read<HistoryTransaksiCubit>();

    locator.get<HistoryService>().getHistoryTransaksi(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      "", 
      historyTransaksiCubit.state.currentPage, 
      startOfDate, 
      endOfDate
    ).then((value) {
      historyTransaksiCubit.updateState(
        historyTransaksiCubit.state.currentPage, 
        value.data!, 
        false
      );
    });

    scrollController.addListener(() {
      
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
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/no_data.png"),
                  const SizedBox(height: 10,),
                  Text("Tidak Ada Data Transaksi", style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,)
                ],
              )
            );
          } else {
            return ListView.separated(
              itemBuilder: (context, index) {
                return HistoryTransaksiItemComponent(
                  kodeTujuan: state.dataList[index].kodetujuan!, 
                  amount: state.dataList[index].harga!, 
                  sn: state.dataList[index].sn!, 
                  waktu: state.dataList[index].waktu!, 
                  statusText: state.dataList[index].statustext!, 
                  statusTransaksi: state.dataList[index].statustransaksi!.toString()
                );
              }, 
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8,);
              }, 
              itemCount: state.dataList.length  
            );
          }
        }
      }
    );
  }
}