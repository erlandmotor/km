import 'package:adamulti_mobile_clone_new/model/history_saldo_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_saldo_state.dart';

class HistorySaldoCubit extends Cubit<HistorySaldoState> {
  HistorySaldoCubit() : super(const HistorySaldoInitial(isLoadingState: true, dataListState: []));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
  var term = "";

  void updateState(List<HistorySaldoData> dataListState, bool isLoadingState) {
    emit(HistorySaldoInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistorySaldoInitial(dataListState: [], isLoadingState: true));
  }
}
