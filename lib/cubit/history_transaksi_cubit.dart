import 'package:adamulti_mobile_clone_new/model/history_transaksi_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_transaksi_state.dart';

class HistoryTransaksiCubit extends Cubit<HistoryTransaksiState> {
  HistoryTransaksiCubit() : super(const HistoryTransaksiInitial(
    dataListState: [],
    isLoadingState: true
  ));

  var currentPage = 1;
  var listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
  DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
  var term = "";

  void updateState(List<HistoryTransaksiData> dataListState, bool isLoadingState) {
    emit(HistoryTransaksiInitial(dataListState: dataListState, isLoadingState: isLoadingState));
  }

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistoryTransaksiInitial(dataListState: [], isLoadingState: true));
  }
}
