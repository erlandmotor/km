part of 'rekap_transaksi_cubit.dart';

sealed class RekapTransaksiState extends Equatable {
  const RekapTransaksiState({
    required this.isLoading, required this.dataList
  });

  final bool isLoading;
  final List<RekapTransaksiData> dataList;

  @override
  List<Object> get props => [
    isLoading,
    dataList
  ];
}

final class RekapTransaksiInitial extends RekapTransaksiState {
  final bool isLoadingState;
  final List<RekapTransaksiData> dataListState;

  const RekapTransaksiInitial({ required this.isLoadingState, required this.dataListState }) : super(
    isLoading: isLoadingState,
    dataList: dataListState,
  );
}
