part of 'history_transfer_cubit.dart';

sealed class HistoryTransferState extends Equatable {
  const HistoryTransferState({ required this.dataList, required this.isLoading });

  final List<HistoryTransferData> dataList;
  final bool isLoading;

  @override
  List<Object> get props => [
    dataList,
    isLoading
  ];
}

final class HistoryTransferInitial extends HistoryTransferState {

  final List<HistoryTransferData> dataListState;
  final bool isLoadingState;

  const HistoryTransferInitial({ required this.dataListState, required this.isLoadingState }) : 
  super(dataList: dataListState, isLoading: isLoadingState);
}
