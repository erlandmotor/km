part of 'history_saldo_cubit.dart';

sealed class HistorySaldoState extends Equatable {
  const HistorySaldoState({ required this.isLoading, required this.dataList });

  final bool isLoading;
  final List<HistorySaldoData> dataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList
  ];
}

final class HistorySaldoInitial extends HistorySaldoState {
  final bool isLoadingState;
  final List<HistorySaldoData> dataListState;

  const HistorySaldoInitial({ required this.isLoadingState, required this.dataListState }) :
  super(isLoading: isLoadingState, dataList: dataListState);
}
