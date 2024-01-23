import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/history_transfer_response.dart';
import 'package:adamulti_mobile_clone_new/services/history_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'history_transfer_state.dart';

class HistoryTransferCubit extends Cubit<HistoryTransferState> {
  HistoryTransferCubit() : super(const HistoryTransferInitial(
    dataListState: [],
    isLoadingState: true
  ));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
  var term = "";

  void updateState(List<HistoryTransferData> dataListState, bool isLoadingState) {
    emit(HistoryTransferInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void refresh(List<DateTime?> dates) {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";

    updateState([], true);

    locator.get<HistoryService>().getHistoryTransfer(
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

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistoryTransferInitial(dataListState: [], isLoadingState: true));
  }
}
