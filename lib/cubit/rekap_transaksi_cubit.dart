import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/rekap_transaksi_response.dart';
import 'package:adamulti_mobile_clone_new/services/history_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'rekap_transaksi_state.dart';

class RekapTransaksiCubit extends Cubit<RekapTransaksiState> {
  RekapTransaksiCubit() : super(const RekapTransaksiInitial(isLoadingState: true, dataListState: []));

  var listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];

  void updateState(List<RekapTransaksiData> dataListState, bool isLoadingState) {
    emit(RekapTransaksiInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void refresh(List<DateTime?> dates) {
    listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];

    updateState([], true);

    locator.get<HistoryService>().getRekapTransaksi(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      DateFormat("y-MM-dd").format(dates[0]!), 
      DateFormat("y-MM-dd").format(dates[1]!)
    ).then((value) {
      updateState(
        value.data!, 
        false
      );
    });
  }

  void resetState() {
    listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];
    emit(const RekapTransaksiInitial(dataListState: [], isLoadingState: true));
  }
}
