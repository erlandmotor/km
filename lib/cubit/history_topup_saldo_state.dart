part of 'history_topup_saldo_cubit.dart';

sealed class HistoryTopupSaldoState extends Equatable {
  const HistoryTopupSaldoState({ required this.isLoading, required this.dataList });

  final bool isLoading;
  final List<HistoryTopupData> dataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList
  ];
}

final class HistoryTopupSaldoInitial extends HistoryTopupSaldoState {
  final bool isLoadingState;
  final List<HistoryTopupData> dataListState;

  const HistoryTopupSaldoInitial({ required this.isLoadingState, required this.dataListState }) : super(
    isLoading: isLoadingState,
    dataList: dataListState
  );
}
