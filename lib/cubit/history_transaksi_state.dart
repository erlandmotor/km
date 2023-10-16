part of 'history_transaksi_cubit.dart';

sealed class HistoryTransaksiState extends Equatable {
  const HistoryTransaksiState({ required this.currentPage, required this.dataList, required this.isLoading });

  final String currentPage;
  final List<HistoryTransaksiData> dataList;
  final bool isLoading;

  @override
  List<Object> get props => [
    currentPage,
    dataList
  ];
}

final class HistoryTransaksiInitial extends HistoryTransaksiState {
  final String currentPageState;
  final List<HistoryTransaksiData> dataListState;
  final bool isLoadingState;

  const HistoryTransaksiInitial({ required this.currentPageState, required this.dataListState, required this.isLoadingState }) :
  super(currentPage: currentPageState, dataList: dataListState, isLoading: isLoadingState);
}
