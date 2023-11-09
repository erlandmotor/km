import 'package:adamulti_mobile_clone_new/model/history_transfer_response.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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

  void resetState() {
    currentPage = 1;
    listOfCurrentDateTime = <DateTime?>[DateTime(DateTime.now().year, DateTime.now().month, 1), 
    DateTime(DateTime.now().year, DateTime.now().month + 1, 0)];
    term = "";
    emit(const HistoryTransferInitial(dataListState: [], isLoadingState: true));
  }
}
