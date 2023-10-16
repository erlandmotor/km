import 'package:adamulti_mobile_clone_new/model/history_transaksi_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_transaksi_state.dart';

class HistoryTransaksiCubit extends Cubit<HistoryTransaksiState> {
  HistoryTransaksiCubit() : super(const HistoryTransaksiInitial(
    currentPageState: "1",
    dataListState: [],
    isLoadingState: true
  ));

  void updateState(String currentPageState, List<HistoryTransaksiData> dataListState, bool isLoadingState) {
    emit(HistoryTransaksiInitial(currentPageState: currentPageState, dataListState: dataListState, isLoadingState: isLoadingState));
  }
}
