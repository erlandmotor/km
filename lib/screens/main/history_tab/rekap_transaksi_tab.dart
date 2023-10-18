import "package:adamulti_mobile_clone_new/components/rekap_transaksi_item_component.dart";
import "package:adamulti_mobile_clone_new/components/shimmer_list_component.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:adamulti_mobile_clone_new/cubit/rekap_transaksi_cubit.dart";
import "package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart";
import "package:adamulti_mobile_clone_new/function/custom_function.dart";
import "package:adamulti_mobile_clone_new/locator.dart";
import "package:adamulti_mobile_clone_new/services/history_service.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class RekapTransaksiTab extends StatefulWidget {

  const RekapTransaksiTab({ super.key });

  @override
  State<RekapTransaksiTab> createState() => _RekapTransaksiTabState();
}

class _RekapTransaksiTabState extends State<RekapTransaksiTab> {

  final scrollController = ScrollController();

  @override
  void initState() {
    final rekapTransaksiCubit = context.read<RekapTransaksiCubit>();

    locator.get<HistoryService>().getRekapTransaksi(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      DateFormat("y-MM-dd").format(rekapTransaksiCubit.listOfCurrentDateTime[0]!), 
      DateFormat("y-MM-dd").format(rekapTransaksiCubit.listOfCurrentDateTime[1]!)
    ).then((value) {
      rekapTransaksiCubit.updateState(
        value.data!, 
        false
      );
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
      clipBehavior: Clip.none,
      children: [
        BlocBuilder<RekapTransaksiCubit, RekapTransaksiState>(
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
                      Text("Tidak Ada Data Penggunaan Saldo", style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,)
                    ],
                  )
                );
              } else {
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 100),
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return RekapTransaksiItemComponent(
                      imageUrl: state.dataList[index].imgurl!.isEmpty ? state.dataList[index].imageproduk! : state.dataList[index].imgurl!,
                      kodeProduk: state.dataList[index].kodeproduk!,
                      namaProduk: state.dataList[index].namaproduk!,
                      total: state.dataList[index].total!,
                      jumlah: state.dataList[index].jumlah!,
                    );
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
        Positioned(
          bottom: 0,
          child: BlocBuilder<RekapTransaksiCubit, RekapTransaksiState>(
            builder: (_, state) {
              final mappedTotalDataList = state.dataList.map((e) => e.total).toList();
              final total = mappedTotalDataList.fold(0, (prev, next) => prev + next!);

              final mappedJumlahDataList = state.dataList.map((e) => e.jumlah).toList();
              final jumlah = mappedJumlahDataList.fold(0, (prev, next) => prev + next!);

              return Container(
                color: kMainLightThemeColor,
                width: 100.w,
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total Transaksi ($jumlah) :", style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),),
                    Text(FormatCurrency.convertToIdr(total, 0), style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),),
                  ],
                ),
              );
            },
          )
        )
      ],
    );
  }
}