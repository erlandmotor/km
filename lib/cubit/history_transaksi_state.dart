part of 'history_transaksi_cubit.dart';

sealed class HistoryTransaksiState extends Equatable {
  const HistoryTransaksiState({  required this.dataList, required this.isLoading });

  final List<HistoryTransaksiData> dataList;
  final bool isLoading;

  @override
  List<Object> get props => [
    dataList,
    isLoading
  ];
}

final class HistoryTransaksiInitial extends HistoryTransaksiState {
  final List<HistoryTransaksiData> dataListState;
  final bool isLoadingState;

  const HistoryTransaksiInitial({ required this.dataListState, required this.isLoadingState }) :
  super(dataList: dataListState, isLoading: isLoadingState);
}
