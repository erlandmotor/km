import 'package:adamulti_mobile_clone_new/model/history_topup_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_topup_saldo_state.dart';

class HistoryTopupSaldoCubit extends Cubit<HistoryTopupSaldoState> {
  HistoryTopupSaldoCubit() : super(const HistoryTopupSaldoInitial(isLoadingState: true, dataListState: []));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
  var term = "";

  void updateState(List<HistoryTopupData> dataListState, bool isLoadingState) {
    emit(HistoryTopupSaldoInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistoryTopupSaldoInitial(dataListState: [], isLoadingState: true));
  }
}
