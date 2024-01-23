import 'package:adamulti_mobile_clone_new/cubit/user_appid_cubit.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/history_saldo_response.dart';
import 'package:adamulti_mobile_clone_new/services/history_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'history_saldo_state.dart';

class HistorySaldoCubit extends Cubit<HistorySaldoState> {
  HistorySaldoCubit() : super(const HistorySaldoInitial(isLoadingState: true, dataListState: []));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime.now(), DateTime.now()];
  var term = "";

  void updateState(List<HistorySaldoData> dataListState, bool isLoadingState) {
    emit(HistorySaldoInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void refresh(List<DateTime?> dates) {
    currentPage = 1;
    term = "";

    emit(const HistorySaldoInitial(dataListState: [], isLoadingState: true));
    
    locator.get<HistoryService>().getHistorySaldo(
      locator.get<UserAppidCubit>().state.userAppId.appId, 
      "10", 
      term, 
      currentPage.toString(), 
      DateFormat("y-MM-dd").format(dates[0]!), 
      DateFormat("y-MM-dd").format(dates[1]!)
    ).then((value) {
      emit(HistorySaldoInitial(dataListState: value.data!, isLoadingState: false));
    });
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistorySaldoInitial(dataListState: [], isLoadingState: true));
  }
}
