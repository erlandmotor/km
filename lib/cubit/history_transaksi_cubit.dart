import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/history_transaksi_response.dart';
import 'package:adamulti_mobile_clone_new/services/history_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'history_transaksi_state.dart';

class HistoryTransaksiCubit extends Cubit<HistoryTransaksiState> {
  HistoryTransaksiCubit() : super(const HistoryTransaksiInitial(
    dataListState: [],
    isLoadingState: true
  ));

  // var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  // DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];
  var term = "";

  void updateState(List<HistoryTransaksiData> dataListState, bool isLoadingState) {
    emit(HistoryTransaksiInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];
    term = "";
    emit(const HistoryTransaksiInitial(dataListState: [], isLoadingState: true));
  }

  void refresh(List<DateTime?> dates) {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];
    term = "";

    updateState([], true);
    
    locator.get<HistoryService>().getHistoryTransaksi(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      term, 
      currentPage.toString(), 
      DateFormat("y-MM-dd").format(dates[0]!), 
      DateFormat("y-MM-dd").format(dates[1]!)
    ).then((value) {
      updateState(
        value.data!, 
        false
      );
    });

  }
}
